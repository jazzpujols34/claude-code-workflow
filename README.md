# Claude Code Workflow

A complete AI-assisted development system for Claude Code. Not just a CLAUDE.md template — a full operating system for shipping products at 10x speed.

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
    ├── pm-handbook.md     # PM playbook — status checks, priorities, inception
    ├── soul.md            # Personality layer — communication style, values
    ├── skills/            # Decision frameworks — reusable strategic thinking
    │   ├── should-i-build-this.md
    │   ├── ship-or-iterate.md
    │   ├── revenue-potential.md
    │   └── mvp-launch-checklist.md
    ├── knowledge/         # Technical learnings — hard-won lessons
    │   └── [topic].md
    └── automations.md     # Shell aliases — morning briefing, status checks
```

### What Each Piece Does

| File | Purpose | When It's Read |
|------|---------|----------------|
| `CLAUDE.md` | Project context, coding standards, learned rules | Every session (auto-loaded) |
| `HANDOVER.md` | What happened last session, exact next steps | Start of new session, then deleted |
| `DASHBOARD.md` | All projects at a glance, priority stack | When planning what to work on |
| `pm-handbook.md` | How to check status, set priorities, start new projects | When doing PM work |
| `soul.md` | Communication preferences, values, what to avoid | Every session (referenced by CLAUDE.md) |
| `skills/*.md` | Structured decision frameworks | Before strategic decisions |
| `knowledge/*.md` | Technical patterns and gotchas | When working on related features |
| `automations.md` | Shell aliases for common workflows | Setup once, use daily |

## The Result

This system was used to build **12+ projects in ~2 months**, with 3+ deployed to production with live payments. Including:

- An AI memorial video platform (Next.js, Cloudflare Pages, Stripe/ECPay)
- A podcast transcription pipeline (Python, 100+ episodes processed)
- A vocabulary learning app (React Native, Expo)
- An AI art gallery with auth and admin (React + FastAPI)
- A personal website with CMS (React + FastAPI + SQLite)

The speed comes from **compounding context** — each session builds on the last instead of starting from scratch.

## Quick Start

### Option 1: Copy the essentials (5 minutes)

```bash
# In your project root
mkdir -p .claude/skills .claude/knowledge

# Copy the three core files
cp templates/CLAUDE.md ./CLAUDE.md        # Edit for your project
cp templates/HANDOVER.md ./HANDOVER.md    # Use as-is
cp templates/DASHBOARD.md ./DASHBOARD.md  # Edit for your projects
```

Then edit `CLAUDE.md` with your project's specifics.

### Option 2: Full system (15 minutes)

```bash
# Copy everything
cp templates/CLAUDE.md ./CLAUDE.md
cp templates/HANDOVER.md ./HANDOVER.md
cp templates/DASHBOARD.md ./DASHBOARD.md

# PM system
cp templates/pm-handbook.md ./.claude/pm-handbook.md

# Decision frameworks
cp skills/*.md ./.claude/skills/

# Automations
cp scripts/automations-template.sh ./setup-automations.sh
```

Edit each file to match your project. The templates have `[PLACEHOLDER]` markers for everything you need to customize.

### Option 3: Just CLAUDE.md (2 minutes)

If you want to start minimal:

```bash
cp templates/CLAUDE.md ./CLAUDE.md
```

This single file gives you 80% of the benefit. Add the rest as you feel the need.

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

Context windows have limits. When one session ends, write a `HANDOVER.md`. The next session reads it, deletes it, and continues seamlessly.

**The cycle:** read -> delete -> work -> write -> hand off.

This turns Claude Code from a "single session tool" into a **persistent development partner**.

### 3. Skills — Reusable Decision Frameworks

Instead of re-thinking "should I build this?" every time, encode your decision process once:

```
Read .claude/skills/should-i-build-this.md and evaluate: "An app that tracks reading habits"
```

Claude runs your framework and gives you a structured verdict. Same quality decision every time, zero cognitive load.

### 4. Knowledge — Technical Memory

Every hard-won lesson gets captured:

```
Read .claude/knowledge/cloudflare-edge-patterns.md before implementing the API route
```

You learn something once. Claude remembers it forever.

### 5. Compound Automation

Shell scripts that orchestrate multi-step Claude Code workflows:

```bash
# Morning briefing
morning    # Reads DASHBOARD.md, gives top 3 priorities

# Evaluate new idea
evaluate "An app that helps people track reading habits"
```

## File Reference

```
templates/
├── CLAUDE.md              # Starter CLAUDE.md with all sections
├── HANDOVER.md            # Session handover template
├── DASHBOARD.md           # Multi-project dashboard template
└── pm-handbook.md         # PM playbook template

skills/
├── should-i-build-this.md # Evaluate new project ideas
├── ship-or-iterate.md     # Ship vs. keep building
├── revenue-potential.md   # Prioritize by cash flow
└── mvp-launch-checklist.md # Pre-launch checklist

knowledge/
└── example-learning.md    # Template for capturing learnings

scripts/
└── automations-template.sh # Shell aliases for daily workflow

examples/
├── monorepo-claude-md.md  # Real CLAUDE.md from a 12-project monorepo
└── project-claude-md.md   # Real CLAUDE.md from a deployed Next.js app

docs/
└── how-it-works.md        # Deep dive on each component
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

The PM handbook's inception process (Chapter 7):
1. **Question requirements** — What problem? Who needs it? What exists?
2. **Try to delete** — For every feature: "what if we remove this?"
3. **Simplify** — Only after deleting
4. **Speed up** — Only after simplifying
5. **Automate** — Last step, not first

### 4. Ship beats perfect

The `ship-or-iterate` skill encodes this: if the core value prop works and 3 users can complete the main flow, **ship it**. The last 20% takes 80% of the time.

## FAQ

**Q: Does this work for teams?**
A: Yes. Commit `.claude/` to git. Every team member gets the same context. Add `soul.md` per-developer if needed.

**Q: How often should I update CLAUDE.md?**
A: After every session where you learn something. It should be a living document.

**Q: What if my project is simple?**
A: Start with just `CLAUDE.md`. Add the rest when you feel the friction.

**Q: Can I use this with other AI coding tools?**
A: The concepts (persistent context, session handover, decision frameworks) apply to any AI coding tool. The file format is Claude Code specific.

## Contributing

This is an open-source workflow system. If you've built extensions, new skills, or knowledge files that could help others, PRs are welcome.

## License

MIT
