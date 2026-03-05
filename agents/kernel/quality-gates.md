# Quality Gates

Phase transition requirements. No-skip enforcement.

---

## Core Principle

> Phase N complete ≠ start Phase N+1. Gate must pass.

## Standard Gates

|Gate|Checks|Pass Condition|
|-|-|-|
|Analysis|Scope IN/OUT documented, patterns identified, dependencies mapped, risks listed|All checks documented with evidence|
|Design|Covers requirements, addresses patterns, feasibility confirmed|Design document complete + covers scope|
|Implementation|Matches design, tests pass, no regressions, style consistent|All tests pass + style clean|
|Review|Blockers resolved, docs updated, `_handoff.md` exists, feedback populated|No blockers + handoff exists|
|Startup|`.ai/library/` scanned, `.ai/feedback/` reviewed|Library scan logged|

## Phase-Gate Matrix

|Phase|Gate|Evidence|Next|
|-|-|-|-|
|Analysis|Analysis complete|`analysis.md`|Design|
|Design|Design approved|`design.md` + approval|Implementation|
|Implementation|Tests pass|Test log|Review|
|Review|No blockers|`review.md`|Complete|

## No-Skip Enforcement

**FORBIDDEN:** "Gate is probably passing", partial verification, assumed success, soft pass, asking "should I proceed?" (use `{scratchSessionDir}/communication/ai_status.md` instead), any permission question before transition.

**REQUIRED:** Explicit verification per check, evidence documented, PASS/FAIL before proceed. FAIL → fix → re-verify.

## Self-Approval Fast Path

|Gate|Self-Approve IF|Require Human IF|
|-|-|-|
|Analysis→Design|Analysis complete|Never|
|Design→Implementation|Spec exists + ≤2 domains|>2 domains AND public API change|
|Implementation→Review|Tests pass|Tests fail after 3 attempts|

Protocol: Gate passes → self-approve + log + proceed. Gate fails → fix + retry (3 max). 3 failures → escalate. User prompt = implicit approval. Human checks via `{scratchSessionDir}/communication/ai_status.md`.

## High-Stakes Gates

|Gate|Trigger|Rationale|
|-|-|-|
|Design → Implementation|Always|Irreversible work|
|Multi-domain changes|>2 domains|Cross-cutting impact|
|Public interface changes|API/schema|Breaking change risk|

**Low-Risk Override:** Self-approve if ALL: ≤2 files, single domain, non-breaking, test coverage exists.

**Approval Sources (priority):** User chat → `{scratchSessionDir}/communication/ai_status.md` `ACTION: approve` → pre-approval in dispatch.

## Deliverable Gate

Dispatches MUST list deliverables as checkboxes. Unchecked deliverable = gate failure. No implicit deliverables.

## Gate Evidence Types

|Evidence|Use Case|
|-|-|
|File exists|Artifact created|
|Content matches|Structure correct|
|Command output|Tests/tools (`npm test` exit 0)|
|SA handoff|`Status: COMPLETE` + `Confidence: HIGH` → gate passes|
|Lightweight check|`git diff --stat`, `wc -l`|

## Post-Compilation Integrity Gate

|Check|Verification|
|-|-|
|Path preservation|All paths with `/` in source retained in compiled|
|Kernel ref completeness|All kernel reference entries in source present|
|Glossary conformance|No glossary-defined path reduced to bare form|

**FAIL blocks deployment.**

---

## Error Recovery (from escalation protocol)

### STOP-READ-DIAGNOSE-FIX-VERIFY Cycle

Error occurs → 1. STOP current action → 2. READ error completely → 3. DIAGNOSE root cause → 4. FIX targeted correction → 5. VERIFY resolution.

### 3-Attempt Progression

|Attempt|Approach|Mindset|
|-|-|-|
|1|Direct fix from error message|Error is as stated|
|2|Alternative strategy|Initial diagnosis was wrong|
|3|Full diagnostic / spawn diagnostic SA|Something fundamental is wrong|

### After 3 Attempts → Escalate

Document: original error, 3 attempts + results, diagnosis, blockers, specific ask, resume instructions.

|Escalation Type|Trigger|Resolution|
|-|-|-|
|Technical|3 failed attempts|User intervention|
|Scope|Out-of-scope changes needed|User approval|
|Information|Missing critical info|User provides context|
|Permission|Access denied|User grants access|
|Complexity|Beyond single-agent capacity|Spawn specialized SA|

Pre-escalation: all 3 attempts documented, each used different approach, error fully captured, root cause hypothesis formed, partial progress saved, resume path defined.

---

## Action-Based Checkpoints (Context Management)

LLMs cannot count tokens. Measure ACTIONS instead.

### Soft Checkpoint (self-assessment)

Trigger after: 10 deep file reads, 30 tool calls, or 200 lines of output. Ask "Can I complete now?" YES → proceed. NO + specific gap → ≤5 targeted reads. NO + broad gap → delegate to SA.

### Hard Checkpoint (mandatory)

Trigger after: 25 deep reads, 50 tool calls, or output exceeding target by 2×. MUST synthesize, delegate, or checkpoint state to files.

### Overflow Signals

|Signal|Action|
|-|-|
|Response truncating|Checkpoint to file, spawn SA|
|Forgetting early context|Summarize working memory to file|
|Repetitive re-reading|Delegate to fresh SA|
|>100 files touched|Spawn SA for partitioning|
