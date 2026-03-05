```skill
# Prompt Audit

## Description
Preserve every user prompt for audit trail and context recovery.

## Startup Sequence
1. Create `{scratchSessionDir}/00_prompts/` subdirectory
2. Copy initial prompt verbatim to `00_prompts/00_initial_request.md`
3. Never modify the original prompt text

## Naming Convention

|Source|Filename|
|-|-|
|Initial user prompt|`00_initial_request.md`|
|Human feedback|`01_feedback.md`|
|Human redirect|`02_redirect.md`|
|Subsequent inputs|`{seq}_{action}.md`|

## Rules
- Sequence numbers are zero-padded: `01`, `02`, ..., `99`
- Track prompt lineage through SAs via dispatch context
- Nothing is lost; everything is traceable
```
