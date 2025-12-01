# Quality Gates

Quality gates are mandatory checkpoints between phases. They ensure work meets standards before progressing.

## Gate Structure

Each gate has:
1. **Entry Criteria** - What must exist to evaluate
2. **Checks** - What is verified
3. **Exit Criteria** - What passes the gate
4. **Failure Actions** - What happens on failure

---

## Gate 1: Interpretation Complete

### Entry Criteria
- Original request documented
- Request file exists in scratch directory

### Checks
- [ ] Request is understood (not just copied)
- [ ] Ambiguities are identified and listed
- [ ] Scope boundaries are defined
- [ ] Success criteria are measurable
- [ ] Out-of-scope items are explicit

### Exit Criteria
ALL checks pass, OR ambiguities are flagged for user clarification.

### Failure Actions
- Return to user with specific clarifying questions
- Do NOT proceed with assumptions on critical ambiguities

---

## Gate 2: Analysis Complete

### Entry Criteria
- Analysis documents exist per domain
- Handoff summary is complete

### Checks
- [ ] All relevant code areas identified
- [ ] Dependencies mapped
- [ ] Existing patterns documented
- [ ] Edge cases identified
- [ ] Data models understood
- [ ] No obvious gaps in coverage

### Exit Criteria
Analysis covers all areas needed for design with sufficient depth.

### Failure Actions
- Spawn additional analysis sub-agent for gaps
- Document gaps in handoff if intentionally deferred

---

## Gate 3: Design Complete

### Entry Criteria
- Architecture document exists
- Data flow documented
- Implementation approach defined

### Checks

#### Technical Review
- [ ] Proposed changes are feasible
- [ ] No conflicts with existing architecture
- [ ] Performance implications considered
- [ ] Error handling addressed
- [ ] Security implications reviewed

#### Functional Review  
- [ ] Design meets requirements
- [ ] User-facing behavior is correct
- [ ] Edge cases are handled
- [ ] Backward compatibility maintained (if required)

#### Prompt Alignment Review
- [ ] Design matches original request intent
- [ ] All requested features are addressed
- [ ] No scope creep beyond request
- [ ] Assumptions are valid

### Exit Criteria
All review categories pass with no blocking issues.

### Failure Actions
- Document issues in review notes
- Return to design phase with specific feedback
- Iterate until all reviews pass

---

## Gate 4: Implementation Plan Approved

### Entry Criteria
- Detailed implementation plan exists
- Files to modify are listed
- Change descriptions are specific

### Checks
- [ ] Plan matches approved design
- [ ] Changes are atomic and reversible
- [ ] Test strategy is defined
- [ ] No missing steps

### Exit Criteria
Plan is complete and aligned with design.

### Failure Actions
- Refine plan with more detail
- Break into smaller sub-tasks if too complex

---

## Gate 5: Implementation Complete

### Entry Criteria
- All planned changes are made
- Code compiles/parses successfully

### Checks
- [ ] All files in plan were modified
- [ ] Changes match plan descriptions
- [ ] No unplanned changes introduced
- [ ] Code style matches project conventions
- [ ] No obvious bugs or typos

### Exit Criteria
Implementation matches plan without deviations.

### Failure Actions
- Document deviations with rationale
- Update design docs if design changed
- Get approval for changes if significant

---

## Gate 6: Implementation Review Complete

### Entry Criteria
- Implementation is complete
- Review checklist exists

### Checks

#### Correctness
- [ ] Behavior matches requirements
- [ ] Edge cases are handled
- [ ] Error paths are covered

#### Quality
- [ ] Code is readable
- [ ] No duplicated logic
- [ ] Appropriate abstractions used

#### Integration
- [ ] Works with existing code
- [ ] No regressions in related features
- [ ] Tests pass (if applicable)

### Exit Criteria
All checks pass with no blocking issues.

### Failure Actions
- Create fix list
- Return to implementation for corrections
- Re-review after fixes

---

## Gate Enforcement

### Mandatory Gates
All gates are mandatory for complex tasks. For simple tasks (1-2 file changes), gates 1, 4, and 6 may be combined.

### Gate Documentation
Each gate passage must be documented:

```markdown
## Gate Passage: <Gate Name>

**Date:** <timestamp>
**Reviewer:** <agent/sub-agent ID>

### Checks Passed
- [x] Check 1
- [x] Check 2

### Notes
<Any observations or caveats>

### Decision: PASS / CONDITIONAL PASS / FAIL
<Rationale>
```

### Conditional Pass
A gate may conditionally pass if:
- Minor issues exist that don't block progress
- Issues are documented in a follow-up list
- Issues will be addressed in a specific later phase

### Gate Appeals
If a gate blocks incorrectly:
1. Document the specific check that fails
2. Provide evidence for why it should pass
3. Escalate to orchestrator for override decision
