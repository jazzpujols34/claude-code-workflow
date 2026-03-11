# Example: Real HANDOVER.md

> This is a real handover from a podcast transcription pipeline project.
> Notice how specific it is — file paths, commit hashes, exact next steps, gotchas.
> A good handover lets the next session start working in under 30 seconds.

---

# Session Handover - PodSight Pipeline

**Date:** 2026-03-05
**Status:** Pipeline WORKING. Major cleanup + name/ticker accuracy fixes shipped.

## What We Did This Session

### Phase 1: Codebase Cleanup
- Deleted dead code: `04_transcribe_gcp.py`, `auto_check_new_episodes.py`, `docs/gcp/`
- Fixed `server.py` reference to deleted script → now uses `auto_pipeline.py`
- **Commit:** `abdc512`

### Phase 2: Code Deduplication
- Extracted `parse_episode_range()` and `get_episode_number_from_filename()` into `config.py` (were duplicated in 3-4 scripts)
- Removed unused legacy config exports (`RSS_URL`, `AUDIO_DIR`, etc.)
- **Commit:** `01b62dc`

### Phase 3: Name & Ticker Accuracy Audit (BIG ONE)

**Guest name audit:** 55% error rate across summaries. Fixed 19 files.

| Guest | Wrong | Correct | Episodes |
|-------|-------|---------|----------|
| Name A | Phonetic misspelling | Correct characters | 7 eps |
| Name B | Wrong alias | Real name | 3 eps |
| Name C | Partial name | Full name | 4 eps |

**Stock ticker audit:** 53 corrections across 24 files.

### Prevention: Custom Prompts Updated

All custom prompt files now have:
1. **Correction tables** — known names that Whisper gets wrong
2. **"Omit if unsure" rule** — wrong info is worse than no info
3. **Transcription artifact warning** — don't copy nonsense from transcript

## What to Watch

### Immediate (next few days)
- **Monitor next CI runs** — do the updated prompts prevent name errors?
- EP1048 was the last episode with old prompts. EP1049+ should use the new ones.
- If names are still wrong, the correction table may need to be more aggressive.

### Known Remaining Issues
1. **Hallucinated company names from transcription** — "omit if unsure" rule should help, but may need a post-processing validation step
2. **Episode ID complexity** — Three different formats still in play. Works but fragile.
3. **CI transcription timeouts** — If API rate-limits, transcription silently produces 0 output.

## Key Files Changed

| File | What changed |
|------|-------------|
| `src/config.py` | Added shared utils, removed legacy exports |
| `src/pipeline/03_transcribe.py` | Fixed exit codes, removed duplicate util |
| `src/pipeline/04_summarize.py` | Removed duplicate utils, imports from config |
| `data/*/custom_prompt.txt` | Added correction tables + omit-if-unsure rule |
| `CLAUDE.md` | Full rewrite with folder structure + conventions |

## Quick Debug Commands

```bash
# Check what needs processing
python -c "
from pipeline.auto_pipeline import get_episodes_needing_summary
for p in ['podcast_a', 'podcast_b']:
    need = get_episodes_needing_summary(p)
    print(f'{p}: {len(need)} need summary')
"

# Check CI status
gh run list --limit 5
```

---

> **What makes this handover good:**
> 1. Specific commit hashes — next session can verify what shipped
> 2. Tables for bulk changes — scannable, not buried in paragraphs
> 3. "What to Watch" section — proactive, not just "here's what I did"
> 4. Debug commands — next session can verify state immediately
> 5. Known issues with severity — next session knows what's fragile
