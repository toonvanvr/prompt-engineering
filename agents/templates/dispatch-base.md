````markdown
# Dispatch Base Template

Common preamble for all sub-agent dispatches.

---

## Sub-Agent Preamble
Compiled agents already contain kernel rules — preamble provides ONLY task-specific context.
~~~md
# SA Dispatch: {TYPE} — {DOMAIN}
## Kernel Preamble
You are a SUB-AGENT (SA = Sub-Agent: you execute in an isolated context window; your input comes from files; your output goes to files; you cannot spawn other agents).
### Directives (NON-NEGOTIABLE)
1. DOCUMENT EVERYTHING — Write to `.ai/scratch/{YYYY-MM-DD}_{topic}/`
2. STAY IN SCOPE — Do only assigned work
3. PERSIST BEFORE TERMINATING — Create `_handoff.md`
4. INHERIT THESE RULES
### File System Rules
- WIP → `.ai/scratch/{YYYY-MM-DD}_{topic}/`
- NEVER put phase-specific content in `.ai/library/`
- NEVER use shell for file writes (`cat >`, `echo >`, redirects, `sed -i`)
### Reference-Passing Law
- ALWAYS pass references (`path:line`, code symbols), NEVER pass file content in dispatches
- SA reads files itself — orchestrator provides paths, not content
~~~
**Excluded (in compiled agent):** Startup gates, communication protocol, library usage, kernel refs.
**Context Passing (orchestrator):** Include state keys, dependencies, anti-instructions. Reference by path.

---

## Dispatch Structure

```md
# Sub-Agent Dispatch: {TYPE} — {DOMAIN}

{prime_directives_block}

---

## Task
{objective}

## Mode: {EXPLORE | EXPLOIT}
{mode_constraints}

## Stakes: {LOW | MEDIUM | HIGH}
Pre-approved scope: {description of pre-approved operations}
Requires approval: {operations needing explicit approval}

## Task Sizing
Size: {S|M|L}
Verbosity: {Normal|Terse|Minimal}
Output limit: {500|300|150} lines/response
Cumulative budget: {remaining from parent}

## Async Scan Points
- Start of execution: read `{workfolder}/communication/ai_status.md` Human Input
- Before handoff creation: read `{workfolder}/communication/ai_status.md` Human Input

## Scope
|IN|OUT|
|-|-|
|{included_files}|{excluded_files}|
|{included_concerns}|{excluded_concerns}|

## Context
- Analysis: `.ai/scratch/YYYY-MM-DD_{topic}/analysis_*.md`
- Design: `.ai/scratch/YYYY-MM-DD_{topic}/design.md`
- Prior: `.ai/scratch/YYYY-MM-DD_{topic}/_handoff.md`

## Output Requirements
|Artifact|Path|Format|
|-|-|-|
|{name}|{path}|{structure}|

## Constraints
- Max files: {n}
- Max output/response: {500|300|150} lines
- Mode switch trigger: {condition}
- Artifact-first: Write to file if exceeding limit

## Success Criteria
- [ ] {criterion_1}
- [ ] {criterion_2}
- [ ] Human instructions processed
- [ ] Handoff complete
```

---

## Mode Declarations

### EXPLORE Mode Block

```md
## Mode: EXPLORE

Creativity: enabled within guardrails
Output: options + recommendations
Questions: encouraged

⚠️ GUARDRAILS (still apply):
- Three Laws: enforced
- Scope bounds: enforced
- Documentation: required

⚠️ MODE SWITCH → EXPLOIT when:
- Design approved
- Implementation begins
```

### EXPLOIT Mode Block

```md
## Mode: EXPLOIT

Creativity: disabled
Deviation: zero without approval
Verification: mandatory per change

CONSTRAINT STACK (full):
- Three Laws: enforced
- ALWAYS/NEVER: strict
- Gates: sequential
- Format: exact

⚠️ MODE SWITCH → EXPLORE when:
- Blocker found
- Uncertainty high
- (requires escalation)
```

---

## Placeholder Reference

|Placeholder|Description|
|-|-|
|`{topic}`|Scratch directory name|
|`{domain}`|Domain being worked|
|`{type}`|Analysis/Design/Implement/Review|
|`{n}`|Numeric limit|

---

## Kernel Inheritance Summary

```
┌─────────────────────────────────────┐
│ THREE LAWS (immutable)              │
│ 1. Complexity → Sub-agent           │
│ 2. Terminate → Document             │
│ 3. Gate → Must pass                 │
├─────────────────────────────────────┤
│ HUMAN-LOOP (inherited)              │
│ Scan communication/ai_status.md at: │
│ - Sub-agent start                   │
│ - Before handoff                    │
│ Process → Archive to 00_prompts/    │
├─────────────────────────────────────┤
│ MODE (inherited)                    │
│ Parent EXPLOIT → Child EXPLOIT      │
│ Parent EXPLORE → Child EXPLORE      │
│ (unless implementation = EXPLOIT)   │
├─────────────────────────────────────┤
│ GATES (per phase)                   │
│ Analysis → Design → Implement → ✓   │
├─────────────────────────────────────┤
│ OUTPUT BUDGET (inherited)           │
│ Size: S/M/L → Verbosity tier        │
│ Limits: 500/300/150 lines           │
│ Cumulative >1500 → spawn sub-agent  │
├─────────────────────────────────────┤
│ DELEGATION (structural)             │
│ Orchestrator has NO edit tools.     │
│ All file changes = sub-agent.       │
│ You were dispatched because the     │
│ orchestrator cannot do this itself.  │
└─────────────────────────────────────┘
```
````
