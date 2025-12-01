# Context Budget

Token/file limits by task type. Prevents context overflow.

---

## Core Principle

> Read minimum needed. Context is finite. Quality degrades with overflow.

---

## Limits by Task Type

### Analysis Tasks

|Metric|Deep Read|Skim Read|Total Files|
|-|-|-|-|
|Standard|10-15|25-50|60-65|
|Complex|15-20|50-75|90 max|

**Deep Read:** Full file content, understand implementation
**Skim Read:** Structure only, identify patterns

### Design Tasks

|Metric|Deep Read|Skim Read|Total Files|
|-|-|-|-|
|Standard|5-10|15-25|30-35|
|Complex|10-15|25-40|50 max|

Focus: Architecture, interfaces, patterns (not implementation details)

### Implementation Tasks

|Metric|Deep Read|Skim Read|Total Files|
|-|-|-|-|
|Standard|5-8|10-15|20-23|
|Complex|8-12|15-25|35 max|

Focus: Files to modify + direct dependencies only

### Refactor Tasks

|Metric|Deep Read|Skim Read|Total Files|
|-|-|-|-|
|Standard|3-5|8-12|15-17|
|Complex|5-8|12-20|25 max|

Focus: Refactor target + immediate callers

---

## Token Estimates

|Content Type|Tokens/Line|Typical File|
|-|-|-|
|Code (dense)|4-6|200-600 tokens|
|Code (sparse)|2-3|100-300 tokens|
|Markdown|3-4|150-400 tokens|
|JSON/Config|2-3|50-200 tokens|

### Budget Allocation

|Task Phase|Budget Share|
|-|-|
|Context loading|30-40%|
|Working memory|40-50%|
|Output generation|20-30%|

---

## Read Strategies

### Deep Read

```md
Use when:
- File will be modified
- Understanding logic flow
- Debugging specific behavior

Method: Full file content
Tool: read_file
```

### Skim Read

```md
Use when:
- Finding patterns
- Understanding structure
- Identifying dependencies

Method: Symbol overview, grep patterns
Tool: grep_search, semantic_search
```

### Skip Read

```md
Use when:
- File outside scope
- Already analyzed in prior phase
- Test files (unless testing task)

Method: Don't read
Tool: None
```

---

## Overflow Detection

### Warning Signs

|Signal|Action|
|-|-|
|Response truncating|Stop, spawn sub-agent|
|Forgetting early context|Checkpoint, restart focused|
|Repetitive patterns|Context saturated|
|Missing obvious info|Overflow confirmed|

### Recovery

1. Stop current approach
2. Checkpoint progress
3. Spawn focused sub-agent
4. Resume with fresh context

---

## Tool Selection Guide

|Need|Tool|Context Cost|
|-|-|-|
|Full file|`read_file`|High|
|Pattern search|`grep_search`|Low|
|Concept search|`semantic_search`|Medium|
|Structure only|`list_dir`|Very Low|
|Symbol overview|IDE features|Low|

### Cost-Effective Patterns

```
1. list_dir → understand structure
2. grep_search → find patterns
3. read_file (targeted) → deep on needed files only
```

---

## Summary

```
Analysis: 10-15 deep, 25-50 skim
Design: 5-10 deep, 15-25 skim
Implement: 5-8 deep, 10-15 skim
Refactor: 3-5 deep, 8-12 skim

Overflow? → Sub-agent.
```
