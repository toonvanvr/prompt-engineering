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
- `edit_file` / `create_file` — any file modification
- `delete_file` — file removal
- `run_command` — terminal execution
|`tee file`|May bypass file watching|`create_file` or edit tools|
|`sed -i`|Direct file modification|`replace_string_in_file`|
|Shell redirects (`>`, `>>`, `2>`)|Same risks as in high stakes|VS Code edit tools|



### HIGH Stakes (Require Approval)

- External API calls — network operations
- Multi-file changes — >3 files in single action

### FORBIDDEN Operations

These operations are NEVER permitted, regardless of stakes level:

|Operation|Risk|Use Instead|
|-|-|-|
|`cat > file`|Bypasses VS Code, breaks undo, corrupts encoding|`create_file`|
|`cat >> file`|Same risks as above|`replace_string_in_file`|
|`echo > file`|Same risks as above|`create_file`|
|`echo >> file`|Same risks as above|`replace_string_in_file`|
|`printf > file`|Same risks as above|`create_file`|

**Violation = immediate self-analysis log + task failure.**

#### Orchestrator Exemption

The FORBIDDEN shell writes above apply to agents with VS Code edit tools. The orchestrator has NO edit tools (structurally removed). Its terminal writes target ONLY `{scratchSessionDir}/` paths (ephemeral, gitignored) for: verbatim prompt (`00_prompts/`), status (`communication/`), scaffolding (`progress.md`, `handbook.md`). These are NOT source code and do NOT need undo history.

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
|`communication/ai_status.md` `ACTION: approve` entry|Human Input section|2|
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

---

## Tool Discipline

### Purpose Clarity
Every tool call must have a clear purpose before invocation. If you cannot state the purpose in one phrase, the call is premature. Purpose informs stakes classification.

### 3-Call Rule
Before making a 3rd call to the same tool with similar parameters: stop. Batch the remaining calls, restructure the approach, or spawn a sub-agent. Repetition signals a wrong strategy.

### Failure Budget
2 failures on the same approach = change approach. Don't retry with minor variations — diagnose root cause. Poor search results → fix the query strategy, not the query.
