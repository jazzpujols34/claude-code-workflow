# PM Handbook

> Read this file when asked about project status, priorities, "what should I work on",
> cross-project planning, or dashboard updates.

---

## Chapter 1: Foundation

**Developer:** [Your name]
**Projects:** [count] projects. [X] active, [Y] shipped, [Z] archived.

### Active Projects

| Project | Tech | Deploy | Status File |
|---------|------|--------|-------------|
| [project-1] | [stack] | [platform] | [path to status file] |
| [project-2] | [stack] | [platform] | [path to status file] |

### When to Escalate

- Security vulnerabilities in deployed projects
- Build failures on deployed projects
- Data loss risks (uncommitted work, expiring URLs)

---

## Chapter 2: Status Check Protocol

### For Each Active Project

1. Read its status file (path in Chapter 1)
2. Run `git -C [path] log --oneline -5` for recent activity
3. Run `git -C [path] status --short` for uncommitted changes
4. Identify: current focus, next action, blockers

### Quick Status Template

```
[project] [progress%] — [current focus] — [blocker or "clear"]
```

---

## Chapter 3: Priority Framework

Rank work across projects using these criteria (in order):

1. **Security** — Fix deployed vulnerabilities first
2. **Revenue** — Prioritize projects with paying customers
3. **Completion proximity** — Finish what's 90% done
4. **Git hygiene** — Commit outstanding work before starting new features
5. **Energy matching** — If stuck on one project, suggest switching

### Decision Protocol

When asked "what should I work on?":
1. Read all active project status files
2. Check git status for uncommitted work
3. Apply the priority framework
4. Recommend ONE specific task with reasoning
5. If user disagrees, respect their preference

---

## Chapter 4: New Project Inception

When starting a **new project**, run through this before writing any code.

### Step 1: Challenge the Problem

Work through this filter sequentially. Do NOT skip.

1. **Question the requirements** — What problem? Who needs it? What exists already?
2. **Try to delete** — For every feature: "what if we remove this entirely?"
3. **Simplify** — Only after deleting. Reduce moving parts.
4. **Speed up** — Only after simplifying.
5. **Automate** — Last step, not first.

### Step 2: Discovery Questions

Before writing any plan, ask the user:

1. What is the single most important outcome this project needs to achieve?
2. Who is the target user, and what's their current painful workflow?
3. What's the simplest possible version that delivers value (true MVP)?
4. What are the hard constraints (tech stack, integrations, deployment)?
5. What does failure look like — what should we specifically avoid building?

### Step 3: Master Plan

After receiving answers, produce:

- **Goal**: One sentence.
- **Non-goals**: What we're explicitly NOT building.
- **Architecture**: High-level design. Prefer boring, proven technology.
- **Task Breakdown**: Ordered deliverables, each completable in one session.
- **Open Questions**: Unknowns that could change the plan.

---

## Chapter 5: Session Handover Protocol

When context window is nearly full, write a handover file.

### File Location

- Project-specific: `[project]/HANDOVER.md`
- Cross-project: `.claude/HANDOVER.md`

### Handover Contents

1. What we were doing (1-2 sentences)
2. Current state (files being edited, last completed step, next step)
3. Key decisions made (and why)
4. Blockers / open questions
5. Commands to resume
6. Context the next session needs

### New Session Start

Read `HANDOVER.md` first, delete it, then continue from "Next step".

---

## Chapter 6: Security Audit Protocol

Run before any project goes live.

### Checklist Categories

1. Rate Limiting
2. Authentication & Authorization
3. Input Validation
4. API Security
5. Environment & Secrets
6. Dependencies
7. HTTPS & Headers
8. Error Handling
9. Data & Privacy

### Output

```
## Audit Result: [Project]
- Passed: X/9 categories
- Issues Found: [list]
- Action Items: [prioritized fixes]
```

---

## Chapter 7: Skills & Knowledge System

### Skills (Decision Frameworks)

Located in `.claude/skills/`. Each skill is a structured decision process.

| Skill | Use When |
|-------|----------|
| `should-i-build-this.md` | Evaluating new project ideas |
| `revenue-potential.md` | Prioritizing by cash flow |
| `ship-or-iterate.md` | Deciding release vs. continue |
| `mvp-launch-checklist.md` | Before launching any product |

**Usage:**
```
Read .claude/skills/should-i-build-this.md and evaluate: [idea description]
```

**Adding new skills:** After making a repeatable decision type 3+ times, formalize it.

### Knowledge (Technical Learnings)

Located in `.claude/knowledge/`. Captures hard-won lessons.

**Rule:** If you learned something the hard way twice, write it down.

### Maintaining the System

1. After completing a project phase: extract learnings to `knowledge/`
2. After a strategic decision: consider if it's a repeatable pattern for `skills/`
3. Monthly: review for outdated information
