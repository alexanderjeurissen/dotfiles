// Gives each Pi session its own kata actor, stateless: KATA_AUTHOR=<you>/paseo-<agent id> inside a
// Paseo agent, else <you>/pi-<short session id>. Claims and events then name the session; the human
// actor stays in KATA_AUTHOR_BASE. KATA_TEAMMATE (pi-<short session id>) and KATA_INBOX_USER feed
// `kata` in the bash tool and the kata hook's inbox injection.
import * as os from "node:os";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", (_event, ctx) => {
    const id = ctx.sessionManager.getSessionId();
    if (typeof id !== "string" || !id) return;
    // Explicit launcher choice wins; a value we set earlier (or a parent Pi's, inherited) is replaced.
    if (process.env.KATA_TEAMMATE && !process.env.KATA_TEAMMATE_AUTO) return;
    const name = `pi-${id.slice(0, 8)}`;
    // Read the human actor once: later sessions (and child Pis) inherit KATA_AUTHOR_BASE, so our own
    // KATA_AUTHOR never becomes the base of the next one.
    const base = process.env.KATA_AUTHOR_BASE || process.env.KATA_AUTHOR || process.env.USER || os.userInfo().username;
    // The Paseo agent id names one session; a second session that inherits it (a child Pi, /new) uses its own id.
    const agent = process.env.PASEO_AGENT_ID;
    const handle = agent && process.env.KATA_AUTHOR_PASEO !== agent ? `paseo-${agent}` : name;
    if (handle !== name) process.env.KATA_AUTHOR_PASEO = agent;
    process.env.KATA_AUTHOR_BASE = base;
    process.env.KATA_AUTHOR = `${base}/${handle}`;
    process.env.KATA_TEAMMATE = name;
    process.env.KATA_TEAMMATE_AUTO = "1";
    process.env.KATA_INBOX_USER = process.env.KATA_AUTHOR;
  });
}
