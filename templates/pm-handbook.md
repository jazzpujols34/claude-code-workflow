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

## Chapter 6: Pre-Launch Security Basics

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

---

## Chapter 8: Dashboard Update Protocol

### When to Update

- After completing a significant task or milestone
- When priorities shift (new blocker, new opportunity)
- At minimum during weekly review
- When a project status changes (active -> shipped, active -> on hold)

### Update Checklist

1. Update progress percentages
2. Update "Current Focus" column
3. Move completed projects to "Shipped / Maintenance"
4. Update "Priority Stack" if priorities changed
5. Add to "Recent Wins" if something shipped
6. Remove resolved blockers
7. Commit: `chore: update project dashboard`

### Staleness Rule

If DASHBOARD.md hasn't been updated in 7+ days, treat it as potentially unreliable. Run a fresh status check (Chapter 2) before making decisions based on it.

---

## Chapter 9: Security Audit Protocol

Run before any project goes live. Trigger with: "run security audit on [project]"

### The Checklist

#### 1. Authentication & Authorization
- [ ] Auth uses a trusted provider (Clerk, Supabase Auth, etc.) — not DIY
- [ ] JWT tokens are httpOnly, secure, sameSite
- [ ] Session expiry is configured (not infinite)
- [ ] Admin routes are protected server-side (not just hidden in UI)
- [ ] Password reset flow works correctly

#### 2. Input Validation
- [ ] All user input validated server-side (Zod, Pydantic, etc.)
- [ ] File uploads restricted by type and size
- [ ] SQL/NoSQL injection prevented (parameterized queries or ORM)
- [ ] XSS prevented (no dangerouslySetInnerHTML without sanitization)

#### 3. API Security
- [ ] Rate limiting on all public endpoints
- [ ] CORS configured for specific origins (not `*` in production)
- [ ] API keys not exposed in client-side code
- [ ] Webhook endpoints verify signatures before processing

#### 4. Environment & Secrets
- [ ] `.env` files in `.gitignore`
- [ ] No secrets in git history (check with `git log -p | grep -i "api_key\|secret\|password"`)
- [ ] Production and test credentials separated
- [ ] All secrets rotatable without code changes

#### 5. Data & Privacy
- [ ] User data encrypted at rest (if sensitive)
- [ ] Privacy policy exists and is accurate
- [ ] No PII logged in plain text
- [ ] Data deletion flow exists (GDPR/user request)

#### 6. Infrastructure
- [ ] HTTPS enforced (no HTTP fallback)
- [ ] Security headers set (X-Frame-Options, CSP, etc.)
- [ ] Dependencies up to date (no known CVEs)
- [ ] Error messages don't leak internal details to users

### Output Format

```
## Security Audit: [Project Name]
**Date:** YYYY-MM-DD
**Auditor:** [Claude / your name]

### Results: X/6 categories passed

| Category | Status | Issues |
|----------|--------|--------|
| Auth | PASS/FAIL | [details] |
| Input Validation | PASS/FAIL | [details] |
| API Security | PASS/FAIL | [details] |
| Env & Secrets | PASS/FAIL | [details] |
| Data & Privacy | PASS/FAIL | [details] |
| Infrastructure | PASS/FAIL | [details] |

### Action Items (prioritized)
1. [Critical] ...
2. [High] ...
3. [Medium] ...
```

---

## Chapter 10: Production Safety Framework

The 6-layer defense framework for deployed applications.

### Layer 1: Validation

Catch problems before they reach your system.

- Input validation at API boundaries (Zod, Pydantic)
- Type checking at build time (TypeScript strict, mypy)
- Schema validation for database writes
- **Rule:** Validate at the edge, trust internally.

### Layer 2: Error Handling

When something goes wrong, fail gracefully.

- Custom error classes for domain errors
- User-friendly messages (separate from technical errors)
- Error boundaries in React (catch rendering failures)
- Never silent failures — log, alert, or surface every error
- **Rule:** The user should never see a stack trace.

### Layer 3: Monitoring

Know when something breaks before users tell you.

- Error tracking (Sentry, LogRocket)
- Uptime monitoring (UptimeRobot, Better Uptime)
- Performance monitoring (Lighthouse CI, Web Vitals)
- Log aggregation for debugging production issues
- **Rule:** If it's not monitored, assume it's broken.

### Layer 4: Rate Limiting & Abuse Prevention

Protect your system from abuse and runaway costs.

- Rate limiting on all public endpoints
- Cost caps on AI API calls (set billing alerts)
- Request size limits
- Bot detection for sensitive endpoints
- **Rule:** Your API will be abused. Plan for it.

### Layer 5: Rollback

When things go wrong, go back to what worked.

- Deployment rollback in < 5 minutes
- Database migration rollback plan for every migration
- Feature flags for risky features (ship off, turn on gradually)
- Git tags on every production deploy
- **Rule:** If you can't roll back in 5 minutes, you're not ready to deploy.

### Layer 6: Backup & Recovery

The last line of defense.

- Database backups (automated, tested)
- File storage backups (R2/S3 versioning)
- Recovery runbook: step-by-step guide to restore from backup
- Test recovery annually (untested backups are not backups)
- **Rule:** Backups you haven't tested are just hopes.
