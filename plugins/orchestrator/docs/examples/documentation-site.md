# Documentation Site: Music Theory Notes

## Prompt

> I have markdown notes about music theory in `notes/`. Turn them into a static website I can use as a personal learning reference. Group by topic, add navigation.

## What Happens

Non-coding project — the orchestrator handles content transformation the same way it handles code. The pipeline researches the source material, designs the site structure, then generates it.

### Pipeline: Research → Design → Implement

**Research phase** catalogs:
- 12 markdown files in `notes/` covering scales, chords, intervals, rhythm, keys
- Some files reference each other informally ("see the scales doc")
- No existing build tooling or framework preferences

**Design phase** produces:
- Topic groupings: Fundamentals (intervals, scales, keys), Harmony (chords, progressions), Rhythm
- Static site using a lightweight generator (e.g., Eleventy or plain HTML)
- Navigation sidebar with topic hierarchy
- Cross-references converted to actual links

**Implementation phase** builds:
- Site scaffold with nav layout
- Converts and organizes the 12 source files
- Adds a landing page with topic overview
- Outputs build instructions

## Why This Works

The orchestrator doesn't care if the task is "code" or "content." It decomposes, researches, designs structure, and implements — the same pipeline applies to documentation, learning resources, or any structured output.
