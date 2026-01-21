````markdown
# Analysis Dispatch Template

Sub-agent dispatch for codebase/domain analysis.

---

````markdown
# Sub-Agent Dispatch: Analysis — {DOMAIN}

# MANDATORY: Sub-Agent Prime Directives

You are a SUB-AGENT. DOCUMENT → SCOPE → PERSIST → INHERIT.

---

## Task

Analyze {domain} to document patterns, models, dependencies & gotchas.

## Mode: EXPLORE (Mandatory for Analysis)

Analysis MUST run in EXPLORE mode:
- Document findings before recommendations
- Generate options, not single path
- Produce artifacts that feed design phase

Creativity: enabled within guardrails
Output: patterns + findings + questions
Questions: encouraged before assumptions

⚠️ GUARDRAILS:

- Three Laws: enforced
- Scope bounds: enforced
- Documentation: required

⚠️ MODE SWITCH: Only after analysis complete AND documented.

---

## Scope

|IN|OUT|
|-|-|
|{files_to_analyze}|{excluded_files}|
|{concerns}|Implementation changes|
||Design decisions|

## File Limits

|Priority|Path|Purpose|Limit|
|-|-|-|-|
|HIGH|{path}|{reason}|Deep read|
|MEDIUM|{path}|{reason}|Skim|
|LOW|{path}|{reason}|Reference only|

**Constraints:**

- Deep read: ≤15 files
- Skim: ≤40 files

---

## Findings Accumulation (MANDATORY)

All discoveries MUST be accumulated in `communication/findings.md`:

```md
# Accumulated Findings

## [YYYY-MM-DD HH:MM] {Category}
**Finding:** {description}
**Evidence:** `{path}:{line}` or {reference}
**Impact:** {HIGH|MEDIUM|LOW}
**Action:** {recommendation}
```

Update findings.md as discoveries occur—don't wait for handoff.
This file persists across sessions and feeds design phase.

---

## Analysis Questions

|Category|Question|
|-|-|
|Structure|How is {domain} organized?|
|Models|What data structures exist?|
|Flow|How does data move?|
|Patterns|What conventions are used?|
|Gotchas|What implicit behaviors exist?|
|Tests|What coverage exists?|

---

## Output Requirements

### Primary: `.ai/scratch/YYYY-MM-DD_{topic}/analysis_{domain}.md`

```md
# Analysis: {Domain}

## Overview
{2-3 sentences}

## Structure
{organization description}

## Key Components
|Component|Location|Purpose|Key Methods|
|-|-|-|-|
|{name}|{path}|{what}|{list}|

## Data Models
|Model|Attributes|Relations|Validations|
|-|-|-|-|
|{name}|{list}|{list}|{rules}|

## Data Flow
{diagram or description}

## Patterns & Conventions
- {pattern}: {usage}

## Gotchas & Edge Cases
- {gotcha}: {explanation}

## Dependencies (FULL MAPPING REQUIRED)

Map ALL dependencies—both upstream and downstream:

|Dependency|Direction|Usage|Consumers|
|-|-|-|-|
|{name}|upstream/downstream|{how used}|{list ALL downstream consumers}|

**Downstream Consumer Mapping:** For each component, identify ALL files/modules that depend on it. This prevents breaking changes during implementation.

## Test Coverage
{summary}

## Questions for Design
- {question}
```
````

### Handoff: `.ai/scratch/YYYY-MM-DD_{topic}/_handoff.md`

```md
# Analysis Handoff: {Domain}

## Summary
{2-3 sentences}

## Key Findings
1. {finding}
2. {finding}

## Critical Context for Design
{must-know items}

## Artifacts
- `analysis_{domain}.md`

## Open Questions
- {question}

## Gate: Analysis Complete
- [ ] Scope defined
- [ ] Patterns identified
- [ ] Dependencies mapped
- [ ] Gotchas documented
- Status: {PASS|FAIL}
```

---

## Success Criteria

- [ ] All IN scope areas covered
- [ ] Data models documented
- [ ] Patterns identified
- [ ] Gotchas listed
- [ ] Handoff complete
- [ ] Gate passed

```

```
````
