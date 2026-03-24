---
name: revenue-potential
description: Use when prioritizing which project to work on next based on revenue readiness and path to cash flow. Trigger on "which project should I focus on", "revenue priority", "what makes money".
---

# Skill: Revenue Potential Assessment

> Evaluate which projects have the best path to cash flow.
> Usage: `Read .claude/skills/revenue-potential.md and evaluate [project name]`

## Inputs Required

- [ ] Project name
- [ ] Current completion %
- [ ] Pricing model
- [ ] Target customer
- [ ] Distribution channel

## Scoring Matrix

| Factor | Weight | Score (1-5) |
|--------|--------|-------------|
| **Payment Ready** | 25% | Can they pay you TODAY? |
| **Clear Pricing** | 20% | Is pricing defined and tested? |
| **Customer Access** | 20% | Can you reach 10 customers this week? |
| **Repeat Revenue** | 15% | Will they pay again? |
| **Defensibility** | 10% | Hard to copy? |
| **Your Energy** | 10% | Do you WANT to sell this? |

## Quick Assessment

### Tier 1: Revenue Ready (Score 4+)
- Payment infrastructure live
- Pricing tested
- At least 1 paying customer OR clear path to first sale

### Tier 2: Almost There (Score 3-4)
- Product works
- Pricing defined but not tested
- No payment flow yet

### Tier 3: Not Ready (Score < 3)
- Still building
- No pricing
- No distribution

## Output Format

```
PROJECT: [name]
SCORE: [X.X / 5.0]
TIER: [1/2/3]
BLOCKER: [what's stopping revenue]
NEXT ACTION: [unblock the blocker]
```

## Gotchas

- **"Payment Ready" is binary, not gradual.** Either someone can pay you today or they can't. "Stripe is set up but no checkout flow" = No.
- **Customer Access ≠ audience.** Having 1000 Twitter followers doesn't mean you can reach 10 paying customers this week. The question is: can you DM or email 10 specific people who would buy?
- **Repeat revenue is overweighted in fantasy.** Subscription sounds great but many products are one-shot purchases. Score honestly.
