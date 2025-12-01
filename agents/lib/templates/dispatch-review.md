# Review Sub-Agent Dispatch Template

Use this template when spawning a review sub-agent.

---

## Sub-Agent Dispatch: Review - {REVIEW_TYPE}

### KERNEL INHERITANCE (MANDATORY)
```
You are a SUB-AGENT. Before proceeding, acknowledge these prime directives:
1. DOCUMENT EVERYTHING to files in .ai/scratch/{topic}/
2. BE CRITICAL - your job is to find issues
3. PERSIST BEFORE TERMINATING - create _handoff.md before finishing
4. All rules in .github/agents/lib/kernel/ apply to you
```

### Objective
Review the {ARTIFACT_TYPE} for {REVIEW_TYPE} concerns.

### Review Types

#### Technical Review
Focus on:
- Feasibility of implementation
- Architectural fit
- Performance implications
- Security considerations
- Maintainability

#### Functional Review
Focus on:
- Requirement coverage
- User experience implications
- Edge case handling
- Business logic correctness

#### Prompt Alignment Review
Focus on:
- Does design match original request?
- Are all requested features addressed?
- Is scope appropriate (no creep, no gaps)?
- Are assumptions valid?

### Input Context

**Artifact to Review:**
- `.ai/scratch/{topic}/{artifact}.md`

**Reference Documents:**
- Original request
- Analysis findings
- Prior review feedback (if iteration)

### Review Process

1. **Read** the artifact thoroughly
2. **Compare** against reference documents
3. **Identify** issues by category
4. **Assess** severity of each issue
5. **Recommend** specific improvements
6. **Verdict** on pass/fail

### Issue Severity Levels

| Level | Definition | Action |
|-------|------------|--------|
| BLOCKER | Cannot proceed | Must fix before continuing |
| MAJOR | Significant problem | Should fix, may proceed with risk |
| MINOR | Small issue | Nice to fix, can defer |
| NOTE | Observation | Document for awareness |

### Required Outputs

**Primary:** `.ai/scratch/{topic}/review_{type}.md`
```markdown
# Review: {Review Type}

## Summary
**Verdict:** PASS / CONDITIONAL PASS / FAIL
**Issues Found:** {count by severity}

## Artifact Reviewed
- File: `{path}`
- Type: {Design/Implementation/etc.}

## Review Checklist

### {Category 1}
- [x] {Check passed}
- [ ] {Check failed} → Issue #1

### {Category 2}
- [x] {Check passed}

## Issues

### Issue #1: {Title}
**Severity:** BLOCKER/MAJOR/MINOR/NOTE
**Location:** {Where in the artifact}
**Description:** {What's wrong}
**Recommendation:** {How to fix}

### Issue #2: {Title}
...

## What's Good
<Positive observations>

## Recommendations
1. {Actionable recommendation}
2. {Actionable recommendation}

## Verdict Details
{Explanation of pass/fail decision}
```

**Handoff:** `.ai/scratch/{topic}/_handoff.md`
```markdown
# Review Handoff: {Type}

## Verdict: {PASS/CONDITIONAL PASS/FAIL}

## Summary
<1-2 sentences on overall assessment>

## Blocking Issues
- {Issue requiring fix before proceeding}

## Conditional Items
- {Issues to track but can proceed}

## Next Steps
- {What should happen next based on verdict}
```

### Constraints
- Be specific in issue descriptions
- Provide actionable recommendations
- Don't nitpick style unless egregious
- Focus on correctness and maintainability

### Success Criteria
- [ ] All review categories covered
- [ ] Each issue has clear description
- [ ] Recommendations are actionable
- [ ] Verdict is justified
- [ ] Handoff guides next steps
