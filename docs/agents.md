# Agents Guide

Detailed guide to the agent system and dispatch patterns.

## Agent Hierarchy

```mermaid
flowchart TB
    O[Orchestrator] -->|@researcher| R[Researcher]
    O -->|@designer| D[Designer]
    O -->|@implementer| I[Implementer]
    
    R -->|findings.md| O
    D -->|design docs| O
    I -->|_handoff.md| O
```

## Agent Definitions

### Orchestrator

**Mode**: EXPLORE (coordination)  
**Purpose**: Parse tasks, spawn sub-agents, verify completion  
**Key Rule**: Never implements directly

The Orchestrator:
1. Interprets user request
2. Creates scratch folder structure
3. Dispatches to Researcher for analysis
4. Dispatches to Designer for specs
5. Dispatches to Implementer for execution
6. Verifies and creates final handoff

**Tools**:
- All read tools
- `runSubagent` (for @agent dispatch)
- `create_file` (for scratch docs only)

**NEVER**:
- Edit existing files
- Write code
- Skip design review

---

### Researcher

**Mode**: EXPLORE (permanent)  
**Purpose**: Codebase comprehension, dependency mapping, pattern finding  
**Key Rule**: Observe, don't modify

The Researcher:
1. Explores codebase structure
2. Maps dependencies between components
3. Identifies patterns and anti-patterns
4. Documents findings with evidence

**Tools**:
- `read_file`, `grep_search`, `semantic_search`
- `file_search`, `list_dir`
- `run_in_terminal` (read-only commands)

**NEVER**:
- Modify any file
- Run destructive commands
- Make recommendations (just document findings)

**Output**: `findings.md`, analysis documents

---

### Designer

**Mode**: EXPLORE (permanent)  
**Purpose**: Architecture specs, trade-off analysis, implementation plans  
**Key Rule**: Specify, don't implement

The Designer:
1. Reads research findings
2. Proposes architectural approaches
3. Documents trade-offs explicitly
4. Creates implementation-ready specs

**Tools**:
- All read tools
- `create_file` (for design docs)

**NEVER**:
- Write implementation code
- Make changes outside design docs
- Skip trade-off analysis

**Output**: Design documents in `03_design/`

---

### Implementer

**Mode**: EXPLOIT (permanent)  
**Purpose**: Execute design specs precisely  
**Key Rule**: Design is the contract

The Implementer:
1. Reads approved design
2. Implements exactly as specified
3. Verifies changes work
4. Documents any deviations

**Tools**:
- All read tools
- All edit tools
- `run_in_terminal` (for verification)

**NEVER**:
- Add features not in design
- "Improve" beyond spec
- Skip verification

**Output**: Working code, `_handoff.md`

---

### Compiler

**Mode**: EXPLOIT (permanent)  
**Purpose**: Compress prompts for token efficiency  
**Target**: 50-70% reduction without semantic drift

**Tools**:
- Read tools
- File edit tools

---

## Dispatch Pattern

When Orchestrator spawns a sub-agent:

```markdown
# Dispatch to @researcher

## Mode: EXPLORE
## Workfolder: .ai/scratch/2026-01-19_feature/

### Objective
[One sentence goal]

### Context Files
- {workfolder}/01_interpretation/interpretation.md

### Output
- {workfolder}/02_analysis/findings.md

### Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2

### Constraints
- Max files to deep read: 12
- Timeout behavior: partial handoff
```

## Context Isolation

Sub-agents receive:
- Dispatch prompt only
- Referenced files (they read themselves)
- Kernel rules (inherited)

Sub-agents do NOT receive:
- Parent's full conversation history
- Other sub-agent outputs (unless in files)
- Accumulated context from hours of work

This isolation prevents token overflow in long-running orchestration.

## Inter-Agent Communication

All via files:

| File | Purpose | Who Writes | Who Reads |
|------|---------|------------|-----------|
| `STATE.md` | Current phase/status | All | Orchestrator |
| `queue.md` | Task backlog | Orchestrator | All |
| `findings.md` | Research discoveries | Researcher | Designer |
| `_handoff.md` | Completion summary | Terminating agent | Parent |

## Mode Switching

| Agent | Can Switch? | Notes |
|-------|-------------|-------|
| Orchestrator | YES | EXPLORE ↔ MIXED |
| Researcher | NO | Always EXPLORE |
| Designer | NO | Always EXPLORE |
| Implementer | NO | Always EXPLOIT |
| Compiler | NO | Always EXPLOIT |

EXPLORE → EXPLOIT happens at Implementation Gate.
