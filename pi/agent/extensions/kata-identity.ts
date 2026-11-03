// Gives each Pi session a unique kata teammate handle (pi-<short session id>), stateless.
// KATA_TEAMMATE/KATA_INBOX_USER feed `kata` in the bash tool and the kata hook's inbox injection.
import * as os from "node:os";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", (_event, ctx) => {
    const id = ctx.sessionManager.getSessionId();
    if (typeof id !== "string" || !id) return;
    // Explicit launcher choice wins; a value we set earlier (or a parent Pi's, inherited) is replaced.
    if (process.env.KATA_TEAMMATE && !process.env.KATA_TEAMMATE_AUTO) return;
    const name = `pi-${id.slice(0, 8)}`;
    const actor = process.env.KATA_AUTHOR || process.env.USER || os.userInfo().username;
    process.env.KATA_TEAMMATE = name;
    process.env.KATA_TEAMMATE_AUTO = "1";
    process.env.KATA_INBOX_USER = `${actor}/${name}`;
  });
}
