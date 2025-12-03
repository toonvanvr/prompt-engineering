# Integration Patterns

Reusable patterns for analyzing external repositories and adopting best practices.

---

## External Repo Analysis Framework

### Phase 1: Reconnaissance

1. **Identify repository focus**
   - Runtime vs prompt-time systems
   - Infrastructure vs behavioral control
   - SDK vs standalone patterns

2. **Map documentation structure**
   - Root-level guidance (AGENTS.md, CLAUDE.md, README)
   - Per-component documentation
   - Configuration patterns

3. **Extract pattern vocabulary**
   - Naming conventions (stakes, gates, modes)
   - Structural patterns (file organization)
   - Process patterns (workflows, approvals)

### Phase 2: Compatibility Assessment

|Question|If YES|If NO|
|-|-|-|
|Same domain focus?|Direct adoption possible|Adapt concepts only|
|Same tooling assumptions?|Copy patterns directly|Abstract the pattern|
|Same scale assumptions?|Use as-is|Simplify or expand|

### Phase 3: Pattern Extraction

For each candidate pattern:
1. Document the pattern in isolation
2. Identify dependencies
3. Assess integration complexity
4. Prioritize by value/effort ratio

---

## Decision Framework: Adopt vs Skip

### Adopt Immediately (P1)

Criteria:
- Zero or minimal code changes
- Immediate value with no risk
- Self-contained (no external dependencies)
- Enhances existing patterns

Examples:
- Annotation conventions (TODO priorities)
- Documentation templates (AGENTS.md, CLAUDE.md)
- Classification frameworks (risk levels)

### Adapt for System (P2)

Criteria:
- Requires modification to fit existing patterns
- Clear value but implementation complexity
- May require new files or structures

Examples:
- Approval workflows adapted to file-based system
- Gate enhancements with existing quality gates
- Cheat sheets tailored to specific workflows

### Future Consideration (P3)

Criteria:
- Out of current scope
- Requires infrastructure changes
- Runtime dependencies when system is prompt-time
- Database/persistence when system is file-based

Examples:
- Multi-channel routing (requires runtime)
- Daemon architecture (requires persistence)
- SDK integration (requires code dependencies)

---

## Additive-Only Integration Approach

### Core Principle

> All changes MUST be additive. No deletions, no breaking changes.

### Implementation Rules

1. **Append, don't replace**
   - Add new sections to existing files
   - Continue existing numbering sequences
   - Preserve all existing functionality

2. **Create alongside, don't modify**
   - New kernel files instead of rewriting existing
   - New templates instead of modifying core ones
   - New AI context files (AGENTS.md, CLAUDE.md) instead of embedding in code

3. **Extend, don't override**
   - Add items to ALWAYS/NEVER lists
   - Add gates to existing gate sequences
   - Add modes to existing mode systems

Before finalizing any integration:
- [ ] No files deleted
- [ ] No existing functionality removed
- [ ] No breaking changes to existing patterns
- [ ] All modifications are traceable additions
- [ ] Rollback is trivial (git revert)

---

## Integration Workflow

```
Phase 0: Pre-flight
├── Verify target directories exist
├── Document current state (counts, structure)
└── Identify exact insertion points

Phase 1-N: Execution
├── Create new files first
├── Modify existing files with exact anchors
├── Verify after each phase
└── Document changes in execution log

Phase N+1: Verification
├── All files exist
├── Content matches specification
├── No errors introduced
└── Cross-references resolve

Phase N+2: Compilation (if applicable)
├── Regenerate derived files
├── Verify compression/transformation
└── Check semantic equivalence
```

---

## Pattern Documentation Template

```markdown
# Pattern: [Name]

## Origin
Source: [Repository/File]
Context: [Why it exists in source]

## Pattern
[Description of the pattern]

## Adoption
Status: [Adopt/Adapt/Skip]
Rationale: [Why this decision]

## Implementation
[How to implement in target system]

## Dependencies
[What else is required]
```
