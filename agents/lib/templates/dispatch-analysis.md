# Analysis Sub-Agent Dispatch Template

Use this template when spawning an analysis sub-agent.

---

## Sub-Agent Dispatch: Analysis - {DOMAIN}

### KERNEL INHERITANCE (MANDATORY)
```
You are a SUB-AGENT. Before proceeding, acknowledge these prime directives:
1. DOCUMENT EVERYTHING to files in .ai/scratch/{topic}/
2. STAY IN SCOPE - only analyze what's requested
3. PERSIST BEFORE TERMINATING - create _handoff.md before finishing
4. All rules in .github/agents/lib/kernel/ apply to you
```

### Objective
Analyze {DOMAIN} to understand:
- Current implementation patterns
- Data models and their relationships
- Dependencies and integrations
- Edge cases and gotchas

### Scope

**IN SCOPE:**
- {List specific files/directories}
- {List specific concerns}

**OUT OF SCOPE:**
- {Explicitly excluded areas}
- Implementation changes
- Design decisions

### Files to Investigate

| Priority | Path Pattern | Purpose |
|----------|--------------|---------|
| HIGH | `{path}` | {reason} |
| MEDIUM | `{path}` | {reason} |
| LOW | `{path}` | {reason} |

### Analysis Questions

Answer these questions in your analysis:

1. **Structure**: How is this domain organized?
2. **Models**: What data structures are involved?
3. **Flow**: How does data move through this area?
4. **Patterns**: What conventions are used?
5. **Gotchas**: What implicit behaviors or gotchas exist?
6. **Tests**: What test coverage exists?

### Required Outputs

**Primary:** `.ai/scratch/{topic}/analysis_{domain}.md`
```markdown
# Analysis: {Domain}

## Overview
<Summary of what was analyzed>

## Structure
<How code is organized>

## Key Components
### <Component 1>
- Location: <path>
- Purpose: <what it does>
- Key methods: <list>

## Data Models
### <Model 1>
- Attributes: <list with types>
- Relationships: <associations>
- Validations: <rules>

## Data Flow
<How data moves through the system>

## Patterns & Conventions
- <Pattern 1>
- <Pattern 2>

## Gotchas & Edge Cases
- <Gotcha 1>: <explanation>
- <Gotcha 2>: <explanation>

## Dependencies
- <Dependency>: <how it's used>

## Test Coverage
<Summary of existing tests>

## Questions for Design Phase
- <Question 1>
- <Question 2>
```

**Handoff:** `.ai/scratch/{topic}/_handoff.md`
```markdown
# Analysis Handoff: {Domain}

## Executive Summary
<2-3 sentences>

## Key Findings
1. <Finding>
2. <Finding>

## Critical Context for Design
<What the designer MUST know>

## Artifacts Created
- `analysis_{domain}.md`

## Open Questions
- <Question>
```

### Constraints
- Max files to read deeply: 15
- Max files to skim: 40
- Document findings as you go
- Create intermediate notes if hitting context limits

### Success Criteria
- [ ] All IN SCOPE areas covered
- [ ] Data models fully documented
- [ ] Patterns identified and explained
- [ ] Gotchas listed with context
- [ ] Handoff document complete
