# Implementation Sub-Agent Dispatch Template

Use this template when spawning an implementation sub-agent.

---

## Sub-Agent Dispatch: Implementation - {COMPONENT}

### KERNEL INHERITANCE (MANDATORY)
```
You are a SUB-AGENT. Before proceeding, acknowledge these prime directives:
1. DOCUMENT EVERYTHING to files in .ai/scratch/{topic}/
2. FOLLOW THE DESIGN - no freelancing
3. PERSIST BEFORE TERMINATING - create _handoff.md before finishing
4. All rules in .github/agents/lib/kernel/ apply to you
```

### Objective
Implement {COMPONENT} according to the approved design.

### Input Context

**Design Document:**
- `.ai/scratch/{topic}/design.md`

**Relevant Analysis:**
- `.ai/scratch/{topic}/analysis_*.md`

**Review Feedback:**
- `.ai/scratch/{topic}/review_*.md`

### Implementation Scope

**Files to Create:**
| File | Purpose |
|------|---------|
| `{path}` | {description} |

**Files to Modify:**
| File | Changes |
|------|---------|
| `{path}` | {description of changes} |

### Implementation Guidelines

1. **Match Existing Style**
   - Follow project conventions
   - Use existing patterns
   - Maintain consistency

2. **Incremental Changes**
   - Make atomic commits
   - Each change should be reversible
   - Test after each logical unit

3. **Documentation**
   - Add comments for non-obvious code
   - Update relevant docs
   - Document API changes

4. **Error Handling**
   - Handle edge cases per design
   - Provide meaningful error messages
   - Log appropriately

### Required Outputs

**Code Changes:**
Apply changes to the specified files using edit tools.

**Change Log:** `.ai/scratch/{topic}/implementation_changes.md`
```markdown
# Implementation Changes: {Component}

## Overview
<Summary of what was implemented>

## Files Created
### `{path}`
- Purpose: {why this file}
- Key contents: {summary}

## Files Modified
### `{path}`
**Change:** {description}
**Lines:** {line range}
**Reason:** {why this change}

## Deviations from Design
### {Deviation}
- Original design: {what was planned}
- Actual implementation: {what was done}
- Reason: {why different}

## Test Considerations
- {What should be tested}
- {Edge cases to verify}

## Known Limitations
- {Limitation}: {explanation}
```

**Handoff:** `.ai/scratch/{topic}/_handoff.md`
```markdown
# Implementation Handoff: {Component}

## Summary
<What was implemented>

## Changes Made
| File | Change Type | Status |
|------|-------------|--------|
| `path` | NEW/MODIFY | DONE |

## Verification Needed
- [ ] {Check 1}
- [ ] {Check 2}

## Ready for Review
<What reviewer should focus on>
```

### Constraints
- Max lines changed per file: 250 (split if larger)
- Max files modified: 8 (spawn sub-agent if more)
- Must match design unless impossible
- Document any deviations immediately

### Forbidden Actions
- ❌ Adding features not in design
- ❌ Refactoring unrelated code
- ❌ Changing public interfaces without approval
- ❌ Skipping error handling

### Success Criteria
- [ ] All design components implemented
- [ ] Code compiles/parses successfully
- [ ] Follows project conventions
- [ ] Changes documented
- [ ] Ready for implementation review
