---
name: ship-or-iterate
description: Use when a project feels "almost done" and you need to decide whether to release, keep building, or kill it. Trigger on "should I ship", "is this ready", "should I keep working on this".
---

# Skill: Ship or Iterate?

> Decide whether to ship current version or keep polishing.
> Usage: `Read .claude/skills/ship-or-iterate.md and evaluate [project name]`

## The Question

You've built something. Should you:
1. **SHIP** — Release it now, learn from users
2. **ITERATE** — Fix/add more before releasing
3. **PIVOT** — Current direction is wrong

## Decision Framework

### Ship If (ANY true):
- [ ] Core value proposition works
- [ ] First 3 users can complete the main flow
- [ ] You're polishing instead of building
- [ ] You've been "almost done" for > 1 week
- [ ] You're avoiding user feedback

### Iterate If (ALL true):
- [ ] Critical bug blocks main flow
- [ ] Payment doesn't work (if monetized)
- [ ] Legal/security risk exists
- [ ] User literally cannot complete task

### Pivot If (ANY true):
- [ ] You've lost interest for > 2 weeks
- [ ] Market feedback is consistently negative
- [ ] Better opportunity appeared
- [ ] Original problem no longer exists

## The 80% Rule

If the product is 80% of your vision and 100% functional for the core use case -> SHIP.

The last 20% takes 80% of the time. Get user feedback first.

## Anti-Patterns

| Behavior | Translation | Action |
|----------|-------------|--------|
| "Just one more feature" | Fear of judgment | SHIP |
| "It's not perfect yet" | Perfectionism | SHIP |
| "Need to refactor first" | Procrastination | SHIP |
| "Users won't understand" | Avoiding feedback | SHIP |
| "The market isn't ready" | Excuse | SHIP or KILL |

## Output Format

```
DECISION: [SHIP / ITERATE / PIVOT]
REASON: [1 sentence]
IF SHIP: [where to post / who to tell]
IF ITERATE: [specific task, max 3 days]
IF PIVOT: [kill or archive?]
```

## Gotchas

- **"Ship" doesn't mean "announce."** Shipping can mean deploying quietly and sending to 3 test users. Don't conflate shipping with a Product Hunt launch.
- **Payment flow is a hard gate.** If the product is monetized and payment doesn't work, that's always ITERATE — no exceptions.
- **The "almost done" trap.** If you've said "almost done" for more than 5 days, you're iterating on polish, not value. Ship.
