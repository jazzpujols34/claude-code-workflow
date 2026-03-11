# Knowledge: Edge Runtime Patterns

> Constraints and workarounds for deploying to edge runtimes (Cloudflare Workers/Pages, Vercel Edge).
> Read this before: deploying API routes to edge, using KV/R2, or debugging edge-specific failures.

## Context

Edge runtimes (Cloudflare Workers, Vercel Edge Functions) run in V8 isolates, not Node.js. This means no `fs`, no `path`, limited `crypto`, and no long-running processes. Every gotcha below was discovered through a production deployment.

## The Pattern

### Key Constraints

| What | Limit | Workaround |
|------|-------|------------|
| Bundle size | ~25 MB | Code split, tree shake, avoid heavy SDKs |
| Execution time | ~30s before kill | Client-polling, not background jobs |
| Memory | Shared across isolates | Use KV/R2, not in-memory state |
| Node.js APIs | Limited subset | Use Web APIs (fetch, crypto.subtle, etc.) |

### What Works

**1. Client-Driven Polling (not fire-and-forget)**

```
POST /generate → return job ID → client polls /status/[id]
```

Each poll checks external API, updates KV, returns status. Never rely on background execution.

**2. KV for State (not in-memory)**

```typescript
// Edge isolates don't share memory. Use KV.
await env.KV.put(`job:${id}`, JSON.stringify(data), { expirationTtl: 86400 })
const result = JSON.parse(await env.KV.get(`job:${id}`))
```

**3. Web Crypto (not Node crypto)**

```typescript
// Node: crypto.createHmac('sha256', secret)
// Edge:
const key = await crypto.subtle.importKey(
  'raw', encoder.encode(secret),
  { name: 'HMAC', hash: 'SHA-256' }, false, ['sign']
)
const signature = await crypto.subtle.sign('HMAC', key, encoder.encode(payload))
```

**4. Route Runtime Export (Next.js on Cloudflare)**

```typescript
// Every route MUST have this or build fails silently
export const runtime = 'edge'
```

### What Doesn't Work

```typescript
// All of these fail on edge:
import fs from 'fs'           // No filesystem
import path from 'path'       // No path module
globalThis.cache = new Map()  // Lost between requests
setTimeout(() => {}, 5000)    // Killed after 30s
import Stripe from 'stripe'  // SDK too heavy — use raw fetch
```

### Why

Edge isolates are designed for fast, stateless request handling. They spin up and down per-request. Anything that assumes persistence (memory, filesystem, long-running processes) will break.

## Gotchas

- `waitUntil()` exists but is unreliable for anything over a few seconds
- Turbopack cache corruption causes phantom errors: fix with `rm -rf .next && npm run dev`
- R2 presigned URLs expire — never store them in DB. Store the R2 key, generate URL at render time.
- Some npm packages silently import Node.js modules. Check bundle with `npx wrangler deploy --dry-run`

## References

- [Cloudflare Workers Runtime APIs](https://developers.cloudflare.com/workers/runtime-apis/)
- [Next.js Edge Runtime](https://nextjs.org/docs/app/api-reference/edge)
