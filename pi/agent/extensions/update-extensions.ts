/**
 * /update-extensions — runs `pi update --extensions` in the background with a
 * live progress widget, then reloads the runtime once the agent is idle.
 */

import { spawn } from "node:child_process";
import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { type ExtensionAPI, type ExtensionCommandContext, getAgentDir } from "@earendil-works/pi-coding-agent";
import { type TUI, truncateToWidth } from "@earendil-works/pi-tui";

const WIDGET_KEY = "update-extensions";
const TIMEOUT_MS = 10 * 60 * 1000;
const SPINNER = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];
const LOG_TAIL = 3;

type Phase = "checking" | "installing" | "waiting" | "done" | "failed";

interface Progress {
	phase: Phase;
	startedAt: number;
	finishedAt?: number;
	packageCount: number;
	current?: string;
	installed: string[];
	log: string[];
	summary?: string;
}

interface NpmPackage {
	name: string;
	root: string;
}

const stripAnsi = (s: string) => s.replace(/\x1b\[[0-9;?]*[ -/]*[@-~]/g, "");

function elapsed(ms: number): string {
	const s = Math.floor(ms / 1000);
	return s < 60 ? `${s}s` : `${Math.floor(s / 60)}m ${String(s % 60).padStart(2, "0")}s`;
}

function readPackages(settingsPath: string): string[] {
	try {
		const settings = JSON.parse(readFileSync(settingsPath, "utf8"));
		return (settings.packages ?? []).map((p: string | { source: string }) => (typeof p === "string" ? p : p.source));
	} catch {
		return [];
	}
}

function npmName(source: string): string | undefined {
	if (!source.startsWith("npm:")) return undefined;
	const spec = source.slice(4);
	const at = spec.indexOf("@", spec.startsWith("@") ? 1 : 0);
	return at === -1 ? spec : spec.slice(0, at);
}

function listPackages(cwd: string): { total: number; npm: NpmPackage[] } {
	const scopes = [
		{ settings: join(getAgentDir(), "settings.json"), root: join(getAgentDir(), "npm") },
		{ settings: join(cwd, ".pi", "settings.json"), root: join(cwd, ".pi", "npm") },
	];
	let total = 0;
	const npm: NpmPackage[] = [];
	for (const scope of scopes) {
		for (const source of readPackages(scope.settings)) {
			total++;
			const name = npmName(source);
			if (name) npm.push({ name, root: scope.root });
		}
	}
	return { total, npm };
}

function installedVersions(pkgs: NpmPackage[]): Map<string, string | undefined> {
	const versions = new Map<string, string | undefined>();
	for (const { name, root } of pkgs) {
		const manifest = join(root, "node_modules", name, "package.json");
		let version: string | undefined;
		try {
			if (existsSync(manifest)) version = JSON.parse(readFileSync(manifest, "utf8")).version;
		} catch {}
		versions.set(`${root}\0${name}`, version);
	}
	return versions;
}

function versionChanges(before: Map<string, string | undefined>, after: Map<string, string | undefined>): string[] {
	const changes: string[] = [];
	for (const [key, next] of after) {
		const prev = before.get(key);
		if (prev !== next) changes.push(`${key.split("\0")[1]} ${prev ?? "∅"} → ${next ?? "∅"}`);
	}
	return changes;
}

function runUpdate(cwd: string, signal: AbortSignal, onLine: (line: string) => void): Promise<number> {
	return new Promise((resolve, reject) => {
		const child = spawn("pi", ["update", "--extensions"], {
			cwd,
			env: { ...process.env, NO_COLOR: "1", FORCE_COLOR: "0" },
			stdio: ["ignore", "pipe", "pipe"],
		});
		const timer = setTimeout(() => child.kill("SIGTERM"), TIMEOUT_MS);
		const onAbort = () => child.kill("SIGTERM");
		signal.addEventListener("abort", onAbort, { once: true });

		for (const stream of [child.stdout, child.stderr]) {
			let buf = "";
			stream.setEncoding("utf8");
			stream.on("data", (chunk: string) => {
				buf += chunk;
				const parts = buf.split(/\r?\n|\r/);
				buf = parts.pop() ?? "";
				for (const part of parts) {
					const line = stripAnsi(part).trim();
					if (line) onLine(line);
				}
			});
		}
		child.on("error", (err) => {
			clearTimeout(timer);
			reject(err);
		});
		child.on("close", (code, sig) => {
			clearTimeout(timer);
			signal.removeEventListener("abort", onAbort);
			resolve(code ?? (sig ? 128 : 1));
		});
	});
}

function showWidget(ctx: ExtensionCommandContext, state: Progress) {
	if (ctx.mode !== "tui") return;
	ctx.ui.setWidget(WIDGET_KEY, (tui: TUI, theme) => {
		let frame = 0;
		const interval = setInterval(() => {
			frame = (frame + 1) % SPINNER.length;
			tui.requestRender();
		}, 80);
		return {
			invalidate() {},
			dispose() {
				clearInterval(interval);
			},
			render(width: number): string[] {
				const time = theme.fg("dim", elapsed((state.finishedAt ?? Date.now()) - state.startedAt));
				const spin = theme.fg("accent", SPINNER[frame]);
				let head: string;
				switch (state.phase) {
					case "checking":
						head = `${spin} Checking ${state.packageCount} packages for updates…`;
						break;
					case "installing":
						head = `${spin} ${state.current ?? "Installing updates…"}`;
						break;
					case "waiting":
						head = `${theme.fg("warning", "◷")} ${state.summary} ${theme.fg("dim", "— reloading when agent is idle")}`;
						break;
					case "done":
						head = `${theme.fg("success", "✓")} ${state.summary}`;
						break;
					case "failed":
						head = `${theme.fg("error", "✗")} ${state.summary}`;
						break;
				}
				const lines = [`${head} ${time}`];
				for (const done of state.installed) lines.push(`  ${theme.fg("success", "✓")} ${theme.fg("muted", done)}`);
				if (state.phase === "installing" || state.phase === "failed") {
					for (const l of state.log.slice(-LOG_TAIL)) lines.push(theme.fg("dim", `  │ ${l}`));
				}
				return lines.map((l) => truncateToWidth(l, width));
			},
		};
	});
}

export default function (pi: ExtensionAPI) {
	let running = false;
	let disposed = false;
	const abort = new AbortController();

	pi.on("session_shutdown", () => {
		disposed = true;
		abort.abort();
	});

	pi.registerCommand("update-extensions", {
		description: "Update installed pi packages in the background, then reload",
		handler: async (_args, ctx) => {
			if (running) {
				ctx.ui.notify("Extension update already running", "warning");
				return;
			}
			running = true;

			const { total, npm } = listPackages(ctx.cwd);
			const before = installedVersions(npm);
			const state: Progress = { phase: "checking", startedAt: Date.now(), packageCount: total, installed: [], log: [] };
			showWidget(ctx, state);
			if (ctx.mode !== "tui") ctx.ui.notify("Updating extensions in the background…", "info");

			const finish = (phase: "done" | "failed", summary: string) => {
				state.phase = phase;
				state.summary = summary;
				state.finishedAt = Date.now();
			};
			const clearLater = (ms: number) =>
				setTimeout(() => {
					if (!disposed) ctx.ui.setWidget(WIDGET_KEY, undefined);
				}, ms);

			// Fire and forget so the command returns and the UI stays usable.
			void (async () => {
				try {
					let updates = 0;
					const code = await runUpdate(ctx.cwd, abort.signal, (line) => {
						if (/^Updating .*\.\.\.$/.test(line)) {
							if (state.current) state.installed.push(state.current.replace(/^Updating /, "").replace(/\.\.\.$/, ""));
							state.phase = "installing";
							state.current = line.replace(/\.\.\.$/, "…");
							updates++;
						} else {
							state.log.push(line);
						}
					});
					if (disposed) return;

					if (code !== 0) {
						finish("failed", `pi update --extensions failed (exit ${code})`);
						ctx.ui.notify(`${state.summary}\n${state.log.slice(-5).join("\n")}`, "error");
						clearLater(15_000);
						return;
					}

					const changes = versionChanges(before, installedVersions(npm));
					state.installed = changes;
					state.current = undefined;
					if (updates === 0) {
						finish("done", "All extensions are up to date");
						clearLater(5000);
						return;
					}

					state.phase = "waiting";
					state.summary = changes.length ? `Updated ${changes.length} package${changes.length === 1 ? "" : "s"}` : "Updated packages";
					state.finishedAt = Date.now();
					ctx.ui.notify(changes.length ? `Updated extensions:\n${changes.join("\n")}` : "Extensions updated", "info");

					// Reload refuses while streaming/compacting; wait until truly idle.
					do {
						await ctx.waitForIdle();
					} while (!disposed && !ctx.isIdle());
					if (disposed) return;
					await ctx.reload();
				} catch (err) {
					if (disposed) return;
					finish("failed", `Extension update failed: ${err instanceof Error ? err.message : String(err)}`);
					ctx.ui.notify(state.summary!, "error");
					clearLater(15_000);
				} finally {
					running = false;
				}
			})();
		},
	});
}
