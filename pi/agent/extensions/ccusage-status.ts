// Shows today's ccusage spend in the footer via ~/.local/bin/ccusage-today (cached, non-blocking).
import { execFile } from "node:child_process";
import * as os from "node:os";
import * as path from "node:path";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const SCRIPT = path.join(os.homedir(), ".local/bin/ccusage-today");

export default function (pi: ExtensionAPI) {
  let timer: ReturnType<typeof setInterval> | undefined;

  pi.on("session_start", (_event, ctx) => {
    if (!ctx.hasUI) return;
    const update = () =>
      execFile(SCRIPT, { timeout: 5000 }, (err, stdout) => {
        ctx.ui.setStatus("ccusage", err ? "day ?" : stdout.trim() || "day ?");
      });
    update();
    // The script returns the cached value at once and refreshes in the background, so poll twice per TTL.
    clearInterval(timer);
    timer = setInterval(update, 30_000);
    timer.unref?.();
  });

  pi.on("session_shutdown", () => {
    clearInterval(timer);
    timer = undefined;
  });
}
