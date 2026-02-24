# Context Budget

Action-based checkpoints. Replaces token counting with measurable behaviors.

---

## Core Principle

> LLMs cannot count their own tokens. Measure ACTIONS (files read, tools called, lines written), not tokens. Checkpoint after actions, not at token thresholds.

---

## Checkpoint Protocol

### Soft Checkpoint (self-assessment, ~0 cost)

Trigger after:
- Every 10 deep file reads
- Every 30 tool calls
- Every 200 lines of output written

Action: Ask "Can I answer/complete now?"
- YES → synthesize and proceed
- NO, specific gap → read ≤5 targeted files, then re-assess
- NO, broad gap → delegate to sub-agent

### Hard Checkpoint (mandatory action)

Trigger after:
- 25 deep reads total in one SA
- 50 tool calls total in one SA
- Cumulative output exceeding target by 2×

Action: MUST either synthesize, delegate, or checkpoint state to files. Continuing without action = violation.

---

## Read Strategy

|Need|Method|Cost|
|-|-|-|
|File being modified|Full read (mandatory)|High|
|Primary analysis target|Full read (mandatory)|High|
|Finding patterns|`grep_search`|Low|
|Understanding structure|`list_dir`, `tree`|Very Low|
|Concept discovery|`semantic_search`|Medium|
|Already processed by SA|Read handoff only|Low|

### Tree-Before-Deep Pattern

Before deep-reading any directory, get structural overview first:
```
list_dir → identify candidates → prioritize → deep-read critical files only
```

If >20 candidate files identified, prioritize before deep reading.

---

## Overflow Detection

|Signal|Action|
|-|-|
|Response truncating|Stop, checkpoint to file, spawn sub-agent|
|Forgetting early context|Checkpoint, summarize working memory to file|
|Repetitive re-reading|Context saturated — delegate to fresh SA|
|>100 files touched|Spawn sub-agent for partitioning|

---

## Quality Constraints (Absolute — Do NOT Scale)

These are focus/readability limits, not capacity limits:

|Constraint|Value|Purpose|
|-|-|-|
|Researcher output|≤100 lines|Focus|
|Designer summary|≤50 lines|Specificity|
|Handoff|≤80 lines|Communication clarity|
|Implementer deliverables|≤3 per SA|Scope discipline|
|SA dispatch|≤2k tokens|Dispatch clarity|
|Compiled agent|<3k tokens|Deployment size|

---

## Post-Summarization Verification

After summarizing context or checkpointing:
1. Re-read original dispatch/prompt
2. Verify current work aligns with initial inputs
3. Check no requirements were lost

---

## Integration

Agents embed checkpoints in their workflow phases — no standalone "context management" section needed. Each phase self-regulates via the checkpoint protocol above.

Referenced by: `orchestrator.src.md`, `output-budget.md`, `thoroughness.md`
