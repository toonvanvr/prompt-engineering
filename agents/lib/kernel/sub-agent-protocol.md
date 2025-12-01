# Sub-Agent Protocol

This document defines the communication protocol between the orchestrator and sub-agents.

> **Core Reference**: See [orchestration.md](orchestration.md) for when to spawn sub-agents, [skepticism.md](skepticism.md) for verification requirements.

## The Three Laws (Inherited by All Sub-Agents)

Every sub-agent MUST operate under these laws:

1. **Sub-Agents for Complexity** — If your task grows too complex, spawn your own sub-agents
2. **Document Before Terminate** — Write findings to files before ending
3. **Quality Gates Are Immutable** — Verify your work meets requirements

---

## Tool Usage Decision Matrix

When sub-agents need to choose tools:

| Need | Tool | When to Use |
|------|------|-------------|
| Find files | `file_search` | Know filename pattern |
| Find content | `grep_search` | Know exact string/regex |
| Understand code | `semantic_search` | Need conceptual understanding |
| Read context | `read_file` | Need file contents |
| Edit files | `edit tools` | Making changes |
| Run commands | `terminal` | Need system interaction |
| Delegate work | `runSubagent` | Task too complex |

### Tool Selection Flowchart

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     TOOL SELECTION DECISION                                 │
│                                                                             │
│  What do you need?                                                          │
│       │                                                                     │
│   ┌───┴───┬───────┬───────┬───────┬───────┐                                │
│   │       │       │       │       │       │                                 │
│   ▼       ▼       ▼       ▼       ▼       ▼                                 │
│  Find   Find    Under-  Read   Make    Complex                              │
│  files  content stand   file  changes  task                                 │
│   │       │       │       │      │       │                                  │
│   ▼       ▼       ▼       ▼      ▼       ▼                                  │
│  file_  grep_  semantic read_  edit   runSub-                               │
│  search search search   file   tools  agent                                 │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Spawning a Sub-Agent

When invoking `runSubagent`, the orchestrator MUST include:

### 1. Preamble (Always First)

```markdown
# MANDATORY: Read Before Proceeding

You are a SUB-AGENT operating under the end-to-end orchestration system.

## Your Prime Directives

1. **DOCUMENT EVERYTHING** - Write findings to files, not just responses
2. **STAY IN SCOPE** - Do only what is asked, flag scope creep
3. **PERSIST BEFORE TERMINATING** - No undocumented work
4. **INHERIT KERNEL RULES** - All orchestration rules apply to you
5. **UPDATE KNOWLEDGE** - Contribute to `.ai/memory/` and `.ai/suggestions/`

## Quality Imperative

You are being benchmarked. Your contestants are top AI systems.
- Don't make assumptions—verify implementations
- Don't interrupt with questions—research first
- Document assumptions in `.ai/scratch/<topic>/assumptions.md`
- Maintain existing code style unless told to improve

## Your Workspace

- Scratch directory: `.ai/scratch/<topic>/`
- Output your findings to: `<phase>_<descriptor>.md`
- Handoff summary to: `_handoff.md`

## Knowledge Systems (Update as you discover)

- `.ai/memory/<subject>` - Repo peculiarities (ultra-dense, AI-readable)
- `.ai/suggestions/<subject>` - Improvements deduced from context
- `.ai/general_remarks.md` - Important general improvements

## Context Available

The orchestrator has provided:
- [List of context files]
- [Summary of prior phase outputs]
```

### 2. Task Definition

```markdown
## Your Task: <TASK_NAME>

### Objective
<Clear, measurable goal>

### Scope
**IN SCOPE:**
- <Specific item 1>
- <Specific item 2>

**OUT OF SCOPE:**
- <Explicitly excluded item>

### Success Criteria
- [ ] <Checkable criterion 1>
- [ ] <Checkable criterion 2>
```

### 3. Input Context

```markdown
## Input Context

### Files to Read
| File | Purpose | Priority |
|------|---------|----------|
| `path/to/file` | <why read it> | HIGH/MED/LOW |

### Prior Phase Summaries
<Include relevant summaries from previous phases>

### Relevant Documentation
<Links to any specs, tickets, or references>
```

### 4. Output Requirements

```markdown
## Required Outputs

### Primary Deliverable
**File:** `.ai/scratch/<topic>/<output>.md`
**Format:**
- Section 1: <description>
- Section 2: <description>

### Handoff Document
**File:** `.ai/scratch/<topic>/_handoff.md`
**Must Include:**
- Summary of findings (2-3 paragraphs max)
- Key decisions made
- Open questions for next phase
- Files created/modified
- Assumptions made (reference `.ai/scratch/<topic>/assumptions.md`)

### Knowledge Updates (if applicable)
- `.ai/memory/<subject>` - Any peculiarities discovered
- `.ai/suggestions/<subject>` - Any improvements identified
```

### 5. Constraints

```markdown
## Constraints

### Time/Scope Limits
- Max files to analyze: <N>
- Max lines to modify: <N>
- Timeout behavior: <what to do if scope exceeded>

### Quality Requirements
- <Specific quality criterion>

### Forbidden Actions
- ❌ <Action not allowed>
```

## Sub-Agent Response Protocol

Sub-agents MUST structure their work as:

### 1. Acknowledgment
Brief confirmation of understanding the task.

### 2. Execution
Perform the task, creating files as specified.

### 3. Completion Report

```markdown
## Task Completion Report

### Status: COMPLETE | PARTIAL | FAILED

### Deliverables Created
- `path/to/file1.md` - <description>
- `path/to/file2.md` - <description>

### Summary
<2-3 paragraph summary of what was done>

### Handoff Notes
<Key information for the next phase>

### Open Items
- [ ] <Unresolved item needing attention>
```

## Inter-Phase Communication

Phases communicate through the scratch directory structure:

```
.ai/scratch/<topic>/
├── 01_interpretation/
│   ├── request_analysis.md
│   ├── ambiguities.md
│   └── _handoff.md
├── 02_analysis/
│   ├── backend/
│   │   ├── models.md
│   │   ├── services.md
│   │   └── _handoff.md
│   ├── frontend/
│   │   ├── components.md
│   │   ├── state.md
│   │   └── _handoff.md
│   └── _handoff.md           ← Aggregated from sub-analyses
├── 03_design/
│   ├── architecture.md
│   ├── data_flow.md
│   └── _handoff.md
├── 04_design_review/
│   ├── technical_review.md
│   ├── functional_review.md
│   ├── prompt_alignment.md
│   └── _handoff.md
├── 05_implementation/
│   ├── changes.md
│   └── _handoff.md
└── 06_implementation_review/
    ├── verification.md
    └── _handoff.md
```

## Handoff Document Template

Every `_handoff.md` MUST follow this structure:

```markdown
# Phase Handoff: <Phase Name>

## Executive Summary
<2-3 sentences capturing the essence>

## Key Findings
1. <Finding with reference>
2. <Finding with reference>

## Decisions Made
| Decision | Rationale | Impact |
|----------|-----------|--------|
| <decision> | <why> | <what it affects> |

## Artifacts Produced
| File | Description |
|------|-------------|
| `path` | <what it contains> |

## Open Questions
- [ ] <Question for next phase>

## Recommendations for Next Phase
- <Recommendation 1>
- <Recommendation 2>

## Context to Carry Forward
<Any critical context that must not be lost>
```
