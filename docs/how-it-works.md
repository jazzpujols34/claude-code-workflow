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
Session B: read HANDOVER.md → delete it → work → write new HANDOVER.md → end
Session C: read HANDOVER.md → delete it → work → ...
```

Key rule: **delete after reading**. A stale HANDOVER.md from 3 sessions ago is worse than no HANDOVER.md at all.

### What Goes In It

1. What you were doing (1-2 sentences)
2. Current state (files being edited, what's working/broken)
3. Exact next steps (specific enough that a new session can execute immediately)
4. Key decisions made this session (and why)
5. Gotchas discovered (so the next session doesn't hit the same wall)

### Why This Beats "Just Re-explain"

Re-explaining takes 5-10 minutes and loses nuance. A good HANDOVER.md takes 30 seconds to write and preserves:
- The specific file paths being worked on
- The exact error that was being debugged
- The approach that was chosen (and why alternatives were rejected)
- Uncommitted changes that need attention

## Component 3: DASHBOARD.md — Multi-Project Awareness

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

## Component 4: Skills — Reusable Decision Frameworks

### What They Are

Structured markdown files that encode repeatable decision processes. Instead of thinking through "should I build this?" from scratch every time, you run a framework.

### How They Work

```
You: "Read .claude/skills/should-i-build-this.md and evaluate: 'A reading tracker app'"

Claude: Runs through the framework, scores each criterion, outputs a verdict.
```

### Why Encode Decisions

1. **Consistency** — Same quality decision at 2 AM as at 10 AM
2. **Speed** — No need to rebuild the mental model each time
3. **Learning** — The framework improves as you add criteria
4. **Delegation** — Claude can make decisions that match your values

### When to Create a New Skill

If you've made the same type of decision 3+ times, formalize it.

## Component 5: Knowledge — Technical Memory

### What It Is

Markdown files that capture hard-won technical lessons. Things you learned the hard way and never want to re-learn.

### The Rule

> If you learned something the hard way twice, write it down.

### Format

Each knowledge file covers one topic:
- Context (why this knowledge exists)
- The pattern (what works)
- What doesn't work (common mistakes)
- Gotchas (non-obvious things)

### How It Connects

CLAUDE.md references knowledge files:
```markdown
**Knowledge** in `.claude/knowledge/`:
- `edge-patterns.md` — Edge Runtime constraints
- `payment-integration.md` — Stripe/ECPay setup
```

When working on payments, Claude reads the knowledge file first. This prevents re-discovering the same gotchas.

## Component 6: Automations — Daily Workflow

### What They Are

Shell aliases that invoke Claude Code with specific prompts. One command to get your morning briefing, evaluate an idea, or write a handover.

### Why Shell Aliases

- **Friction reduction** — `morning` is faster than opening Claude Code and typing a prompt
- **Consistency** — Same prompt produces comparable outputs
- **Habit formation** — Easy commands become daily rituals

## The Compound Effect

Each component is useful alone. Together, they create a flywheel:

1. **CLAUDE.md** gives Claude context -> better code from session 1
2. **HANDOVER.md** preserves progress -> no repeated work
3. **Learned Rules** prevent mistakes -> fewer bugs over time
4. **Skills** make decisions faster -> more time building
5. **Knowledge** prevents re-learning -> compounding expertise
6. **DASHBOARD.md** clarifies priorities -> less wasted effort
7. **Automations** reduce friction -> system gets used daily

After 2 months, the system has:
- 15+ learned rules
- 4+ knowledge files
- 4 decision frameworks
- A PM handbook
- Daily automations

Every session is faster than the last. Context compounds. Mistakes don't repeat. That's the system.
