# MEMORY.md — durable memory index

> Claude Code (2026) has native, file-based **Memory**: facts it writes once and recalls
> across sessions, independent of the context window. This file is the human-readable
> **index** of that memory — one line per fact, pointing at the file that holds it.
>
> Where the memory lives depends on your setup; Claude Code surfaces the path. The pattern
> below is what matters: an index here, one fact per file, links between related facts.

## How this differs from the rest of the kit

| Layer | Holds | Lifespan |
|-------|-------|----------|
| `CLAUDE.md` | Project rules, standards, architecture | The project's lifetime (you edit it) |
| **Memory (this index)** | Durable facts Claude learned and should recall | Across all sessions, auto-recalled |
| `HANDOVER.md` | The exact next step for *one* session | Until the next session overwrites it |

Rule of thumb: if it's a *standing fact* ("the staging DB is read-only", "deploys go through `make ship`, never raw `gcloud`"), it belongs in Memory. If it's "where I am right now," it belongs in HANDOVER.md. If it's "how this project is built," it belongs in CLAUDE.md.

## Index (one line per memory)

<!-- Add a pointer when Claude saves a memory. Keep content in the linked file, not here. -->

### Project facts
- [Deploy path](./deploy-path.md) — how this project ships, and the one command never to bypass

### Preferences / corrections
- [Review discipline](./review-discipline.md) — enumerate-then-check before claiming "all clear"

### People / context
- _(add as you go)_

## Writing a memory (the shape)

Each memory is one file, one fact:

```markdown
---
name: deploy-path
description: how this project ships — used to decide relevance on recall
type: project   # project | preference | reference | person
---

Deploys go through `make ship` (runs tests → bumps version → tags → pushes).
Never `gcloud run deploy` by hand — it skips the version tag and breaks rollback.
Related: [[rollback-runbook]]
```

- **One fact per file.** Don't pile unrelated facts together — recall works better when each file is about one thing.
- **Write a `description` that reads like a search hit.** It's what decides whether the fact gets pulled into a future session.
- **Link related memories** with `[[name]]`. A link to a memory you haven't written yet is fine — it marks one worth writing.
- **Delete memories that turn out wrong.** A confidently-wrong memory is worse than none.
- **Don't duplicate the repo.** Code structure, git history, and CLAUDE.md rules don't belong here — only the non-obvious facts you'd otherwise re-explain.
