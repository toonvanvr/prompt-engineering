````markdown
# Escalation Template

Use this template after 3 failed attempts to resolve an issue.

---

## Sub-Agent Dispatch: Escalation Documentation

### KERNEL INHERITANCE (MANDATORY)
```
You are documenting an escalation after 3 failed attempts.
1. Document everything — this is the human's only context
2. Be specific — vague escalations waste time
3. Include all attempts — show what was tried
4. Propose hypothesis — help human diagnose
```

---

## Escalation Document Structure

Create file: `.ai/scratch/<topic>/escalation/<issue-name>.md`

```markdown
# 🚨 ESCALATION: [Issue Title]

**Date**: [timestamp]
**Phase**: [current phase]
**Module/Task**: [specific location]
**Severity**: BLOCKER / MAJOR / MINOR

---

## The Problem

**What's happening**:
[1-2 sentences describing the issue]

**Expected behavior**:
[What should happen]

**Actual behavior**:
[What's actually happening]

**Error message** (if applicable):
\`\`\`
[Exact error text]
\`\`\`

---

## Context

**What we're trying to do**:
[Brief description of the goal]

**Where in the process**:
[Phase, step, prior completed work]

**Relevant files**:
- `path/to/file1` - [relevance]
- `path/to/file2` - [relevance]

**Prior phase findings**:
[Any relevant context from earlier phases]

---

## Attempts Made

### Attempt 1: [Strategy Name]
**Action taken**: [What was done]
**Result**: [What happened]
**Why it failed**: [Analysis of failure]

### Attempt 2: [Strategy Name]
**Action taken**: [What was done]
**Result**: [What happened]
**Why it failed**: [Analysis of failure]

### Attempt 3: [Strategy Name] (with sub-agent if applicable)
**Action taken**: [What was done]
**Sub-agent used**: [Yes/No, if yes what kind]
**Sub-agent findings**: [If applicable]
**Result**: [What happened]
**Why it failed**: [Analysis of failure]

---

## Diagnosis

**Root cause hypothesis**:
[Best guess at what's causing the issue]

**Confidence in hypothesis**: HIGH / MEDIUM / LOW

**Supporting evidence**:
- [Evidence 1]
- [Evidence 2]

**Alternative hypotheses**:
1. [Alternative 1]
2. [Alternative 2]

---

## What I Need

**Specific question or decision**:
[Not "what should I do?" but "should I do X or Y?" or "is my understanding of Z correct?"]

**Options I see** (if applicable):
1. [Option A] - Pros: [...], Cons: [...]
2. [Option B] - Pros: [...], Cons: [...]

**Recommendation** (if I have one):
[My recommendation with rationale]

---

## Impact of Delay

**Blocking**: [What can't proceed]
**Workaround available**: Yes / No - [if yes, describe]
**Time sensitivity**: [Any deadlines]

---

@human: Please advise on [specific question].
```

---

## Quick Escalation Checklist

Before submitting escalation, verify:

- [ ] All 3 attempts documented with specific actions and results
- [ ] Error message included exactly (if applicable)
- [ ] Root cause hypothesis provided
- [ ] Specific question asked (not open-ended)
- [ ] Relevant files listed
- [ ] Context sufficient for human to understand without conversation history

---

## Escalation Anti-Patterns

❌ **Don't**: "I'm stuck, please help"
✅ **Do**: "After 3 attempts at X, I believe the issue is Y. Should I try Z or W?"

❌ **Don't**: Escalate without trying 3 different approaches
✅ **Do**: Document each attempt and why it failed

❌ **Don't**: Dump all context without structure
✅ **Do**: Follow the template, be organized

❌ **Don't**: Ask open-ended questions
✅ **Do**: Propose options and ask for decision

---

## Post-Escalation Protocol

After human responds:

1. **Document** the resolution in the escalation file
2. **Update** `.ai/memory/` if this reveals a pattern
3. **Resume** work with new information
4. **Update** STATE.md with progress

````
