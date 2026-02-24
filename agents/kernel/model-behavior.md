# Model Behavior Guidance
Cross-model consistency. Resolves ambiguous rule interpretations.

## Core Principle
> Rules must produce identical behavior across models. Ambiguity resolved here.

## Conflict Resolutions
### "Never assume context survives SA boundary" vs "Never re-read files"
"Never assume" = USE FILE HANDOFFS (not conversation memory). Does NOT mean re-read SA-processed files. SA handoff = evidence.

### "MUST read entire document" vs "Read minimum needed"
"Read entire document" = files agent is WORKING ON (primary target). "Read minimum needed" = routing, reporting, verification.

### "UNLIMITED TIME on critical files" vs "80% context ceiling"
No artificial speed pressure — not unlimited context consumption. 80% ceiling always applies.

## Behavioral Guidance
|Behavior|Rule|
|-|-|
|Re-verify SA output|Trust handoff; lightweight checks only (`verification-methods.md`)|
|Read depth for routing|Skim: structure + summary section only|
|Thoroughness scope|Full-read ONLY files being worked on as primary target|
|SA handoff trust|`Status: COMPLETE` = gate evidence|

## Model Profiles

Known model-specific tendencies. Apply corrective rules when model is identified.

### Claude Opus
|Tendency|Correction|
|-|-|
|Over-verification: re-reads SA output files to "make sure"|Trust handoff. `verification-methods.md` ONLY.|
|Verbose output: fills available space|Enforce line limits strictly. Prefer tables over prose.|
|Premature summarization of working context|Summarize for HANDOFFS, not during active work.|

### GPT (4o / Codex)
|Tendency|Correction|
|-|-|
|Lazy implementation: skips edge cases, minimal effort|Require explicit edge-case checklist in dispatch.|
|Optimistic gate-passing: "probably works"|Gate = evidence-based. Command output or file diff required.|
|Tool-call avoidance: answers from training data|Force tool use: "Read file X before answering."|

### Default (Unknown Model)
Apply all behavioral guidance above. No model-specific corrections. If behavior drifts, log to `.ai/self-analysis/` with category `MODEL_DRIFT`.

## Integration
Referenced by: `orchestrator.src.md`, `output-budget.md`
