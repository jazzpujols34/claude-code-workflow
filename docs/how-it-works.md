# How It Works — Deep Dive

This document explains the thinking behind each component of the Claude Code Workflow system.

## The Core Problem

Claude Code has a context window. When it fills up, everything resets. Your next session knows nothing about:

- What you were building
- What decisions you made
- What mistakes were already fixed
- What your coding standards are
- What your project architecture looks like

Most developers accept this as a limitation. This system treats it as a **solvable problem**.

## Component 1: CLAUDE.md — Persistent Project Memory

### What It Is

A markdown file at your project root that Claude Code automatically reads at session start. It's the single source of truth for "everything Claude needs to know about this project."

### Why It Works

Claude Code has a built-in behavior: it looks for `CLAUDE.md` in the working directory and loads it into context. By structuring this file well, you effectively give Claude a pre-loaded brain at the start of every session.

### What Goes In It

**Must have:**
- Project overview (what it is, tech stack, deploy target)
- Key commands (dev, build, test, deploy)
- Coding standards (TypeScript strict, no `any`, Tailwind only)
- Learned rules (mistakes that should never repeat)

**Should have:**
- Architecture overview (directory structure, data flow)
- Guardrails (what to NEVER do)
- References to other context files (skills, knowledge, pm-handbook)

**Nice to have:**
- PM system integration
- Compound automation references
- Project-specific CLAUDE.md references for sub-projects

### The Learned Rules Pattern

This is the most powerful section. Format:

```markdown
### Rule N: [Short title]
- **Trigger**: What happened / what went wrong
- **Correct behavior**: What should have been done
- **Date**: YYYY-MM-DD
```

Every time Claude makes a mistake and you correct it, add a rule. Over weeks, this accumulates into a project-specific knowledge base that prevents repeat errors.

Real example: "Rule: R2 presigned URLs expire. Never store them in DB. Store the R2 key, generate URL at render time." This rule prevented a production bug from happening again.

## Component 2: HANDOVER.md — Session Continuity

### What It Is

An ephemeral file that captures the state of work at the end of one session, so the next session can pick up exactly where you left off.

### The Relay Protocol

```
Session A: work → write HANDOVER.md → end
Session B: read HANDOVER.md → overwrite with new state → work → end
Session C: read HANDOVER.md → overwrite → work → ...
```

Key rule: **never act on a stale baton**. A HANDOVER.md from 3 sessions ago is worse than none — so the *next* session overwrites it (or archives it to `HANDOVER.archive/`). "Overwrite," not "`rm` the only copy": if you commit handovers, git already keeps the history.

> **2026 note:** Claude Code now has native, file-based **Memory** that survives across sessions, and it auto-compacts long conversations instead of hard-resetting. That doesn't make HANDOVER.md obsolete — it changes its job. Memory holds *durable* project facts; HANDOVER.md is the *human-curated baton* for one session: the exact next step, what's uncommitted, what to watch. Use both. See the README's "Where this meets native Claude Code" section.

### What Goes In It

1. What you were doing (1-2 sentences)
2. Current state (files being edited, what's working/broken)
3. Exact next steps (specific enough that a new session can execute immediately)
4. Key decisions made this session (and why)
5. Gotchas discovered (so the next session doesn't hit the same wall)

### What Makes a Good Handover

See [examples/real-handover.md](../examples/real-handover.md) for a real-world example. The best handovers have:

- **Commit hashes** — so the next session can verify what shipped
- **Tables for bulk changes** — scannable, not buried in paragraphs
- **"What to watch" sections** — proactive warnings, not just status
- **Debug commands** — so the next session can verify state immediately
- **Known issues with severity** — so the next session knows what's fragile

### Why This Beats "Just Re-explain"

Re-explaining takes 5-10 minutes and loses nuance. A good HANDOVER.md takes 30 seconds to write and preserves:
- The specific file paths being worked on
- The exact error that was being debugged
- The approach that was chosen (and why alternatives were rejected)
- Uncommitted changes that need attention

## Component 3: soul.md — Personality Layer

### What It Is

A file that defines how Claude communicates with you. Your working style, values, pet peeves, and preferences.

### Why It Exists

Without it, Claude defaults to "helpful assistant" mode — verbose, cautious, always agreeing. With soul.md, Claude adapts:

- **Direct communicators** get shorter, punchier responses
- **Detail-oriented builders** get thorough explanations
- **"Challenge me" types** get genuine pushback on bad ideas
- **"Ship fast" builders** get pragmatic suggestions, not perfect ones

### What Goes In It

- Who you are and what you're building (context)
- Communication style (direct? detailed? humorous?)
- Values in priority order (when values conflict, higher wins)
- What to avoid (over-engineering, fluff, sugarcoating)
- The "why" behind your projects (motivation)

### The Key Insight

The more honest your soul.md is, the better Claude adapts. It's not a resume — it's a working manual for your AI partner.

## Component 4: DASHBOARD.md — Multi-Project Awareness

### What It Is

A single file that shows the status of all your projects at a glance. Think of it as your project management layer.

### Why It Exists

When you have multiple projects (common for indie developers and side-project builders), the hardest question is "what should I work on next?" The dashboard answers this by:

1. Showing completion percentage for each project
2. Surfacing blockers across projects
3. Maintaining a priority stack based on clear criteria

### The Priority Framework

Rank work using these criteria (in order):
1. **Security** — Fix deployed vulnerabilities first
2. **Revenue** — Prioritize what makes money
3. **Completion proximity** — Finish what's 90% done
4. **Git hygiene** — Commit before starting new work
5. **Energy matching** — Switch projects when stuck

## Component 5: Skills — Reusable Decision Frameworks

### What They Are

Structured markdown files that encode repeatable decision processes. Instead of thinking through "should I build this?" from scratch every time, you run a framework.

### How They Work

Each skill file has `name` + `description` frontmatter. Claude Code reads that frontmatter and **auto-triggers** the skill when your request matches — you state intent, the right framework fires:

```
You: "Is a reading-tracker app worth building?"

Claude: (auto-fires should-i-build-this) → scores each criterion, outputs a verdict.
```

The explicit `Read .claude/skills/X.md and evaluate ...` form still works as a manual override when you want to force a specific skill. A skill can be one `.md` file or a folder with a `SKILL.md` entry point (for skills that ship scripts/assets).

### Why Encode Decisions

1. **Consistency** — Same quality decision at 2 AM as at 10 AM
2. **Speed** — No need to rebuild the mental model each time
3. **Learning** — The framework improves as you add criteria
4. **Delegation** — Claude can make decisions that match your values

### When to Create a New Skill

If you've made the same type of decision 3+ times, formalize it.

## Component 6: Knowledge — Technical Memory

### What It Is

Markdown files that capture hard-won technical lessons. Things you learned the hard way and never want to re-learn.

### The Rule

> If you learned something the hard way twice, write it down.

### Format

Each knowledge file covers one topic:
- Context (why this knowledge exists)
- The pattern (what works, with code examples)
- What doesn't work (common mistakes)
- Gotchas (non-obvious things)

### Real Examples

This repo ships three knowledge files:

- **`edge-runtime-patterns.md`** — Choosing a Cloudflare runtime (OpenNext/Node vs edge) and the constraints that apply to each
- **`payment-integration.md`** — Webhook-first architecture, idempotent handlers, signature verification, test vs production credential management
- **`example-learning.md`** — The blank template for capturing your own learnings

### How It Connects

CLAUDE.md references knowledge files:
```markdown
**Knowledge** in `.claude/knowledge/`:
- `edge-runtime-patterns.md` — Edge Runtime constraints
- `payment-integration.md` — Payment provider setup
```

When working on payments, Claude reads the knowledge file first. This prevents re-discovering the same gotchas.

## Component 7: PM Handbook — The Full Playbook

### What It Is

A 10-chapter playbook covering the complete project lifecycle — from inception to production safety.

### The Chapters

| Chapter | What It Covers |
|---------|---------------|
| 1-3 | Foundation, status checks, priority framework |
| 4 | New project inception (challenge the problem first) |
| 5 | Session handover protocol |
| 6 | Pointer to the single security checklist (Chapter 9) |
| 7 | Skills & knowledge system |
| 8 | Dashboard update protocol (when and how to update) |
| 9 | **Security audit** — full checklist across 6 categories (auth, input validation, API security, secrets, data privacy, infrastructure) |
| 10 | **Production safety** — 6-layer defense framework (validation, error handling, monitoring, rate limiting, rollback, backup) |

### Why Chapters 9 and 10 Matter

Chapter 9 (Security Audit) gives you a concrete checklist to run before any project goes live. It catches the common mistakes: exposed secrets, missing rate limiting, CORS misconfiguration, and unverified webhooks.

Chapter 10 (Production Safety) is the "what could go wrong" framework. Six layers of defense so that when (not if) something breaks, the blast radius is contained and recovery is fast.

## Component 8: Automations — Daily Workflow

### What They Are

Shell aliases that invoke Claude Code with specific prompts. One command to get your morning briefing, evaluate an idea, or run a security audit.

### Setup

```bash
# 1. Copy the template
cp scripts/automations-template.sh ~/.claude-automations.sh

# 2. Edit PROJECT_ROOT in the file

# 3. Add to your shell config
echo 'source ~/.claude-automations.sh' >> ~/.zshrc

# 4. Reload
source ~/.zshrc
```

### Available Commands

| Command | What It Does |
|---------|-------------|
| `morning` | Top 3 priorities, blockers, quick wins |
| `status` | Current state of all projects |
| `evaluate "idea"` | Run should-i-build-this framework |
| `weekly` | Week in review across all projects |
| `handover` | Write session handover |
| `learn "topic"` | Capture a new knowledge file |
| `audit "project"` | Run security checklist |

### Why Shell Aliases

- **Friction reduction** — `morning` is faster than opening Claude Code and typing a prompt
- **Consistency** — Same prompt produces comparable outputs
- **Habit formation** — Easy commands become daily rituals

## The Compound Effect

Each component is useful alone. Together, they create a flywheel:

1. **CLAUDE.md** gives Claude context -> better code from session 1
2. **soul.md** matches Claude's communication to your style -> less friction
3. **HANDOVER.md** preserves progress -> no repeated work
4. **Learned Rules** prevent mistakes -> fewer bugs over time
5. **Skills** make decisions faster -> more time building
6. **Knowledge** prevents re-learning -> compounding expertise
7. **DASHBOARD.md** clarifies priorities -> less wasted effort
8. **PM Handbook** systematizes operations -> consistent quality
9. **Automations** reduce friction -> system gets used daily

After a couple of months of real use, a system like this accumulates:
- 15+ learned rules
- A handful of knowledge files
- 4 decision frameworks
- A 10-chapter PM handbook
- Daily automations

Every session is faster than the last. Context compounds. Mistakes don't repeat. That's the system.

## Where this meets native Claude Code (2026)

This kit predates several Claude Code primitives that now ship in the box. It still earns its place — but as *conventions layered on top of* the harness, not a replacement for it. Use the native feature where it exists; keep the convention for the judgment it encodes.

| This kit's convention | Native primitive (2026) | How they fit together |
|---|---|---|
| Skills as `.md` you `Read` manually | **Skills auto-trigger** from `description` frontmatter | The files here already have the frontmatter — let them fire on intent; `Read X.md` is a manual override. |
| `HANDOVER.md` relay | File-based **Memory** + auto-compaction | Memory = durable project facts. HANDOVER = the per-session human baton (exact next step, uncommitted state). |
| Shell aliases (`morning`, `audit`) | **Hooks** (`settings.json` lifecycle events) | Aliases are still handy at the terminal. Hooks enforce behavior *inside* the session — see `templates/settings.json`. |
| "Every correction = a Learned Rule" (prose) | A **Stop / PostToolUse hook** can remind you | Keep the rule; let a hook nudge you to actually capture it. |
| Manual multi-project status sweep | **Subagents** (parallel Task fan-out) | One agent per project, in parallel, then synthesized — faster than serial. |

If you've used Claude Code in 2026, reach for the native primitive first and let these conventions carry the parts the harness doesn't: *what* to decide, *what* to write down, *what* good looks like.
