# Example: Single Project CLAUDE.md

> This is a real (sanitized) CLAUDE.md from a deployed Next.js app on Cloudflare Pages
> with live payments. Adapted from a production memorial video platform.

---

```markdown
# CLAUDE.md — [App Name]

## Overview

AI-powered video generation platform. Users upload photos + text, AI generates
memorial videos. Deployed on Cloudflare Pages with Edge Runtime.

**Stack:** Next.js (App Router), TypeScript, Tailwind, Cloudflare Workers/R2/KV (OpenNext)
**Payments:** Stripe (international) + ECPay (Taiwan)
**Status:** Production (live with paying users)

## Architecture

```
app/
├── (marketing)/     # Landing, pricing — static
├── (app)/           # Authenticated app — dynamic
│   ├── create/      # Video creation wizard
│   ├── gallery/     # User's generated videos
│   └── account/     # Billing, settings
├── api/             # API routes (Edge Runtime)
│   ├── generate/    # Video generation endpoint
│   ├── webhooks/    # Stripe + ECPay callbacks
│   └── upload/      # R2 file uploads
└── components/      # Shared UI components
```

## Edge Runtime Constraints

This runs on Cloudflare Workers. Critical limitations:
- NO Node.js `crypto` — use Web Crypto API
- NO `fs` module — use R2 for file storage
- NO `Buffer` — use Uint8Array
- Request timeout: 30s (use queues for long tasks)
- Bundle size limit: 1MB after minification

Read `.claude/knowledge/edge-runtime-patterns.md` for full patterns.

## Key Commands

```bash
npm run dev              # Local dev (miniflare)
npm run build            # Production build
npm run deploy           # Deploy to Cloudflare Pages
npm run db:migrate       # Run D1 migrations
npm test                 # Vitest
```

## Payment Integration

- Stripe: standard checkout session flow
- ECPay: server-to-server, return URL + notification URL pattern
- NEVER log payment amounts or card details
- Test mode keys in .env.local, production keys in Cloudflare dashboard

Read `.claude/knowledge/payment-integration.md` before touching payment code.

## Coding Standards

- TypeScript strict mode, no `any`
- Tailwind only (no CSS modules, no inline styles)
- All API routes must validate input with Zod
- All database queries use parameterized statements
- Error responses: `{ error: string, code: string }` format

## Guardrails

- NEVER expose API keys in client components
- NEVER store PII in KV key names (they appear in logs)
- ALWAYS check auth before accessing user data
- ALWAYS validate file uploads (type, size, filename)

## Backlog

Current priorities in `reports/backlog.md`. Items prefixed with [DONE] are complete.
The compound script (`scripts/compound/auto-compound.sh`) reads this file
and picks the first non-done item.

## Learned Rules

### Rule 1: R2 presigned URLs expire
- **Trigger**: Users reported broken video links after 24 hours
- **Correct behavior**: Generate presigned URLs on-demand, never store them in DB.
  Store the R2 key, generate URL at render time.
- **Date**: 2026-01-20

### Rule 2: ECPay webhook is NOT idempotent
- **Trigger**: Duplicate credits given when ECPay sent retry webhooks
- **Correct behavior**: Check transaction ID in DB before crediting.
  Use DB transaction with unique constraint on ecpay_trade_no.
- **Date**: 2026-02-01

### Rule 3: Edge Runtime has no setTimeout > 30s
- **Trigger**: Video generation timed out on Edge
- **Correct behavior**: Use Cloudflare Queues for long-running tasks.
  API route queues the job, client polls for completion.
- **Date**: 2026-02-08
```

---

## Key Takeaways

1. **Edge Runtime Constraints** is the most-referenced section. Without it, Claude
   repeatedly tries to use Node.js APIs that don't exist on the Edge.

2. **Learned Rules** with real dates tell a story. Rule 2 (ECPay webhook) would have
   cost real money if it happened again.

3. **Payment Integration** section prevents the #1 security risk: leaking payment data.
   Simple guardrails that Claude checks every time.

4. **Backlog reference** connects Claude to the compound automation system.
   It knows where to find priorities without asking.

5. **Guardrails section** is defensive. These are the "NEVER do this" rules that
   prevent catastrophic mistakes in production.
