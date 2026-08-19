// meeting-banner — a sticky, menubar-height countdown banner for macOS.
//
// Replaces the earlier full-screen "wall". Design history, so nobody re-treads it:
//   v1  borderless window at CGShieldingWindowLevel, focus re-grabbed 4x/sec.
//       Unmissable and genuinely hard to escape. Also: a borderless NSWindow
//       answers false to canBecomeKey, so keyDown never fired and Enter did
//       nothing.
//   v2  maximized titled window, .floating, focus grabbed once. Escapable, keys
//       worked — but still a full-screen red takeover for what is usually just
//       "your next thing starts soon".
//   v3  (this) a thin bar pinned under the menu bar. Non-activating: it never
//       takes keyboard focus, so it cannot interrupt what you are typing into.
//       Dismiss and Snooze are buttons, because there is no key focus to read.
//
// Deliberately NOT tied to Google Meet: plenty of entries are just a timebox
// with no video call attached, so there is no join link to lean on.
//
//   meeting-banner --title "Standup" --start 2026-08-14T10:30:00
//                  [--window 300] [--ttl 240] [--hide-from-capture]
//   meeting-banner mic                      device-level input state (exit 0 = hot)
//
// Presence detection used to live here too — tab matching plus per-process audio
// output, to stay silent when you were already in the meeting. Deleted on
// purpose: it existed to protect you from a full-screen takeover, and a 30pt
// non-focus-stealing bar doesn't need protecting from. All that survives is the
// mic check, which picks whether to pass --hide-from-capture.
//
// Exit codes: 0 dismissed · 10 snoozed · 11 auto-expired (nobody clicked).

import AppKit
import CoreAudio

let EXIT_ACK: Int32 = 0, EXIT_SNOOZE: Int32 = 10, EXIT_EXPIRED: Int32 = 11

func arg(_ flag: String, _ fallback: String = "") -> String {
    let a = CommandLine.arguments
    guard let i = a.firstIndex(of: flag), i + 1 < a.count else { return fallback }
    return a[i + 1]
}

let mTitle = arg("--title", "(meeting)")
let selfTest = CommandLine.arguments.contains("--self-test")
let hideFromCapture = CommandLine.arguments.contains("--hide-from-capture")
// how long the bar represents end-to-end: full at T-window, empty at T-0
let progressWindow = max(1, Double(arg("--window", "300")) ?? 300)
// give up if nobody clicks, so a banner can't outlive its meeting forever
let ttl = Double(arg("--ttl", "240")) ?? 240

let mStart: Date = {
    let iso = arg("--start")
    let f = ISO8601DateFormatter()
    f.formatOptions = [.withInternetDateTime]
    if let d = f.date(from: iso) { return d }
    let naive = DateFormatter()             // gcalcli hands us naive local time
    naive.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    naive.timeZone = .current
    return naive.date(from: iso) ?? Date().addingTimeInterval(120)
}()

// ---------------------------------------------------------------------------
// `meeting-banner mic` — is any process holding an input stream open?
//
// Only consumer left is the --hide-from-capture decision: if you're in ANY call
// there's a chance you're sharing your screen, and a banner across the menu bar
// would be broadcast to that call's participants.
//
// Note this says "in some call", never "in THIS meeting" — Meet grabs the input
// stream the instant any room URL loads, even an invalid code (verified), so it
// can't tell joined from parked. That's fine here; the banner shows regardless.
// ---------------------------------------------------------------------------

private func audioDevices() -> [AudioObjectID] {
    var addr = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDevices,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain)
    var size: UInt32 = 0
    let sys = AudioObjectID(kAudioObjectSystemObject)
    guard AudioObjectGetPropertyDataSize(sys, &addr, 0, nil, &size) == noErr else { return [] }
    var ids = [AudioObjectID](repeating: 0, count: Int(size) / MemoryLayout<AudioObjectID>.size)
    guard AudioObjectGetPropertyData(sys, &addr, 0, nil, &size, &ids) == noErr else { return [] }
    return ids
}

private func hasInput(_ id: AudioObjectID) -> Bool {
    var addr = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyStreamConfiguration,
        mScope: kAudioObjectPropertyScopeInput,
        mElement: kAudioObjectPropertyElementMain)
    var size: UInt32 = 0
    guard AudioObjectGetPropertyDataSize(id, &addr, 0, nil, &size) == noErr, size > 0 else { return false }
    let buf = UnsafeMutableRawPointer.allocate(byteCount: Int(size), alignment: 16)
    defer { buf.deallocate() }
    guard AudioObjectGetPropertyData(id, &addr, 0, nil, &size, buf) == noErr else { return false }
    let lists = buf.assumingMemoryBound(to: AudioBufferList.self)
    return UnsafeMutableAudioBufferListPointer(lists).contains { $0.mNumberChannels > 0 }
}

private func isRunning(_ id: AudioObjectID) -> Bool {
    var addr = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyDeviceIsRunningSomewhere,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain)
    var running: UInt32 = 0
    var size = UInt32(MemoryLayout<UInt32>.size)
    guard AudioObjectGetPropertyData(id, &addr, 0, nil, &size, &running) == noErr else { return false }
    return running != 0
}

private func deviceName(_ id: AudioObjectID) -> String {
    var addr = AudioObjectPropertyAddress(
        mSelector: kAudioObjectPropertyName,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain)
    // Unmanaged<CFString>?, not CFString? — taking a raw pointer to an optional
    // holding an object reference is what the compiler warns about. CoreAudio
    // hands back a +1 retained string here, so takeRetainedValue is correct.
    var out: Unmanaged<CFString>? = nil
    var size = UInt32(MemoryLayout<Unmanaged<CFString>?>.size)
    guard AudioObjectGetPropertyData(id, &addr, 0, nil, &size, &out) == noErr,
          let cf = out else { return "?" }
    return cf.takeRetainedValue() as String
}

if CommandLine.arguments.dropFirst().first == "mic" {
    let hot = audioDevices().filter { hasInput($0) && isRunning($0) }.map(deviceName)
    print(hot.isEmpty ? "idle" : "hot\t" + hot.joined(separator: ", "))
    exit(hot.isEmpty ? 1 : 0)      // 0 = in some call, 1 = mic idle
}
// ---------------------------------------------------------------------------
// the banner
// ---------------------------------------------------------------------------

private let MIN_BAR_H: CGFloat = 24      // floor, for a screen with no menu bar
private let MARGIN: CGFloat = 8
private let BTN_W: CGFloat = 62
private let BTN_GAP: CGFloat = 4
private let TIME_W: CGFloat = 68
// width reserved at BOTH ends, so the centred title is centred on the real
// midpoint of the bar rather than on whatever space the controls left over
private let RESERVE: CGFloat = MARGIN + BTN_W + BTN_GAP + BTN_W + 6 + TIME_W

private let TRACK_BG = NSColor(srgbRed: 0.14, green: 0.14, blue: 0.16, alpha: 0.98)
private func fillColor(secsLeft: Double) -> NSColor {
    // escalate as the deadline closes; no animation, just a colour step
    if secsLeft <= 60  { return NSColor(srgbRed: 0.90, green: 0.16, blue: 0.10, alpha: 1) }
    if secsLeft <= 120 { return NSColor(srgbRed: 0.82, green: 0.22, blue: 0.14, alpha: 1) }
    return NSColor(srgbRed: 0.68, green: 0.20, blue: 0.20, alpha: 1)
}

/// Exact menu-bar height for this screen: the gap frame leaves above
/// visibleFrame. 37pt on a notched display, 24pt otherwise, 0 if auto-hidden —
/// so covering the menu bar means matching this rather than hardcoding.
private func menuBarHeight(_ s: NSScreen) -> CGFloat {
    max(MIN_BAR_H, s.frame.maxY - s.visibleFrame.maxY)
}

private struct Unit {
    let panel: NSPanel
    let track: NSView
    let fill: NSView
    let title: NSTextField
    let time: NSTextField
}

final class Banner: NSObject, NSApplicationDelegate {
    private var units: [Unit] = []
    private var timer: Timer?
    private let born = Date()

    func applicationDidFinishLaunching(_ n: Notification) {
        for s in NSScreen.screens { units.append(build(on: s)) }
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.tick()
        }
        tick()
        if selfTest {
            for (i, u) in units.enumerated() {
                let f = u.panel.frame
                let s = NSScreen.screens[i]
                print("banner \(i): \(Int(f.width))x\(Int(f.height)) at y=\(Int(f.origin.y)) "
                      + "· screen top=\(Int(s.frame.maxY)) menuBar=\(Int(menuBarHeight(s)))pt "
                      + "· covers=\(f.maxY >= s.frame.maxY) level=\(u.panel.level.rawValue) "
                      + "canBecomeKey=\(u.panel.canBecomeKey)")
            }
            exit(EXIT_ACK)
        }
    }

    private func build(on screen: NSScreen) -> Unit {
        // screen.frame (NOT visibleFrame) + a height matching the menu bar, so the
        // banner sits ON the menu bar and hides it.
        let h = menuBarHeight(screen)
        let rect = NSRect(x: screen.frame.minX, y: screen.frame.maxY - h,
                          width: screen.frame.width, height: h)

        // .nonactivatingPanel is the whole trick: buttons stay clickable while the
        // app never becomes active, so keyboard focus is left exactly where it was.
        let panel = NSPanel(contentRect: rect,
                            styleMask: [.borderless, .nonactivatingPanel],
                            backing: .buffered, defer: false)
        panel.isFloatingPanel = true
        panel.becomesKeyOnlyIfNeeded = true
        panel.hidesOnDeactivate = false
        panel.isOpaque = true
        panel.backgroundColor = TRACK_BG
        panel.hasShadow = false
        // above .mainMenu (24) so it paints over the menu bar
        panel.level = .statusBar
        panel.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary, .ignoresCycle]
        panel.ignoresMouseEvents = false
        if hideFromCapture { panel.sharingType = .none }

        let content = NSView(frame: NSRect(origin: .zero, size: rect.size))
        content.wantsLayer = true
        panel.contentView = content

        // full-bleed, square corners — no inset, no cornerRadius
        let track = NSView(frame: content.bounds)
        track.wantsLayer = true
        track.layer?.backgroundColor = TRACK_BG.cgColor
        content.addSubview(track)

        // depletes right-to-left: anchored at x=0, width shrinks toward 0
        let fill = NSView(frame: NSRect(x: 0, y: 0, width: track.bounds.width, height: h))
        fill.wantsLayer = true
        track.addSubview(fill)

        let W = track.bounds.width
        let bh = min(h - 6, 18)
        let by = ((h - bh) / 2).rounded()
        let ty = ((h - 15) / 2).rounded()

        let btnDismiss = makeButton("Dismiss", action: #selector(dismissClicked))
        let btnSnooze  = makeButton("Snooze",  action: #selector(snoozeClicked))
        btnDismiss.frame = NSRect(x: W - MARGIN - BTN_W, y: by, width: BTN_W, height: bh)
        btnSnooze.frame  = NSRect(x: W - MARGIN - BTN_W*2 - BTN_GAP, y: by, width: BTN_W, height: bh)
        track.addSubview(btnSnooze)
        track.addSubview(btnDismiss)

        // right-aligned, immediately left of the buttons
        let time = NSTextField(labelWithString: "")
        time.font = .monospacedDigitSystemFont(ofSize: 12, weight: .bold)
        time.textColor = .white
        time.alignment = .right
        time.frame = NSRect(x: btnSnooze.frame.minX - 6 - TIME_W, y: ty, width: TIME_W, height: 15)
        track.addSubview(time)

        // centred on the true midpoint: equal RESERVE at both ends
        let title = NSTextField(labelWithString: mTitle)
        title.font = .systemFont(ofSize: 12, weight: .medium)
        title.textColor = .white
        title.alignment = .center
        title.lineBreakMode = .byTruncatingTail
        title.frame = NSRect(x: RESERVE, y: ty,
                             width: max(60, W - RESERVE * 2), height: 15)
        track.addSubview(title)

        panel.orderFrontRegardless()      // show WITHOUT activating the app
        return Unit(panel: panel, track: track, fill: fill, title: title, time: time)
    }

    private func makeButton(_ label: String, action: Selector) -> NSButton {
        let b = NSButton(title: label, target: self, action: action)
        b.isBordered = false
        b.wantsLayer = true
        b.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.20).cgColor
        b.layer?.cornerRadius = 3
        b.contentTintColor = .white
        b.font = .systemFont(ofSize: 11, weight: .medium)
        return b
    }

    private func tick() {
        let secs = mStart.timeIntervalSinceNow
        let a = abs(Int(secs.rounded()))
        let text = String(format: "%@%d:%02d", secs < 0 ? "-" : "", a / 60, a % 60)
        // DEPLETING: full at T-window, empty at T-0. Time remaining, not elapsed.
        let remaining = min(1.0, max(0.0, secs / progressWindow))
        let colour = fillColor(secsLeft: secs)

        for u in units {
            u.time.stringValue = text
            let h = u.track.bounds.height
            u.fill.frame = NSRect(x: 0, y: 0,
                                  width: u.track.bounds.width * CGFloat(remaining), height: h)
            u.fill.layer?.backgroundColor = colour.cgColor
            // keep it above whatever just got opened, without stealing focus
            if !u.panel.isVisible { u.panel.orderFrontRegardless() }
        }
        if Date().timeIntervalSince(born) > ttl { finish(EXIT_EXPIRED) }
    }

    @objc private func dismissClicked() { finish(EXIT_ACK) }
    @objc private func snoozeClicked()  { finish(EXIT_SNOOZE) }

    private func finish(_ code: Int32) {
        timer?.invalidate()
        for u in units { u.panel.orderOut(nil) }
        exit(code)
    }
}

// .accessory: no Dock icon, and the app never becomes active. Combined with
// .nonactivatingPanel this is what keeps keyboard focus where the user left it.
let app = NSApplication.shared
app.setActivationPolicy(.accessory)
let delegate = Banner()
app.delegate = delegate
app.run()
