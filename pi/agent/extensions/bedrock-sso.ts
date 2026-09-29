/**
 * bedrock-sso — recover from an expired AWS SSO session without leaving pi.
 *
 * - `/bedrock`            run `aws sso login`, verify, and resume a turn the expiry killed.
 * - `/bedrock status`     show the resolved profile, sso-session and cached token expiry.
 * - On failure            a Bedrock turn that dies on an SSO expiry prompts to log in, then
 *                         resumes the same turn (one resume per failure, never a loop).
 * - Before each prompt    if the cached access token is expired or about to be, probe with
 *                         `sts get-caller-identity` and offer the login before the turn starts.
 *
 * The browser step cannot be removed: IAM Identity Center requires it once the session ends.
 * Pi builds a fresh Bedrock client per request, so a successful login needs no restart.
 *
 * Set PI_BEDROCK_SSO_AUTO_LOGIN=1 to skip the confirm prompt and open the browser directly.
 */

import { spawn } from "node:child_process";
import { createHash } from "node:crypto";
import { readFileSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const PROVIDER = "amazon-bedrock";
const STATUS_KEY = "bedrock-sso";
const LOGIN_TIMEOUT_MS = 5 * 60 * 1000;
const PROBE_TIMEOUT_MS = 20 * 1000;
const PREFLIGHT_WINDOW_MS = 5 * 60 * 1000;
const RESUME_TEXT =
	"[bedrock-sso] The AWS SSO session expired and has been renewed. Continue exactly where you left off.";

// SDK: "... run 'aws sso login' ...", "The SSO session associated with this profile has expired".
// CLI: "Error when retrieving token from sso: Token has expired and refresh failed",
//      "Error loading SSO Token: Token for <sso-session> does not exist".
const SSO_EXPIRED =
	/aws sso login|\bSSO (?:session|token)\b[^.]*\b(?:expired|invalid)\b|retrieving token from sso|loading SSO token/i;

interface Target {
	profile: string;
	ssoSession?: string;
	startUrl?: string;
}

interface Outcome {
	ok: boolean;
	detail: string;
}

type Msg = { role?: string; stopReason?: string; errorMessage?: string; provider?: string };

export default function (pi: ExtensionAPI) {
	let inflight: Promise<Outcome> | undefined;
	let resumedForCurrentFailure = false;

	const isBedrock = (ctx: ExtensionContext) => ctx.model?.provider === PROVIDER;
	const autoLogin = () => process.env.PI_BEDROCK_SSO_AUTO_LOGIN === "1";

	async function awsConfig(key: string, profile: string): Promise<string | undefined> {
		const r = await run(["configure", "get", key, "--profile", profile], 10_000);
		return r.code === 0 && r.stdout.trim() ? r.stdout.trim() : undefined;
	}

	async function resolveTarget(): Promise<Target> {
		const profile = process.env.AWS_PROFILE || "default";
		const ssoSession = await awsConfig("sso_session", profile);
		const startUrl = ssoSession ? undefined : await awsConfig("sso_start_url", profile);
		return { profile, ssoSession, startUrl };
	}

	/** Cached access-token expiry, or undefined when there is no readable cache file. */
	function cachedExpiry(t: Target): Date | undefined {
		const key = t.ssoSession ?? t.startUrl;
		if (!key) return undefined;
		const file = join(homedir(), ".aws", "sso", "cache", `${createHash("sha1").update(key).digest("hex")}.json`);
		try {
			const { expiresAt } = JSON.parse(readFileSync(file, "utf8")) as { expiresAt?: string };
			return expiresAt ? new Date(expiresAt) : undefined;
		} catch {
			return undefined;
		}
	}

	async function probe(t: Target): Promise<Outcome> {
		const r = await run(["sts", "get-caller-identity", "--profile", t.profile, "--output", "json"], PROBE_TIMEOUT_MS);
		if (r.code === 0) {
			try {
				return { ok: true, detail: (JSON.parse(r.stdout) as { Arn: string }).Arn };
			} catch {
				return { ok: true, detail: "credentials valid" };
			}
		}
		return { ok: false, detail: (r.stderr || r.stdout).trim() };
	}

	/** Browser login + verification, deduplicated across concurrent callers. */
	function login(ctx: ExtensionContext): Promise<Outcome> {
		inflight ??= (async () => {
			const t = await resolveTarget();
			const args = t.ssoSession
				? ["sso", "login", "--sso-session", t.ssoSession]
				: ["sso", "login", "--profile", t.profile];
			ctx.ui.setStatus(STATUS_KEY, "AWS SSO: waiting for browser login…");
			ctx.ui.notify(`Running aws ${args.join(" ")} — finish the login in your browser.`, "info");
			const r = await run(args, LOGIN_TIMEOUT_MS, (chunk) => {
				// If the browser did not open, the CLI prints the URL and code; surface them.
				const url = chunk.match(/https:\/\/\S+/)?.[0];
				if (url) ctx.ui.notify(`If no browser opened: ${url}`, "info");
			});
			if (r.code !== 0) {
				return { ok: false, detail: r.killed ? "login timed out" : (r.stderr || r.stdout).trim() };
			}
			return probe(t);
		})().finally(() => {
			inflight = undefined;
			ctx.ui.setStatus(STATUS_KEY, undefined);
		});
		return inflight;
	}

	/** Ask (unless auto-login is on), then log in. Returns true when credentials are valid again. */
	async function offerLogin(ctx: ExtensionContext, reason: string): Promise<boolean> {
		if (!ctx.hasUI) {
			ctx.ui.notify(`${reason} Run /bedrock (or \`aws sso login\`) to re-authenticate.`, "warning");
			return false;
		}
		if (!autoLogin() && !inflight) {
			const yes = await ctx.ui.confirm("AWS SSO session expired", `${reason}\n\nOpen the browser to log in now?`);
			if (!yes) {
				ctx.ui.notify("Skipped. Run /bedrock when ready.", "info");
				return false;
			}
		}
		const result = await login(ctx);
		ctx.ui.notify(result.ok ? `AWS SSO renewed: ${result.detail}` : `AWS SSO login failed: ${result.detail}`, result.ok ? "info" : "error");
		return result.ok;
	}

	function lastAssistant(messages: readonly unknown[]): Msg | undefined {
		for (let i = messages.length - 1; i >= 0; i--) {
			const m = messages[i] as Msg;
			if (m?.role === "assistant") return m;
		}
		return undefined;
	}

	const isSsoFailure = (m: Msg | undefined) =>
		m?.stopReason === "error" && m.provider === PROVIDER && SSO_EXPIRED.test(m.errorMessage ?? "");

	// A successful assistant reply re-arms the one-shot resume.
	pi.on("message_end", (event) => {
		const m = event.message as Msg;
		if (m.role === "assistant" && m.stopReason !== "error") resumedForCurrentFailure = false;
	});

	// Mid-turn expiry: log in, then resume the same turn once.
	pi.on("agent_before_settle", async (event, ctx) => {
		if (event.outcome !== "error") return;
		if (!isSsoFailure(lastAssistant(event.context.contextMessages))) return;
		if (resumedForCurrentFailure) {
			ctx.ui.notify("Bedrock still reports an expired SSO session after re-login. Run /bedrock status.", "error");
			return;
		}
		if (!(await offerLogin(ctx, "The last Bedrock request failed on an expired AWS SSO session."))) return;
		resumedForCurrentFailure = true;
		return {
			entries: [{ type: "custom_message", customType: "bedrock-sso", content: RESUME_TEXT, display: true }],
			continue: true,
		};
	});

	// Preflight: only when the cached token is expired or about to be, so a fresh token costs nothing.
	pi.on("before_agent_start", async (_event, ctx) => {
		if (!isBedrock(ctx) || inflight) return;
		const t = await resolveTarget();
		const exp = cachedExpiry(t);
		if (exp && exp.getTime() - Date.now() > PREFLIGHT_WINDOW_MS) return;
		const p = await probe(t); // the CLI silently refreshes via the refresh token when it can
		if (p.ok || !SSO_EXPIRED.test(p.detail)) return;
		await offerLogin(ctx, `AWS SSO session for profile "${t.profile}" has expired.`);
	});

	pi.registerCommand("bedrock", {
		description: "Re-authenticate AWS SSO for Bedrock (`/bedrock status` to inspect)",
		handler: async (args, ctx) => {
			if (args.trim() === "status") {
				const t = await resolveTarget();
				const exp = cachedExpiry(t);
				const p = await probe(t);
				ctx.ui.notify(
					[
						`profile: ${t.profile}${t.ssoSession ? `  sso-session: ${t.ssoSession}` : ""}`,
						`cached access token expires: ${exp ? exp.toISOString() : "unknown"}`,
						p.ok ? `identity: ${p.detail}` : `credentials invalid: ${p.detail}`,
					].join("\n"),
					p.ok ? "info" : "warning",
				);
				return;
			}
			const result = await login(ctx);
			if (!result.ok) {
				ctx.ui.notify(`AWS SSO login failed: ${result.detail}`, "error");
				return;
			}
			ctx.ui.notify(`AWS SSO renewed: ${result.detail}`, "info");
			const last = lastAssistant(ctx.sessionManager.getBranch().map((e) => (e as { message?: unknown }).message));
			if (isSsoFailure(last) && ctx.isIdle()) {
				resumedForCurrentFailure = true;
				pi.sendMessage({ customType: "bedrock-sso", content: RESUME_TEXT, display: true }, { triggerTurn: true });
			}
		},
	});
}

/** argv-only exec (never a shell string), with optional streaming of output chunks. */
function run(
	args: string[],
	timeoutMs: number,
	onChunk?: (text: string) => void,
): Promise<{ code: number; stdout: string; stderr: string; killed: boolean }> {
	return new Promise((resolve) => {
		const child = spawn("aws", args, { stdio: ["ignore", "pipe", "pipe"], env: process.env });
		let stdout = "";
		let stderr = "";
		let killed = false;
		const timer = setTimeout(() => {
			killed = true;
			child.kill("SIGTERM");
		}, timeoutMs);
		child.stdout.on("data", (d: Buffer) => {
			const s = d.toString();
			stdout += s;
			onChunk?.(s);
		});
		child.stderr.on("data", (d: Buffer) => {
			const s = d.toString();
			stderr += s;
			onChunk?.(s);
		});
		child.on("error", (err) => {
			clearTimeout(timer);
			resolve({ code: 127, stdout, stderr: String(err), killed });
		});
		child.on("close", (code) => {
			clearTimeout(timer);
			resolve({ code: code ?? 1, stdout, stderr, killed });
		});
	});
}
