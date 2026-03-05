# CLAUDE.md — [Your Project Name]

> This file is automatically read by Claude Code at the start of every session.
> It's your project's brain — architecture, standards, guardrails, and lessons learned.

## Project Overview

**[Project Name]** — [One sentence: what it does, who it's for]

**Stack:** [e.g., Next.js, React, TypeScript, Tailwind CSS, FastAPI, Python]
**Deploy:** [e.g., Vercel, Cloudflare Pages, Render]
**Status:** [MVP / Beta / Production / Maintenance]

### Architecture

```
[your-project]/
├── src/               # [describe]
├── api/               # [describe]
├── components/        # [describe]
└── ...
```

<!-- Add a brief architecture note if non-obvious. E.g.:
"React frontend calls FastAPI backend. Auth via Clerk. Files stored in R2."
Keep it to 2-3 sentences max. -->

## PM System

<!-- Remove this section if you don't use the full PM system. -->

When asked about project status, priorities, or starting new features:
1. Read `.claude/pm-handbook.md`
2. Update `DASHBOARD.md` when status changes

**Session Handover:**
When context window is approaching limits, write `HANDOVER.md`. New sessions read this first.
The cycle: **read -> delete -> work -> write -> hand off.**

**Soul:** Read `.claude/soul.md` for communication style and values.

## Skills & Knowledge

<!-- Remove sections you don't use. -->

**Skills** (decision frameworks) in `.claude/skills/`:
- `should-i-build-this.md` — Evaluate new project ideas
- `ship-or-iterate.md` — Release decisions
- `revenue-potential.md` — Prioritize by cash flow
- `mvp-launch-checklist.md` — Pre-launch checklist

**Knowledge** (technical learnings) in `.claude/knowledge/`:
- `[topic].md` — [what it covers]

## Core Principle

> "The best builders aren't better at coding. They're better at knowing what NOT to build."

Before building any feature:
1. Does a tool/service already solve this? (Auth -> Clerk, Payments -> Stripe, Files -> R2)
2. Is this the core value prop, or infrastructure? (Only build the core)
3. Can this wait until after launch? (Ship first, add later)

## Development Standards

### Key Conventions

- [e.g., Strict TypeScript — `strict: true` in tsconfig]
- [e.g., No `any` types except documented escape hatches]
- [e.g., Tailwind CSS for styling, no inline styles]
- [e.g., Type hints for all Python function signatures]

### Error Handling

- Catch errors explicitly, never silent failures
- User-friendly error messages separate from technical errors
- [Add project-specific error patterns]

### Git Workflow

**Branch Naming:** `feature/`, `fix/`, `chore/`

**Commit Messages:** Conventional Commits format:
- `feat:` — New feature
- `fix:` — Bug fix
- `refactor:` — Code restructuring
- `docs:` — Documentation
- `test:` — Test changes
- `chore:` — Build, CI, dependencies

## Key Commands

```bash
# Development
[command]              # [what it does]

# Build
[command]              # [what it does]

# Test
[command]              # [what it does]

# Deploy
[command]              # [what it does]
```

## Coding Guardrails

**Before writing code:**
- Describe approach first and wait for approval if requirements are ambiguous.
- If a task touches more than 3 files, break it down first.

**After writing code:**
- List what could break and suggest tests.
- Run the code. Verify it works. Don't assume.

**Debugging:**
- Write a test that reproduces the bug first.
- Change one thing at a time.
- If a fix takes more than 3 attempts, re-examine the root assumption.

## Continuous Learning

When Claude makes a mistake or the user corrects something, add it here:

## Learned Rules

<!-- Example:
### Rule 1: [Short title]
- **Trigger**: What happened / what went wrong
- **Correct behavior**: What should have been done
- **Date**: YYYY-MM-DD
-->
