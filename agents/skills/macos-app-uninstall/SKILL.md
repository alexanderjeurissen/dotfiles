---
name: macos-app-uninstall
description: Fully remove a macOS app, its data, caches and agents.
version: 0.1.0
author: Alexander Jeurissen
license: MIT
platforms: [macos]
metadata:
  tags: [macOS, Uninstall, Cleanup, Caches]
---

# macOS App Uninstall

This skill removes a macOS app and the files it left on disk: the bundle, its data, its caches,
its launch agents and its crash reports. It also removes content that the app installed, such
as Steam games. It does not delete cloud data or accounts. It uses only built-in tools: `rm`,
`launchctl`, `mdfind` and `getconf`.

## When to Use

- "uninstall <app> and everything it installed"
- "make sure that the <app> caches are also cleared"
- "look in the Trash and other locations for <app> leftovers"

## Quick Reference

- App bundle: `/Applications/<App>.app`
- Data: `~/Library/Application Support/<App>`
- Caches: `~/Library/Caches/<App>`, `~/Library/Caches/<bundle-id>*`
- Preferences: `~/Library/Preferences/<bundle-id>.plist`
- Window state: `~/Library/Saved Application State/<bundle-id>.savedState`
- HTTP storage: `~/Library/HTTPStorages/<bundle-id>*`
- Crash reports: `~/Library/Application Support/CrashReporter/<app>_*`
- Launch agents: `~/Library/LaunchAgents/<bundle-id>*.plist`
- Per-user system cache: `"$(getconf DARWIN_USER_CACHE_DIR)"<bundle-id>*`
- Sandboxed apps: `~/Library/Containers/<bundle-id>*`, `~/Library/Group Containers/*<vendor>*`
- Not seen in the Steam session, but standard: `~/Library/Logs/DiagnosticReports`,
  `/Library/LaunchAgents`, `/Library/LaunchDaemons`, `/Library/PrivilegedHelperTools`, and a
  vendor uninstaller in the app bundle or DMG.

## Procedure

1. **Find the install, its size and its content libraries.** Invoke through `bash`:
   ```sh
   ls -d "/Applications/<App>.app" "$HOME/Library/Application Support/<App>"
   du -sh "$HOME/Library/Application Support/<App>"
   pgrep -il <app>
   ```
   If `pgrep` finds a process, quit the app first. If the app manages content libraries, read
   its library config to find content outside the default folder. For Steam, run `grep path` on
   `~/Library/Application Support/Steam/steamapps/libraryfolders.vdf` and list
   `steamapps/common`. In a library outside the app's data folder, delete only the app's
   subfolder (for Steam, `steamapps`). A library root can hold the user's other files.
2. **Find the leftovers by name.** The first pass always misses some. Search for the app name,
   the vendor name and the bundle ID:
   ```sh
   ls -d ~/Library/*/*<App>* ~/Library/*/*/*<App>* ~/Library/Containers/*<App>* \
     ~/Library/Group\ Containers/*<App>* ~/.<app>* 2>/dev/null
   ls -d "$(getconf DARWIN_USER_CACHE_DIR)"*<app>* "$(getconf DARWIN_USER_DIR)"*<app>* 2>/dev/null
   ls -d ~/Library/Application\ Support/*<vendor>* ~/Library/Caches/*<vendor>* 2>/dev/null
   ```
   These globs are for discovery. Read each match and keep only paths that the app owns. A
   vendor-name match can belong to a different app from the same vendor.
3. **Unload each launch agent before you delete files:**
   ```sh
   launchctl bootout gui/$(id -u) "$HOME/Library/LaunchAgents/<bundle-id>.<agent>.plist"
   ```
   An error that the job is not loaded is fine. A permission error is not.
4. **Delete the confirmed paths** in one `rm -rf`. Use exact, quoted paths. Include the Quick
   Reference paths that exist, the library content from step 1 and the matches from step 2.
5. **Look in the Trash, other volumes and Spotlight:**
   ```sh
   ls -la ~/.Trash | grep -i -E "<app>|<vendor>|<content names>"
   ls /Volumes
   for v in /Volumes/*; do find "$v" -maxdepth 4 \( -iname "<library dir>" -o -iname "<App>.app" \) 2>/dev/null; done
   mdfind -name <library dir>
   mdfind "kMDItemFSName == '*<app>*'c"
   find ~ -maxdepth 3 -iname "*<app>*"
   ```
   Read each hit. Source code, notes and agent config can contain the app name but are not the
   app's files.
6. **Report** what you removed, the size you freed, and what the user lost. Local-only saves
   inside the data folder are gone. Cloud saves and the account stay. Do not say "everything is gone".
   Say "no leftovers found in the locations checked".

## Pitfalls

- A first pass that removes only Application Support, Caches and Preferences misses
  `HTTPStorages`, `CrashReporter`, `LaunchAgents` and the per-user cache under `/var/folders`.
  Always do steps 2–3.
- If you delete a launch agent plist before `launchctl bootout`, the agent stays loaded until
  logout.
- Do not hard-code the `/var/folders/...` path. It is different on each machine. Use
  `getconf DARWIN_USER_CACHE_DIR`.
- A glob that matches nothing makes `ls` exit 1. This is not an error.
- `mdfind` writes `[UserQueryParser]` locale lines to stderr. This is noise, not a match.
- The search is by name only. It cannot find a cache that has an unrelated name. Spotlight and a
  shallow `find` also miss paths. Say so in the report.

## Verification

Run `ls -d` on each path that you deleted, without `2>/dev/null`. Each path must return
"No such file or directory". Any "Permission denied" means the check failed for that location.
