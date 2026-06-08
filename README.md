# Claude Code Workflow

A complete AI-assisted development system for Claude Code. Not just a CLAUDE.md template — a set of conventions, templates, and decision frameworks layered on top of Claude Code's native features (Skills, Hooks, Memory) so you ship faster and your context compounds across sessions.

> **Last verified against Claude Code: June 2026** — covers auto-triggering Skills, Hooks, and file-based Memory. See [CHANGELOG.md](CHANGELOG.md) for what changed.

## The Problem

Every Claude Code session starts from zero. You explain your project, your preferences, your architecture — again and again. Context evaporates between sessions. Decisions get forgotten. The same mistakes happen twice.

Most developers treat Claude Code as a chat tool. This system treats it as a **development partner with persistent memory**.

## The System

```
your-project/
├── CLAUDE.md              # Project brain — architecture, standards, guardrails
├── HANDOVER.md            # Session relay — ephemeral baton between sessions
├── DASHBOARD.md           # Cross-project status — priorities, blockers, wins
└── .claude/
    ├── settings.json     # Hooks — inject HANDOVER on start, guard destructive cmds, end-of-session nudge
    ├── MEMORY.md         # Index for native file-based Memory (durable facts)
    ├── pm-handbook.md     # PM playbook — status checks, priorities, security, production safety
    ├── soul.md            # Personality layer — communication style, values
    ├── skills/            # Decision frameworks — auto-trigger from their description frontmatter
    │   ├── should-i-build-this.md
    │   ├── ship-or-iterate.md
    │   ├── revenue-potential.md
    │   └── mvp-launch-checklist.md
    └── knowledge/         # Technical learnings — hard-won lessons
        └── [topic].md

# (shell aliases install separately from scripts/automations-template.sh → ~/.claude-automations.sh)
```

### What Each Piece Does

| File | Purpose | When It's Read |
|------|---------|----------------|
| `CLAUDE.md` | Project context, coding standards, learned rules | Every session (auto-loaded) |
| `HANDOVER.md` | What happened last session, exact next steps | Start of new session, then overwritten |
| `DASHBOARD.md` | All projects at a glance, priority stack | When planning what to work on |
| `settings.json` | Hooks: inject HANDOVER on start, guard destructive commands, end-of-session nudge | Every session (by the harness) |
| `MEMORY.md` | Index for native file-based Memory — durable, cross-session facts | Auto-recalled by Claude Code |
| `pm-handbook.md` | How to check status, set priorities, start projects, run security audits | When doing PM work |
| `soul.md` | Communication preferences, values, what to avoid | Every session (referenced by CLAUDE.md) |
| `skills/*.md` | Structured decision frameworks | Auto-fire on matching intent |
| `knowledge/*.md` | Technical patterns and gotchas | When working on related features |
| `automations-template.sh` | Shell aliases for common workflows | Setup once, use daily |

## The Result

This system was used to build **12+ projects in ~2 months** (and has kept compounding since), with several deployed to production with live payments. Including:

- An AI memorial video platform (Next.js, Cloudflare Pages, ECPay)
- A podcast transcription pipeline (Python, 100+ episodes processed)
- A vocabulary learning app (React Native, Expo)
- An AI art gallery with auth and admin (React + FastAPI)
- A personal website with CMS (React + FastAPI + SQLite)

The speed comes from **compounding context** — each session builds on the last instead of starting from scratch.

## Quick Start

### Option 1: Just CLAUDE.md (2 minutes, 80% of the benefit)

```bash
cp templates/CLAUDE.md ./CLAUDE.md
```

Edit with your project's specifics. Done.

### Option 2: Copy the essentials (5 minutes)

```bash
mkdir -p .claude/skills .claude/knowledge

cp templates/CLAUDE.md ./CLAUDE.md
cp templates/HANDOVER.md ./HANDOVER.md
cp templates/DASHBOARD.md ./DASHBOARD.md
```

### Option 3: Full system (15 minutes)

```bash
mkdir -p .claude/skills .claude/knowledge

# Core files
cp templates/CLAUDE.md ./CLAUDE.md
cp templates/HANDOVER.md ./HANDOVER.md
cp templates/DASHBOARD.md ./DASHBOARD.md

# PM system + personality
cp templates/pm-handbook.md ./.claude/pm-handbook.md
cp templates/soul.md ./.claude/soul.md

# Native-feature glue: Hooks + Memory index
cp templates/settings.json ./.claude/settings.json
cp templates/MEMORY.md ./.claude/MEMORY.md

# Decision frameworks (auto-trigger once they're in .claude/skills/)
cp skills/*.md ./.claude/skills/

# Automations (see install instructions inside the file)
cp scripts/automations-template.sh ~/.claude-automations.sh
```

> The Hooks in `settings.json` use `jq` — install it (`brew install jq`) or trim the PreToolUse guard if you don't want it.

Edit each file — templates have `[PLACEHOLDER]` markers for everything you need to customize.

## How It Works

### 1. CLAUDE.md — The Project Brain

Claude Code auto-reads `CLAUDE.md` at session start. This is where you encode:

- **What the project is** (so Claude doesn't ask every time)
- **Coding standards** (TypeScript strict, no `any`, Tailwind only)
- **Architecture decisions** (why you chose X over Y)
- **Learned rules** (mistakes that should never happen twice)
- **Key commands** (build, test, deploy)

See [docs/how-it-works.md](docs/how-it-works.md) for the full breakdown.

### 2. HANDOVER.md — The Session Relay

When one session ends, write a `HANDOVER.md`: the exact next step, what's uncommitted, what to watch. The next session reads it and **overwrites** it (never `rm` the only copy — if you commit handovers, git keeps the trail).

**The cycle:** read -> work -> overwrite -> hand off.

Pairs with native **Memory**: Memory holds durable project facts; HANDOVER.md is the per-session human baton. With the Hooks template, the `SessionStart` hook injects HANDOVER.md automatically so the next session opens already knowing where it left off.

See [examples/real-handover.md](examples/real-handover.md) for a real handover and [examples/session-walkthrough.md](examples/session-walkthrough.md) for the full cycle in action.

### 3. soul.md — The Personality Layer

Defines how Claude communicates with you — direct vs. detailed, when to push back, what to avoid. Without it, Claude defaults to generic helpful assistant mode. With it, Claude matches your working style.

### 4. Skills — Reusable Decision Frameworks

Encode a decision process once; let it fire automatically. Each skill carries `name` + `description` frontmatter, and Claude Code **auto-triggers** it when your request matches — you just state intent:

```
"Is a reading-tracker app worth building?"   → auto-fires should-i-build-this
```

The explicit form is a manual override when you want to force a specific skill:

```
Read .claude/skills/should-i-build-this.md and evaluate: "An app that tracks reading habits"
```

Same quality decision every time, zero cognitive load. (A skill can be one `.md` file or a folder with a `SKILL.md` entry point for skills that ship scripts.)

### 5. Knowledge — Technical Memory

Every hard-won lesson gets captured:

```
Read .claude/knowledge/edge-runtime-patterns.md before implementing the API route
```

You learn something once. Claude remembers it forever. See `knowledge/` for real examples.

### 6. PM Handbook — The Full Playbook

10 chapters covering the complete project lifecycle:

| Chapter | Topic |
|---------|-------|
| 1 | Foundation — project inventory |
| 2 | Status Check Protocol |
| 3 | Priority Framework |
| 4 | New Project Inception |
| 5 | Session Handover Protocol |
| 6 | Pointer to the single security checklist (Ch. 9) |
| 7 | Skills & Knowledge System |
| 8 | Dashboard Update Protocol |
| 9 | Security Audit Protocol (detailed checklist) |
| 10 | Production Safety Framework (6-layer defense) |

### 7. Compound Automation

Shell aliases that orchestrate multi-step workflows:

```bash
morning    # Reads DASHBOARD.md, gives top 3 priorities
status     # Current state of all projects
evaluate "An app that tracks reading habits"
audit "my-project"    # Run security checklist
handover   # Write session handover
learn "Edge Workers can't use Node.js crypto"
```

See [scripts/automations-template.sh](scripts/automations-template.sh) for installation instructions.

## Where this meets native Claude Code (2026)

This kit started as pure markdown conventions. Several of those conventions now have a native counterpart in Claude Code — so use the native primitive first and let the convention carry the judgment it encodes (*what* to decide, *what* to write down, *what* good looks like).

| This kit's convention | Native primitive | How they fit |
|---|---|---|
| Skills you `Read` by hand | **Skills auto-trigger** from `description` frontmatter | The skill files already have the frontmatter — they fire on intent; `Read X.md` is a manual override. |
| `HANDOVER.md` relay | File-based **Memory** + auto-compaction | Memory = durable project facts. HANDOVER = the per-session human baton. |
| Shell aliases | **Hooks** (`settings.json`) | Aliases live at the terminal; Hooks enforce behavior inside the session (`templates/settings.json`). |
| "Every correction = a rule" (prose) | A **Stop hook** nudges you | Keep the rule; let a hook remind you to actually capture it. |
| Manual multi-project status sweep | **Subagents** (parallel fan-out) | One agent per project, in parallel, then synthesized. |

Honest take: if you've used Claude Code in 2026, this kit isn't a replacement for the harness — it's the layer of conventions, judgment, and templates that the harness doesn't ship. That's where its value is.

## File Reference

```
templates/
├── CLAUDE.md              # Starter CLAUDE.md with all sections
├── HANDOVER.md            # Session handover template
├── DASHBOARD.md           # Multi-project dashboard template
├── settings.json          # Hooks: SessionStart/PreToolUse/Stop
├── MEMORY.md              # Native Memory index + how-to
├── pm-handbook.md         # PM playbook (10 chapters)
└── soul.md                # Communication style & values template

skills/                    # Each auto-triggers from its description frontmatter
├── should-i-build-this.md # Evaluate new project ideas
├── ship-or-iterate.md     # Ship vs. keep building
├── revenue-potential.md   # Prioritize by cash flow
└── mvp-launch-checklist.md # Pre-launch checklist

knowledge/
├── example-learning.md    # Template for capturing learnings
├── edge-runtime-patterns.md  # Cloudflare runtime choice (OpenNext vs edge) + constraints
└── payment-integration.md    # Payment provider patterns & gotchas

scripts/
└── automations-template.sh # Shell aliases (with install instructions)

examples/
├── monorepo-claude-md.md  # Real CLAUDE.md from a 12-project monorepo
├── project-claude-md.md   # Real CLAUDE.md from a deployed Next.js app
├── real-handover.md       # Real HANDOVER.md from a production session
└── session-walkthrough.md # A full session: skill auto-fires, handover cycle, rule capture

docs/
└── how-it-works.md        # Deep dive on each component

CHANGELOG.md               # What changed, and when it was last verified
```

## Key Principles

### 1. Every correction = a new rule

When Claude makes a mistake, don't just fix it — add it to `CLAUDE.md` under `## Learned Rules`. Format:

```markdown
### Rule N: [Short title]
- **Trigger**: What happened / what went wrong
- **Correct behavior**: What should have been done
- **Date**: YYYY-MM-DD
```

No mistake should happen twice.

### 2. Know what NOT to build

> "The best builders aren't better at coding. They're better at knowing what NOT to build."

Before building any feature:
1. Does a tool/service already solve this? (Auth -> Clerk, Payments -> Stripe)
2. Is this the core value prop, or infrastructure?
3. Can this wait until after launch?

### 3. Challenge the problem before solving it

The PM handbook's inception process (Chapter 4):
1. **Question the requirements** — What problem? Who needs it? What exists?
2. **Try to delete** — For every feature: "what if we remove this entirely?"
3. **Simplify** — Only after deleting
4. **Speed up** — Only after simplifying
5. **Automate** — Last step, not first

### 4. Ship beats perfect

The `ship-or-iterate` skill encodes this: if the core value prop works and 3 users can complete the main flow, **ship it**. The last 20% takes 80% of the time.

### 5. Defense in depth

The Production Safety Framework (Chapter 10) gives you 6 layers:
1. **Validation** — catch bad input at the edge
2. **Error Handling** — fail gracefully, never silently
3. **Monitoring** — know when things break before users tell you
4. **Rate Limiting** — protect against abuse and runaway costs
5. **Rollback** — go back to what worked in < 5 minutes
6. **Backup** — the last line of defense (test your restores)

## FAQ

**Q: Does this work for teams?**
A: Yes. Commit `.claude/` to git. Every team member gets the same context. Add `soul.md` per-developer if needed.

**Q: How often should I update CLAUDE.md?**
A: After every session where you learn something. It should be a living document.

**Q: What if my project is simple?**
A: Start with just `CLAUDE.md`. Add the rest when you feel the friction.

**Q: Can I use this with other AI coding tools?**
A: The concepts (persistent context, session handover, decision frameworks) apply to any AI coding tool. The file format is Claude Code specific.

**Q: What if my context window fills up mid-session?**
A: Claude Code auto-compacts long sessions, but for a clean break write a HANDOVER.md: what you were doing, current state, exact next steps. Start a new session, read the handover, overwrite it with the new state, and continue.

**Q: How do I know the system is working?**
A: You'll notice: sessions start faster (no re-explaining), mistakes don't repeat (learned rules), decisions are consistent (skills), and context survives across sessions (handovers).

## Free vs Pro

This repo is the **free starter kit** — enough to transform how you use Claude Code. The **Pro version** adds 13 more skills with executable scripts, safety modes, and creative tools.

| Feature | Free (this repo) | Pro ($29) |
|---------|:-:|:-:|
| CLAUDE.md template | Yes | Yes |
| soul.md + PM handbook | Yes | Yes |
| HANDOVER / DASHBOARD | Yes | Yes |
| Hooks template (settings.json) | Yes | Yes |
| Memory index template | Yes | Yes |
| Decision framework skills | 4 | 4 |
| Deploy checklist (CF/CR/Vercel) | — | With scripts |
| Security scanner | — | With scripts |
| Debug loop breaker | — | Yes |
| Cloud Run debug runbook | — | Yes |
| Session relay system | — | Yes |
| Safety modes (/careful, /freeze) | — | Yes |
| HTML slide generator (13 presets) | — | Yes |
| SVG diagram skill | — | Yes |
| X thread compiler | — | Yes |
| Writing autopsy | — | Yes |
| Anti-AI writing guide (EN + 中文) | — | Yes |
| Vibe coding stack reference | — | Yes |
| **Total skills** | **4** | **17** |
| **Total files** | **24** | **40+** |

**[Get the Pro version on Gumroad →](https://jazzpujols34.gumroad.com/l/claude-work-workflow)**

## Read the full write-up

- [Part 1: 3 files that make Claude Code remember your project](https://x.com/Jazzpujols34/status/2031582021152367081) (SPEC.md, CLAUDE.md, HANDOVER.md)
- [Part 2: 3 files that turn Claude Code into your dev partner](https://x.com/Jazzpujols34/status/2031620670631596110) (soul.md, hooks, MEMORY.md)

## Contributing

This is an open-source workflow system. If you've built extensions, new skills, or knowledge files that could help others, PRs are welcome.

## License

MIT
