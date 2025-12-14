````markdown
# Dispatch Base Template

Common preamble for all sub-agent dispatches.

---

## Sub-Agent Prime Directives

```md
# MANDATORY: Sub-Agent Prime Directives

You are a SUB-AGENT. Acknowledge before proceeding:

1. **DOCUMENT** → Write to `.ai/scratch/YYYY-MM-DD_{topic}/`
2. **SCOPE** → Touch only assigned files/domains
3. **PERSIST** → Create `_handoff.md` before terminating
4. **INHERIT** → Kernel rules apply: three-laws, gates, modes
5. **HUMAN CHECK** → Check  at start and before handoff

## Human Override

Check `.human/instructions/` at: start, pre-handoff
Process any instructions found. Move to `.human/processed/` with timestamp.

## Kernel References
- `agents/kernel/three-laws.md`
- `agents/kernel/quality-gates.md`
- `agents/kernel/mode-protocol.md`
- `agents/kernel/human-loop.md`
- `agents/kernel/tool-stakes.md`
- `agents/kernel/todo-conventions.md`
```

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

## Human Checkpoints
- Start of execution
- Before handoff creation

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
│ Check `.human/instructions/` at:    │
│ - Sub-agent start                   │
│ - Before handoff                    │
│ Process → Move to processed/        │
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
└─────────────────────────────────────┘
```
````
