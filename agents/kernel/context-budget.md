# Context Budget

Action-based measurement. Checkpoints in `quality-gates.md` § Action-Based Checkpoints.

## Core Principle

> LLMs cannot count tokens. Measure ACTIONS (files read, tools called, lines written), not tokens.

## Read Strategy

|Need|Method|Cost|
|-|-|-|
|File being modified|Full read (mandatory)|High|
|Primary analysis target|Full read (mandatory)|High|
|Finding patterns|`grep_search`|Low|
|Understanding structure|`list_dir`, `tree`|Very Low|
|Concept discovery|`semantic_search`|Medium|
|Already processed by SA|Read handoff only|Low|

**Tree-Before-Deep:** Get structural overview before deep-reading directories. If >20 candidates, prioritize first.

## Quality Constraints (Do NOT Scale)

|Constraint|Value|Purpose|
|-|-|-|
|Researcher output|≤100 lines|Focus|
|Designer summary|≤50 lines|Specificity|
|Handoff|≤80 lines|Clarity|
|Implementer deliverables|≤3 per SA|Scope discipline|
|SA dispatch|≤2k tokens|Dispatch clarity|
|Compiled agent|<3k tokens|Deployment size|

## Post-Summarization Verification

After summarizing/checkpointing: re-read original dispatch, verify alignment, check no requirements lost.