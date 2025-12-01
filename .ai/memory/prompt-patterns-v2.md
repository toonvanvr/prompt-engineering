# Prompt Engineering Patterns - v2 Additions

December 2025 language optimization findings.

## Language Register Patterns

| Register | Consistency | Use For |
|----------|-------------|---------|
| Technical Documentation | ⬛⬛⬛⬛⬛ | Implementation, Analysis |
| Specification (RFC) | ⬛⬛⬛⬛⬛ | Requirements, Constraints |
| Instructional | ⬛⬛⬛⬛⬜ | Procedures |
| Conversational Tech | ⬛⬛⬛⬜⬜ | Exploration |
| Academic/Student | ⬜⬜⬜⬜⬜ | NEVER USE |

## Compression Rules

### Safe (Always Apply)
- Remove articles: the, a, an
- Remove filler: I would like, please, make sure
- Symbols: → = & ! 
- Prose → markdown structure
- Target: 50-70% token reduction

### Never Compress
- Examples (anchor interpretation)
- Emphasis (MUST, NEVER, ALWAYS)
- Code blocks
- Thresholds/numbers

## Mode Switching

| Mode | When | Constraints |
|------|------|-------------|
| EXPLORE | Analysis, Design | Guardrails only |
| EXPLOIT | Implementation | Full 5-layer stack |

Transition: Explicit in dispatch, not inferred.

## 5-Layer Consistency Stack

```
Layer 5: Output Format
Layer 4: Phase/Gate       
Layer 3: ALWAYS/NEVER     
Layer 2: Three Laws       
Layer 1: Identity Matrix  
```

Each layer reinforces others. Use all 5 for complex agents.

## Implementation Enforcement

**CRITICAL:** Orchestrator NEVER implements inline.

```
>1 file → MUST spawn sub-agent
>1 domain → MUST spawn per domain
NO EXCEPTIONS
```

This prevents context overflow in implementation phases.

## Self-Analysis Categories

| Code | Meaning |
|------|---------|
| DRIFT | Role deviation |
| OVERFLOW | Context exceeded |
| GATE_SKIP | Verification skipped |
| SCOPE_CREEP | Scope exceeded |
| LAW_VIOLATION | Three Laws breached |
