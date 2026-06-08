# Knowledge: Cloudflare / Edge Runtime Patterns

> How to choose a runtime when deploying Next.js (and similar) to Cloudflare, and the
> constraints that apply *only if you opt into the edge runtime*.
> Read this before: deploying to Cloudflare, wiring KV/R2, or debugging a runtime-specific failure.
> Last reviewed: June 2026.

## First decision: which runtime?

As of mid-2026 there are two real paths for Next.js on Cloudflare, and they have **opposite** rules. Pick one before writing any route.

| | **OpenNext (recommended default)** | **Edge runtime (opt-in)** |
|---|---|---|
| Adapter | `@opennextjs/cloudflare` | `@cloudflare/next-on-pages` or raw Workers |
| Runtime | **Node.js** (workerd `nodejs_compat`) | V8 isolate, Web-APIs only |
| `export const runtime = 'edge'` | **Remove it** — the adapter rejects it | Required on every dynamic route |
| Node built-ins (`node:crypto`, `Buffer`) | Available | Not available — use Web APIs |
| Heavy SDKs (Stripe, etc.) | Work normally | Often too heavy — use `fetch` |
| Best for | Most apps. Fewer constraints, normal Node code | Ultra-low-latency, globally-distributed handlers |

> Cloudflare now recommends OpenNext over next-on-pages, and next-on-pages only supports
> the edge runtime. If you scaffolded a project before ~2025 with `export const runtime = 'edge'`
> on every route, migrating to OpenNext means **deleting** those exports — leaving them in
> breaks the OpenNext build.
> Refs: [Cloudflare Next.js guide](https://developers.cloudflare.com/workers/framework-guides/web-apps/nextjs/) · [OpenNext](https://opennext.js.org/cloudflare)

**If you're on OpenNext / Node runtime, most of the constraints below do not apply** — write normal Node code. The rest of this file is for the edge-runtime path.

## Edge-runtime constraints (only when you opt into `runtime = 'edge'`)

Edge runtimes run in V8 isolates, not Node.js: no `fs`, no `path`, no Node built-ins, no long-running processes. Every gotcha below was discovered through a production edge deployment.

| What | Limit | Workaround |
|------|-------|------------|
| Bundle size | ~3 MB per Worker (compressed) | Code split, tree shake, avoid heavy SDKs |
| CPU time | ~30s wall on a single request; long jobs get killed | Client-polling, not background jobs |
| Memory | Not shared across isolates | Use KV/R2/D1, not in-memory state |
| Node APIs | Web-APIs subset only | `fetch`, `crypto.subtle`, `TextEncoder`, etc. |

### What works on edge

**1. Client-driven polling (not fire-and-forget)**

```
POST /generate → return job ID → client polls /status/[id]
```

Each poll checks the external API, updates KV, returns status. Never rely on background execution surviving past the response.

**2. KV/D1 for state (not in-memory)**

```typescript
// Edge isolates don't share memory. Persist it.
await env.KV.put(`job:${id}`, JSON.stringify(data), { expirationTtl: 86400 })
const result = JSON.parse(await env.KV.get(`job:${id}`))
```

**3. Web Crypto (not Node crypto) — edge only**

```typescript
// Node runtime: import { createHmac } from 'node:crypto'  ← fine on OpenNext
// Edge runtime: must use Web Crypto
const key = await crypto.subtle.importKey(
  'raw', encoder.encode(secret),
  { name: 'HMAC', hash: 'SHA-256' }, false, ['sign']
)
const signature = await crypto.subtle.sign('HMAC', key, encoder.encode(payload))
```

### What fails on edge (and is fine on Node/OpenNext)

```typescript
import fs from 'fs'            // No filesystem on edge
import path from 'path'        // No path module on edge
globalThis.cache = new Map()   // Lost between requests on edge (isolates)
setTimeout(() => {}, 60_000)   // Won't survive past the response on edge
import Stripe from 'stripe'    // Too heavy for edge — use raw fetch; works fine on Node
```

### Why

Edge isolates spin up and down per-request for fast, stateless handling. Anything that assumes persistence (memory, filesystem, long-running processes) breaks. The Node runtime (OpenNext) relaxes most of this — which is why it's the better default unless you specifically need edge.

## Gotchas (apply to both paths unless noted)

- `waitUntil()` exists but is unreliable for anything over a few seconds (edge).
- Turbopack cache corruption causes phantom errors: `rm -rf .next && npm run dev`.
- R2 presigned URLs expire — never store them in the DB. Store the R2 key, generate the URL at render time.
- Some npm packages silently import Node built-ins. On edge, check the bundle with `npx wrangler deploy --dry-run`; on OpenNext, a failing build usually names the offending module.
- Migrating off next-on-pages? Search-and-destroy every `export const runtime = 'edge'` first — that's the #1 OpenNext build break.

## References

- [Deploy Next.js to Cloudflare (official guide)](https://developers.cloudflare.com/workers/framework-guides/web-apps/nextjs/)
- [OpenNext — Cloudflare adapter](https://opennext.js.org/cloudflare)
- [Cloudflare Workers Runtime APIs](https://developers.cloudflare.com/workers/runtime-apis/)
