# Example: A Session, Start to Finish

> What the system actually feels like in one session — a skill auto-firing on intent,
> the handover baton picked up and put down, a correction becoming a rule.
> Lightly edited from a real session. The point is the *shape*, not the specifics.

---

## Session start — the baton gets picked up

The `SessionStart` hook (from `templates/settings.json`) prints `HANDOVER.md` into context automatically. The session opens already knowing where it left off:

```
=== HANDOVER.md (baton from last session) ===
Doing: wiring Stripe webhook for the pro tier.
State: /api/webhooks/stripe.ts written, signature check TODO. Nothing committed.
Next: verify signature with the webhook secret BEFORE crediting; make the handler idempotent.
Watch: ECPay handler next door is NOT idempotent — don't copy its pattern.
```

> **You:** continue from the handover.

No re-explaining. It already has the next step and the landmine to avoid.

---

## A skill fires without being named

Mid-session, a new idea comes up:

> **You:** random thought — is a "webhook replay debugger" SaaS worth building?

The phrasing matches `should-i-build-this`'s `description`, so it **auto-fires** — no `Read .claude/skills/...` needed:

```
VERDICT: PROTOTYPE (1 week max)
REASON: Real pain (webhook debugging is miserable) but thin willingness-to-pay
        signal and you'd be 1 of 20 tools. Distribution is the open question.
NEXT ACTION: DM 5 people who've shipped webhooks this month. If 3 say "I'd pay,"
             build the prototype. Otherwise, pass.
```

Back to the actual task.

---

## A correction becomes a Learned Rule

> **You:** you're crediting the account before verifying the signature. Fix the order.

It fixes the handler, then — prompted by the `Stop` hook and the kit's "every correction = a rule" convention — captures it so it never recurs. Into `CLAUDE.md`:

```markdown
### Rule 7: Verify webhook signature BEFORE any side effect
- **Trigger**: Credited the account, then verified the signature (backwards)
- **Correct behavior**: Verify signature first; only mutate state on a valid, not-yet-seen event id
- **Date**: 2026-06-08
```

And, because it's a *standing fact* about how this project handles payments, a durable memory (see `templates/MEMORY.md`) — so future sessions recall it even without reading the rule.

---

## Session end — the baton gets put down

The `Stop` hook reminds: capture learnings, overwrite the handover. The session **overwrites** `HANDOVER.md` (not `rm` — the previous baton's job is done):

```
Doing: Stripe pro-tier webhook.
State: signature verified, handler idempotent on event id, committed (a1b2c3d).
Next: add the ECPay handler's idempotency the same way — it's still unsafe.
Watch: run `stripe trigger checkout.session.completed` to retest after the ECPay change.
```

---

## What just happened

In one session: context arrived pre-loaded (hook + handover), a decision framework fired on intent (auto-trigger), a mistake turned into a permanent rule (CLAUDE.md) and a recalled fact (Memory), and the next session was set up in three lines (handover). Nothing was re-explained. That's the compounding — and notice how much of it is the *native* harness (hooks, skills, memory) doing the work, with this kit supplying the conventions on top.
