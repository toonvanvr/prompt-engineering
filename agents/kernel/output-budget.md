# Output Budget

Token-aware output generation. Prevents response truncation and context overflow.

---

## Core Principle

> Estimate before generating. Write to files, reference paths. Track cumulative load.

---

## Task Sizing

Size determined at interpretation phase. Affects all downstream behavior.

### Size Formula

```
score = (files × 10) + (domains × 30) + (estimated_lines × 0.5)
```

### Size Thresholds

|Size|Files|Domains|Score|
|-|-|-|-|
|S (Small)|≤3|≤1|<50|
|M (Medium)|4-8|≤2|50-150|
|L (Large)|>8|>2|≥150|

### Domain Classification

|Domain|Examples|
|-|-|
|Frontend|UI, components, styles, client logic|
|Backend|API, services, database, auth|
|Infra|CI/CD, deployment, config, scripts|
|Kernel|Agent rules, templates, modes|
|Docs|README, guides, specs|

---

## Scaling Rules

Behavior scales with task size:

|Aspect|S|M|L|
|-|-|-|-|
|Sub-agent threshold|Optional|Preferred|Mandatory|
|Verbosity|Normal|Terse|Minimal|
|Max output/response|500 lines|300 lines|150 lines|
|Context flush|None|Phase boundary|Every sub-agent|
|Inline impl|Allowed|Discouraged|Forbidden|

### Verbosity Tiers

**Normal (S):**
- Full explanations
- Examples included
- Reasoning visible

**Terse (M):**
- Key points only
- No examples unless critical
- Compressed reasoning

**Minimal (L):**
- Action + result only
- Reference paths, don't quote
- No elaboration

---

## Output Budget Protocol

### Pre-Output Check

Before generating substantial output:

```
1. Estimate line count
2. Check against size limit (S:500, M:300, L:150)
3. If exceeds: write to file, reference path
4. If within: inline acceptable
```

### Artifact-First Rule

|Output Type|S|M|L|
|-|-|-|-|
|Code blocks|Inline OK|File preferred|File required|
|Analysis|Inline OK|Summary inline, detail in file|File only|
|Plans|Inline OK|Inline OK|File required|
|Explanations|Full|Condensed|Reference docs|

### Cumulative Tracking

Track context load throughout task:

```
cumulative_load = (deep_reads × 40) + (skim_reads × 10) + (output_lines × 2)
```

**Thresholds:**

|Load|Action|
|-|-|
|<1000|Continue|
|1000-1500|Consider sub-agent|
|>1500|Mandatory sub-agent split|

### No Re-Read Rule

Files read in prior phases MUST NOT be re-read. Use:
- Handoff summaries
- Extracted references
- Cached decisions

Exception: File modified since last read.

---

## Integration Points

### At Interpretation

1. Count estimated files to modify
2. Identify domains touched
3. Estimate lines of change
4. Calculate score → assign size
5. Declare size + verbosity tier

### At Sub-Agent Dispatch

Include in dispatch:
```md
## Task Sizing
Size: {S|M|L}
Verbosity: {Normal|Terse|Minimal}
Output limit: {500|300|150} lines/response
```

### At Phase Transition

Add to handoff:
```md
## Context Consumed
|Metric|Count|
|-|-|
|Deep reads|{n}|
|Skim reads|{n}|
|Output lines|{n}|
|Cumulative load|{score}|
```

---

## Warning Signs

|Signal|Meaning|Action|
|-|-|-|
|Output truncating|Hit response limit|Split to file|
|Repeating explanations|Context pressure|Increase terseness|
|Long code blocks|Exceeding budget|Write to file|
|Multiple re-reads|Inefficient access|Use cached refs|

---

## Summary

```
Size task: score = (files×10)+(domains×30)+(lines×0.5)
S:<50, M:50-150, L:≥150

Output limits: S:500, M:300, L:150 lines
Cumulative: >1500 → spawn sub-agent

Write to files. Reference paths. Track load.
```
