````markdown
# Dispatch Base Template

Common preamble for all sub-agent dispatches.

---

## Sub-Agent Prime Directives

```markdown
# MANDATORY: Sub-Agent Prime Directives

You are a SUB-AGENT. Acknowledge before proceeding:

1. **DOCUMENT** → Write to `.ai/scratch/{topic}/`
2. **SCOPE** → Touch only assigned files/domains
3. **PERSIST** → Create `_handoff.md` before terminating
4. **INHERIT** → Kernel rules apply: three-laws, gates, modes

## Kernel References

- `agents/v2/kernel/three-laws.md`
- `agents/v2/kernel/quality-gates.md`
- `agents/v2/kernel/mode-protocol.md`
```

---

## Dispatch Structure

```markdown
# Sub-Agent Dispatch: {TYPE} — {DOMAIN}

{prime_directives_block}

---

## Task

{objective}

## Mode: {EXPLORE | EXPLOIT}

{mode_constraints}

## Scope

| IN                  | OUT                 |
| ------------------- | ------------------- |
| {included_files}    | {excluded_files}    |
| {included_concerns} | {excluded_concerns} |

## Context

- Analysis: `.ai/scratch/{topic}/analysis_*.md`
- Design: `.ai/scratch/{topic}/design.md`
- Prior: `.ai/scratch/{topic}/_handoff.md`

## Output Requirements

| Artifact | Path   | Format      |
| -------- | ------ | ----------- |
| {name}   | {path} | {structure} |

## Constraints

- Max files: {n}
- Mode switch trigger: {condition}

## Success Criteria

- [ ] {criterion_1}
- [ ] {criterion_2}
- [ ] Handoff complete
```

---

## Mode Declarations

### EXPLORE Mode Block

```markdown
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

```markdown
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

| Placeholder | Description                      |
| ----------- | -------------------------------- |
| `{topic}`   | Scratch directory name           |
| `{domain}`  | Domain being worked              |
| `{type}`    | Analysis/Design/Implement/Review |
| `{n}`       | Numeric limit                    |

---

## Kernel Inheritance Summary

```
┌─────────────────────────────────────┐
│ THREE LAWS (immutable)              │
│ 1. Complexity → Sub-agent           │
│ 2. Terminate → Document             │
│ 3. Gate → Must pass                 │
├─────────────────────────────────────┤
│ MODE (inherited)                    │
│ Parent EXPLOIT → Child EXPLOIT      │
│ Parent EXPLORE → Child EXPLORE      │
│ (unless implementation = EXPLOIT)   │
├─────────────────────────────────────┤
│ GATES (per phase)                   │
│ Analysis → Design → Implement → ✓   │
└─────────────────────────────────────┘
```
````
