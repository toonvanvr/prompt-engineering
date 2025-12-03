# Tool Stakes Classification

Risk-based tool call handling. Inherited by all agents.

---

## Core Principle

> Higher stakes → Higher oversight. Low stakes → Proceed freely.

---

## Stakes Levels

|Stakes|Description|Example Operations|
|-|-|-|
|LOW|Read-only, public, reversible|Read files, search, list directories|
|MEDIUM|Read private, templated output, logged|Access config, generate from template|
|HIGH|Write access, external comms, irreversible|Modify files, send messages, delete|

---

## Stakes → Action Mapping

|Stakes|Action Required|Blocking?|
|-|-|-|
|LOW|Proceed|No|
|MEDIUM|Log to scratch + optional review|No|
|HIGH|Require explicit approval|Yes|

---

## Tool Classification

### LOW Stakes (Proceed Freely)

- `read_file` — reading any file
- `list_dir` — directory listing
- `grep_search` — pattern search
- `semantic_search` — concept search
- `file_search` — find files

### MEDIUM Stakes (Log + Optional Review)

- `read_file` (sensitive paths) — config, secrets patterns
- Template generation — structured output
- Analysis output — recommendations

### HIGH Stakes (Require Approval)

- `edit_file` / `create_file` — any file modification
- `delete_file` — file removal
- `run_command` — terminal execution
- External API calls — network operations
- Multi-file changes — >3 files in single action

---

## Approval Protocol

### For HIGH Stakes Operations

Before proceeding:

```md
## Approval Request: {operation}

### Operation
{what will be done}

### Files Affected
|File|Action|
|-|-|
|{path}|CREATE/MODIFY/DELETE|

### Risk Assessment
- Stakes: HIGH
- Reversible: {YES/NO}
- Impact: {description}

### Response Required
- [ ] APPROVE: Proceed with operation
- [ ] DENY: {reason} — revise approach

⚠️ Cannot proceed without explicit response.
```

### Approval Sources

|Source|Mechanism|Priority|
|-|-|-|
|User in chat|Explicit message|1 (highest)|
|`.human/instructions/approve.md`|File-based|2|
|Pre-approved in dispatch|Scope declaration|3|

---

## Mode Integration

|Mode|Stakes Override|
|-|-|
|EXPLORE|HIGH stakes still require approval|
|EXPLOIT|All stakes enforced strictly|

---

## Agent-Specific Defaults

### Orchestrator

- Analysis: LOW stakes (read-only)
- Sub-agent dispatch: MEDIUM stakes (logged)
- Implementation delegation: HIGH stakes (approval at design gate)

### Implementer

- Read design: LOW stakes
- File modification: HIGH stakes (pre-approved via design approval)
- Test execution: MEDIUM stakes

### Compiler

- Read source: LOW stakes
- Write compiled: HIGH stakes (pre-approved via invocation)

---

## Self-Analysis Hook

Log stakes-related issues:

```md
## Stakes Violation: {CATEGORY}

Timestamp: {ISO8601}
Operation: {what}
Expected Stakes: {level}
Actual Handling: {what happened}
Impact: {result}
```

Categories: `BYPASS`, `MISCLASSIFICATION`, `APPROVAL_SKIP`

---

## Summary

```
LOW → Proceed
MEDIUM → Log, optional review
HIGH → Block until approved

Classification by operation type.
Approval via chat, file, or pre-scope.
```
