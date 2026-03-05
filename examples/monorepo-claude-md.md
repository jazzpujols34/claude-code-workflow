# Example: Monorepo CLAUDE.md

> This is a real (sanitized) CLAUDE.md from a 12-project monorepo that shipped 6 products in 2 months.
> Use this as inspiration for structuring your own.

---

```markdown
# CLAUDE.md - Project Guide

## Repository Overview

**[Monorepo Name]** is a multi-project monorepo. Each subdirectory is an independent project
with its own CLAUDE.md (if needed).

### Projects

- **project-a** - AI video generation platform (Next.js, Cloudflare Pages)
- **project-b** - Quotes mobile app (React Native, Expo)
- **project-c** - AI gallery with auth and admin (React + FastAPI)
- **project-d** - AI component generator (Next.js)
- **project-e** - Podcast transcription pipeline (Python)

### Archived (`_archive/`)

- **old-project-1** - HTML presentations
- **old-project-2** - Live lottery web app (React/Vite, Vercel)

## PM System

When asked about project status, priorities, "what should I work on", or starting a new project:
1. Read `.claude/pm-handbook.md` (PM handbook)
2. For new projects: follow Chapter 4 (Challenge the Problem → Discovery Questions → Master Plan)
3. For status/priorities: follow Chapters 2-3
4. Update `DASHBOARD.md` when status changes

**Session Handover:**
HANDOVER.md is an ephemeral baton — only one exists at a time.
1. Agent A (approaching context limit): Write HANDOVER.md
2. Agent B (new session): Read HANDOVER.md, delete it, continue work
3. Agent B (approaching limit): Write fresh HANDOVER.md for Agent C

The cycle: read → delete → work → write → hand off.

## Skills & Knowledge

**Skills** in `.claude/skills/`:
- `should-i-build-this.md` — Evaluate new project ideas
- `revenue-potential.md` — Prioritize by cash flow
- `ship-or-iterate.md` — Release decisions
- `mvp-launch-checklist.md` — Pre-launch checklist

**Knowledge** in `.claude/knowledge/`:
- `cloudflare-edge-patterns.md` — Edge Runtime constraints
- `payment-integration.md` — ECPay/Stripe integration
- `mobile-app-launch.md` — iOS submission

## Core Principle

> "The best builders aren't better at coding. They're better at knowing what NOT to build."

Before building any feature:
1. Does a tool/service already solve this? (Auth → Clerk, Payments → Stripe, Files → R2)
2. Is this the core value prop, or infrastructure?
3. Can this wait until after launch?

## Development Standards

### TypeScript/JavaScript
- Strict TypeScript (`strict: true`)
- No `any` types except documented escape hatches
- Tailwind CSS for styling (no inline styles)
- Vitest + React Testing Library for tests

### Python
- Type hints for all function signatures
- Pydantic models for data validation
- Async/await for I/O operations

### Git Workflow
- Branch: `feature/`, `fix/`, `chore/`
- Conventional Commits: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`

## Coding Guardrails

**Before writing code:**
- Describe approach first if requirements are ambiguous.
- If task touches 3+ files, break it down first.

**After writing code:**
- List what could break and suggest tests.
- Run the code. Verify it works.

**Debugging:**
- Write a test that reproduces the bug first.
- Change one thing at a time.
- 3 failed attempts → re-examine the root assumption.

## Learned Rules

### Rule 1: Icons over emojis in UI
- **Trigger**: Generated HTML with emojis for UI elements
- **Correct behavior**: Use SVG icons or icon fonts (Lucide, Heroicons) for all UI.
  Emojis only in content text, never for controls or decorative elements.
- **Date**: 2026-02-12

### Rule 2: Never assume framework API without checking
- **Trigger**: Used deprecated Next.js API that didn't exist in current version
- **Correct behavior**: Read the actual docs or check node_modules before using an API
- **Date**: 2026-02-15
```

---

## Key Takeaways

1. **The PM System section** is what makes this a "management layer" not just a config file.
   It tells Claude how to think about priorities, not just how to write code.

2. **Session Handover** is critical for long-running projects. Without it, every new context
   window starts from zero.

3. **Learned Rules** compound over time. After 2 months, this repo had 15+ rules that
   prevented repeat mistakes.

4. **Core Principle** section shapes Claude's decision-making before it writes any code.
   This one line ("know what NOT to build") saved dozens of hours.

5. **Project-specific CLAUDE.md files** keep the root file manageable. Each subdirectory
   has its own context.
