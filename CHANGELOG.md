# Changelog

All notable changes to this kit. Dates are YYYY-MM-DD.

## 2026-06-08 — Refresh: re-verified against Claude Code, mid-2026

The kit's own handbook says to treat a doc untouched for 7+ days as potentially stale (`pm-handbook.md`, Staleness Rule). By that rule this kit was overdue, so it's now re-verified against Claude Code as of June 2026.

### Changed — currency
- **Skills now documented as auto-triggering.** Every skill already shipped `description` frontmatter, but the docs taught the manual `Read .claude/skills/X.md` pattern everywhere. Reframed across README, `how-it-works.md`, `pm-handbook.md`, and each skill's usage line: skills auto-fire on intent; the explicit `Read` form is a manual override. Noted the folder + `SKILL.md` option.
- **New section: "Where this meets native Claude Code (2026)."** Positions the kit's conventions as complementary to native primitives shipped since this repo was first published — Skills auto-trigger, Hooks, file-based Memory, Subagents — instead of silently reinventing them. (README + `how-it-works.md`.)
- **HANDOVER framing.** Repositioned relative to native Memory (durable facts) and auto-compaction; changed the "read → delete the only copy" instruction to "read → overwrite/archive."

### Changed — correctness
- **`edge-runtime-patterns.md` rewritten around runtime choice.** Old version told you to put `export const runtime = 'edge'` on every route — which now *breaks* the recommended OpenNext (`@opennextjs/cloudflare`, Node runtime) build. New version: pick your runtime first (OpenNext/Node is the default; edge is opt-in), and the edge-only constraints (Web Crypto, raw-fetch for heavy SDKs, ~30s) are scoped to the edge path.
- **Security secret-scan fixed.** Replaced `git log -p | grep -i "api_key"` (slow, misses `sk-`/`AKIA`/JWTs/`.env` diffs) with `gitleaks` / `trufflehog`. This is the only security tool in the free tier, so it had to be correct.
- **`payment-integration.md` de-provider-mixed.** The "generic" idempotent-webhook example returned ECPay's `1|OK` ack inside Python presented as provider-agnostic; made the ack abstract. Dated the fee table (fees drift) and updated retired `stripe.com/docs/*` links to `docs.stripe.com`.

### Changed — consistency & trust
- Merged the two overlapping security chapters (old Ch.6 "basics" with 9 categories vs Ch.9 "audit" with 6) into one source of truth; Ch.6 is now a pointer.
- Reconciled file references: aligned the ghost `cloudflare-edge-patterns.md` references to the real `edge-runtime-patterns.md`; fixed the knowledge-file count (3, not "two"/"4+"); added the `audit` alias to the automations install banner.
- Modernized two skill checks: Lighthouse target raised from 70+; replaced the discontinued Twitter Card Validator with a current OG inspector.

### Added
- `templates/settings.json` — a real Hooks example (SessionStart injects HANDOVER.md, a PreToolUse guard blocks force-push / `rm -rf`, Stop reminds you to capture rules).
- `templates/MEMORY.md` — a starter index + explanation for native file-based Memory.
- `examples/session-walkthrough.md` — a start-to-finish session showing a skill auto-firing, the handover cycle, and a correction becoming a rule.

## 2026-03-05 — Initial release
- Complete Claude Code workflow system: CLAUDE.md / HANDOVER.md / DASHBOARD.md templates, 10-chapter PM handbook, soul.md, 4 decision-framework skills, knowledge files, examples, shell automations.
