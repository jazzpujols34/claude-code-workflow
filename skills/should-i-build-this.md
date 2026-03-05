# Skill: Should I Build This?

> Decision framework for evaluating new project ideas.
> Usage: `Read .claude/skills/should-i-build-this.md and evaluate: "[your idea]"`

## Inputs Required

- [ ] Problem description (1-2 sentences)
- [ ] Target user (specific persona)
- [ ] Existing solutions (competitors)
- [ ] Your unique angle

## Decision Criteria

| Criterion | Question | Score |
|-----------|----------|-------|
| **Pain Severity** | Is this a painkiller or vitamin? | 1-5 |
| **Willingness to Pay** | Would someone pay for this? | Y/N |
| **10x Better** | Can you be 10x better/cheaper/faster than alternatives? | Y/N |
| **Time to MVP** | Can you ship in < 2 weeks? | Y/N |
| **Distribution** | Do you have access to first 10 users? | Y/N |
| **Personal Fit** | Do YOU want to use this? | Y/N |

## Scoring

- **Pain >= 4 AND 3+ Yes** -> BUILD
- **Pain >= 3 AND 2+ Yes** -> PROTOTYPE (1 week max)
- **Otherwise** -> PASS or REVISIT

## Anti-Patterns (Don't Build If...)

- "It would be cool if..." (no pain)
- "Everyone needs this" (no specific user)
- "I'll figure out monetization later" (no WTP signal)
- "Just needs marketing" (distribution hopium)

## Output Format

```
VERDICT: [BUILD / PROTOTYPE / PASS]
REASON: [1 sentence]
NEXT ACTION: [specific step]
```
