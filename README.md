# Claude Code Workflow

Conventions, templates, and decision frameworks layered on top of Claude Code's native features (Skills, Hooks, Memory) — so your context compounds across sessions instead of resetting to zero.

> **Last verified against Claude Code: June 2026.** See [CHANGELOG.md](CHANGELOG.md) for what changed.

## The problem

Every session starts from scratch: you re-explain the project, the conventions, the corrections you already gave. This kit fixes that. Claude reads your standards at startup, decisions stay consistent, mistakes don't repeat, and context survives across sessions.

Built across **12+ projects in ~2 months** (and counting), several in production with live payments.

## The system

```
your-project/
├── CLAUDE.md              # Project brain — architecture, standards, guardrails
├── HANDOVER.md            # Session relay — the baton between sessions
├── DASHBOARD.md           # Cross-project status — priorities, blockers, wins
└── .claude/
    ├── settings.json      # Hooks — inject HANDOVER on start, guard destructive cmds
    ├── MEMORY.md          # Index for native file-based Memory (durable facts)
    ├── pm-handbook.md     # PM playbook — status, priorities, security, prod safety
    ├── soul.md            # Personality layer — communication style, values
    ├── skills/            # Decision frameworks — auto-trigger from frontmatter
    └── knowledge/         # Technical learnings — hard-won lessons
```

| File | Purpose | When it's read |
|------|---------|----------------|
| `CLAUDE.md` | Project context, standards, learned rules | Every session (auto-loaded) |
| `HANDOVER.md` | Last session's state + exact next steps | Session start, then overwritten |
| `DASHBOARD.md` | All projects at a glance, priority stack | When planning what's next |
| `settings.json` | Hooks: inject HANDOVER, guard commands, end-of-session nudge | Every session (by the harness) |
| `MEMORY.md` | Index for native Memory — durable, cross-session facts | Auto-recalled by Claude Code |
| `pm-handbook.md` | Status checks, priorities, inception, security audits | When doing PM work |
| `soul.md` | How Claude should talk and what to avoid | Every session |
| `skills/*.md` | Decision frameworks (should I build this? ship?) | Auto-fire on matching intent |
| `knowledge/*.md` | Technical patterns and gotchas | When working on related features |

## Quick start

**Just CLAUDE.md** (2 min, 80% of the benefit):

```bash
cp templates/CLAUDE.md ./CLAUDE.md
```

**The essentials** (5 min): add `HANDOVER.md` + `DASHBOARD.md` for session continuity.

**Full system** (15 min):

```bash
mkdir -p .claude/skills .claude/knowledge
cp templates/CLAUDE.md ./CLAUDE.md
cp templates/{HANDOVER,DASHBOARD}.md ./
cp templates/{pm-handbook,soul,MEMORY}.md ./.claude/
cp templates/settings.json ./.claude/          # Hooks (needs jq)
cp skills/*.md ./.claude/skills/                # auto-trigger once here
cp scripts/automations-template.sh ~/.claude-automations.sh
```

Templates have `[PLACEHOLDER]` markers to fill in. Per-component walkthrough: **[docs/how-it-works.md](docs/how-it-works.md)**. A real session start-to-finish: **[examples/session-walkthrough.md](examples/session-walkthrough.md)**.

## Where this meets native Claude Code (2026)

This kit started as pure markdown. Several conventions now have a native counterpart — use the native primitive first; let the convention carry the judgment it encodes.

| This kit's convention | Native primitive | How they fit |
|---|---|---|
| Skills you `Read` by hand | **Skills auto-trigger** from `description` frontmatter | The files already have the frontmatter — they fire on intent; `Read X.md` is a manual override. |
| `HANDOVER.md` relay | File-based **Memory** + auto-compaction | Memory = durable facts. HANDOVER = the per-session human baton. |
| Shell aliases | **Hooks** (`settings.json`) | Aliases live in the terminal; Hooks enforce behavior inside the session. |
| Manual multi-project sweep | **Subagents** (parallel fan-out) | One agent per project, in parallel, then synthesized. |

If you've used Claude Code in 2026, this isn't a replacement for the harness — it's the conventions, judgment, and templates the harness doesn't ship.

## Principles

- **Every correction = a rule.** When Claude repeats a mistake, write it into `CLAUDE.md` under `## Learned Rules` (trigger, correct behavior, date). No mistake twice.
- **Know what NOT to build.** Does a service already solve this? Is it core or infrastructure? Can it wait until after launch?
- **Challenge the problem first.** Question → delete → simplify → speed up → automate, in that order (PM handbook, Ch. 4).
- **Ship beats perfect.** Core value works and 3 users can complete the main flow → ship. The last 20% takes 80% of the time.
- **Defense in depth.** Validation, error handling, monitoring, rate limiting, rollback, backup (PM handbook, Ch. 10).

## FAQ

**Teams?** Commit `.claude/` to git — everyone gets the same context. Add a per-developer `soul.md` if needed.

**Other AI coding tools?** The concepts port; the file format is Claude Code specific.

**Context window fills up?** Claude Code auto-compacts, but for a clean break write a `HANDOVER.md`, start fresh, read it, overwrite, continue.

## Free vs Pro

This repo is the **free starter kit**. The **Pro version** ($29) adds 13 more skills with executable scripts, safety modes, and creative tools.

| | Free (this repo) | Pro |
|---|:-:|:-:|
| CLAUDE.md / soul.md / PM handbook | Yes | Yes |
| HANDOVER / DASHBOARD | Yes | Yes |
| Hooks + Memory templates | Yes | (free addition) |
| Decision-framework skills | 4 | 4 |
| Deploy checklists + security scanner (with scripts) | — | Yes |
| Debug loop breaker · Cloud Run runbook · session relay | — | Yes |
| Safety modes (`/careful`, `/freeze`) | — | Yes |
| HTML slides (13 presets) · SVG diagrams · X-thread compiler | — | Yes |
| Anti-AI writing guide (EN + 中文) · vibe-coding stack | — | Yes |
| **Total skills** | **4** | **17** |
| **Total files** | **24** | **55+** |

**[Get Pro on Gumroad →](https://jazzpujols34.gumroad.com/l/claude-work-workflow)**

## Read the full write-up

- [Part 1 — 3 files that make Claude Code remember your project](https://x.com/Jazzpujols34/status/2031582021152367081)
- [Part 2 — 3 files that turn Claude Code into your dev partner](https://x.com/Jazzpujols34/status/2031620670631596110)

## Contributing · License

PRs welcome — new skills, knowledge files, extensions. MIT.
