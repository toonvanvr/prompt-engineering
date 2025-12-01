# Design Sub-Agent Dispatch Template

Use this template when spawning a design sub-agent.

---

## Sub-Agent Dispatch: Design - {FEATURE}

### KERNEL INHERITANCE (MANDATORY)
```
You are a SUB-AGENT. Before proceeding, acknowledge these prime directives:
1. DOCUMENT EVERYTHING to files in .ai/scratch/{topic}/
2. STAY IN SCOPE - design only, no implementation
3. PERSIST BEFORE TERMINATING - create _handoff.md before finishing
4. All rules in .github/agents/lib/kernel/ apply to you
```

### Objective
Design the implementation approach for {FEATURE} based on the analysis findings.

### Input Context

**Analysis Documents:**
- `.ai/scratch/{topic}/analysis_*.md`
- `.ai/scratch/{topic}/_handoff.md` from analysis phase

**Requirements:**
- {Requirement 1}
- {Requirement 2}

### Scope

**IN SCOPE:**
- Architecture decisions
- Data model changes
- Interface definitions
- Error handling strategy
- Component interactions

**OUT OF SCOPE:**
- Actual code implementation
- Test implementation
- Deployment concerns

### Design Questions to Address

1. **What** needs to change?
2. **Where** do changes go? (which files)
3. **How** do components interact?
4. **Why** this approach over alternatives?

### Required Outputs

**Primary:** `.ai/scratch/{topic}/design.md`
```markdown
# Design: {Feature}

## Overview
<High-level description of the solution>

## Requirements Addressed
- [x] {Requirement 1}
- [x] {Requirement 2}

## Architecture

### Component Diagram
<ASCII diagram or description of components>

### Data Flow
<How data moves through the solution>

## Data Model Changes

### New Models
```ruby
class NewModel
  # attributes
end
```

### Modified Models
- `ExistingModel`: Add `new_attribute`

## Interface Definitions

### Public APIs
<New or modified endpoints/methods>

### Internal Interfaces
<How components communicate>

## Implementation Approach

### Phase 1: {Description}
Files affected:
- `path/to/file.rb` - {what changes}

### Phase 2: {Description}
Files affected:
- `path/to/file.rb` - {what changes}

## Error Handling
- {Error case 1}: {handling strategy}
- {Error case 2}: {handling strategy}

## Edge Cases
- {Edge case 1}: {handling}
- {Edge case 2}: {handling}

## Alternatives Considered

### Option A: {Name}
- Pros: {list}
- Cons: {list}
- Rejected because: {reason}

## Open Questions
- {Question needing input}

## Dependencies
- {External dependency or prerequisite}

## Risks
- {Risk 1}: {mitigation}
```

**Handoff:** `.ai/scratch/{topic}/_handoff.md`
```markdown
# Design Handoff: {Feature}

## Executive Summary
<2-3 sentences describing the design>

## Key Decisions
| Decision | Rationale |
|----------|-----------|
| {Decision} | {Why} |

## Files to Modify
| File | Change Type | Description |
|------|-------------|-------------|
| `path` | NEW/MODIFY | {what} |

## Implementation Order
1. {Step 1}
2. {Step 2}

## Artifacts Created
- `design.md`

## Review Checkpoints
- [ ] Technical feasibility
- [ ] Requirement coverage
- [ ] Edge case handling
```

### Constraints
- Design must be implementable incrementally
- Prefer minimal changes to existing code
- Consider backward compatibility
- Reference analysis findings, don't duplicate

### Success Criteria
- [ ] All requirements addressed
- [ ] Clear implementation path defined
- [ ] Edge cases handled
- [ ] Alternatives documented
- [ ] Ready for design review
