# Design Phase Handoff: v2 Agent Architecture

## Executive Summary

Designed complete v2 agent architecture applying language optimization research. Key innovations: mandatory sub-agent enforcement for implementation, explicit mode switching protocol, self-analysis mechanism, and prompt compilation system. Architecture enables 50-70% token reduction while maintaining behavioral consistency.

---

## Artifacts Produced

| File                         | Description                                            | Lines |
| ---------------------------- | ------------------------------------------------------ | ----- |
| `folder_structure.md`        | v2 directory layout, file purposes, migration strategy | 160   |
| `agent_template_spec.md`     | 5-layer consistency template for all agents            | 354   |
| `orchestrator_v2_spec.md`    | Orchestrator with mandatory sub-agent enforcement      | 329   |
| `compilation_agent_spec.md`  | Prompt compiler input/output/pipeline spec             | 352   |
| `self_analysis_protocol.md`  | Cross-session failure learning mechanism               | 320   |
| `mode_switching_protocol.md` | Explore/Exploit transition rules                       | 332   |

**Note:** Spec files exceed 300-line target. These are implementation guides for humans—the **compiled agents** produced from them should be <200 lines. Specs contain examples, rationale, and edge cases needed for correct implementation.

---

## Key Design Decisions

### Decision 1: Mandatory Sub-Agent for Implementation

| Aspect      | Choice                                  | Rationale                           |
| ----------- | --------------------------------------- | ----------------------------------- |
| Enforcement | Non-bypassable gate before any impl     | Root cause of context overflow      |
| Threshold   | >1 file → sub-agent                     | Conservative to prevent scope creep |
| Override    | None without explicit justification doc | Forces deliberate decision          |

### Decision 2: Source/Compiled Separation

| Aspect        | Choice                                 | Rationale                                      |
| ------------- | -------------------------------------- | ---------------------------------------------- |
| Structure     | `/source/` (human) → `/compiled/` (AI) | Enables compression without losing readability |
| Reversibility | One-way; edit source, recompile        | Source of truth is human-readable              |
| Metadata      | Track compression metrics              | Validate compression effectiveness             |

### Decision 3: 5-Layer Consistency Stack

| Layer              | Purpose                 | From Research       |
| ------------------ | ----------------------- | ------------------- |
| 1. Identity Matrix | 4D persona anchoring    | Prevents drift      |
| 2. Three Laws      | Memorable constraints   | 3-5 items stick     |
| 3. ALWAYS/NEVER    | Binary bounds           | No ambiguity        |
| 4. Phase/Gate      | Sequential verification | Prevents rushing    |
| 5. Output Format   | Structure enforcement   | Eliminates variance |

### Decision 4: Explicit Mode Protocol

| Mode    | Use Case         | Key Difference     |
| ------- | ---------------- | ------------------ |
| EXPLORE | Analysis, Design | Creativity enabled |
| EXPLOIT | Implementation   | Zero deviation     |

Transition is EXPLICIT in dispatch, not inferred.

### Decision 5: Self-Analysis Integration

| Aspect      | Choice               | Rationale                     |
| ----------- | -------------------- | ----------------------------- |
| Storage     | `.ai/self-analysis/` | Persistent across sessions    |
| Format      | Structured entries   | Machine-parseable             |
| Aggregation | Pattern detection    | Learn from recurring failures |
| Reading     | At session start     | Apply past learnings          |

---

## Architecture Overview

```
USER REQUEST
    ↓
┌──────────────────────────────────────────────────────────────┐
│ ORCHESTRATOR (compiled/orchestrator.agent.md)                │
│                                                              │
│ Mode: Coordinates phases, enforces gates                     │
│                                                              │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ INTERPRETATION (inline, EXPLORE mode)                    │ │
│ └──────────────────────────────────────────────────────────┘ │
│                          ↓                                   │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ ANALYSIS (sub-agent, EXPLORE mode)                       │ │
│ │ → compiled/analyst.agent.md                              │ │
│ └──────────────────────────────────────────────────────────┘ │
│                          ↓                                   │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ DESIGN (sub-agent, EXPLORE mode)                         │ │
│ │ → compiled/designer.agent.md                             │ │
│ └──────────────────────────────────────────────────────────┘ │
│                          ↓                                   │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ DESIGN REVIEW (sub-agent, MIXED mode)                    │ │
│ │ → compiled/reviewer.agent.md                             │ │
│ └──────────────────────────────────────────────────────────┘ │
│                          ↓                                   │
│ ╔══════════════════════════════════════════════════════════╗ │
│ ║ IMPLEMENTATION ENFORCEMENT GATE (BLOCKING)               ║ │
│ ║ • Design approved?                                       ║ │
│ ║ • Files > 5? → MUST spawn                               ║ │
│ ║ • Domain crossing? → MUST split                          ║ │
│ ╚══════════════════════════════════════════════════════════╝ │
│                          ↓                                   │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ IMPLEMENTATION (sub-agent(s), EXPLOIT mode)              │ │
│ │ → compiled/implementer.agent.md                          │ │
│ │ → ALWAYS via sub-agent                                   │ │
│ └──────────────────────────────────────────────────────────┘ │
│                          ↓                                   │
│ ┌──────────────────────────────────────────────────────────┐ │
│ │ IMPLEMENTATION REVIEW (sub-agent, EXPLOIT mode)          │ │
│ │ → compiled/reviewer.agent.md                             │ │
│ └──────────────────────────────────────────────────────────┘ │
│                          ↓                                   │
│ COMPLETE + SESSION SELF-ANALYSIS                             │
└──────────────────────────────────────────────────────────────┘
```

---

## Implementation Checklist

### Phase 1: Foundation

- [ ] Create `/agents/v2/` directory structure
- [ ] Create kernel rules (compressed format)
  - [ ] `three-laws.md`
  - [ ] `consistency-stack.md`
  - [ ] `mode-protocol.md`
  - [ ] `sub-agent-mandate.md`
  - [ ] `context-budget.md`
  - [ ] `quality-gates.md`
  - [ ] `self-analysis.md`
  - [ ] `escalation.md`
- [ ] Create mode specifications
  - [ ] `modes/explore.md`
  - [ ] `modes/exploit.md`

### Phase 2: Agent Sources

- [ ] Create source agents (human-readable)
  - [ ] `source/orchestrator.src.md`
  - [ ] `source/analyst.src.md`
  - [ ] `source/designer.src.md`
  - [ ] `source/implementer.src.md`
  - [ ] `source/reviewer.src.md`
  - [ ] `source/compiler.src.md`

### Phase 3: Compilation

- [ ] Implement compiler agent manually first
- [ ] Compile all source agents → `/compiled/`
- [ ] Verify token reduction (target: 50-70%)
- [ ] Validate semantic equivalence

### Phase 4: Templates

- [ ] Create dispatch templates (compressed)
  - [ ] `templates/dispatch-base.md`
  - [ ] `templates/dispatch-analysis.md`
  - [ ] `templates/dispatch-design.md`
  - [ ] `templates/dispatch-implement.md`
  - [ ] `templates/dispatch-review.md`
  - [ ] `templates/handoff.md`

### Phase 5: Self-Analysis

- [ ] Create `.ai/self-analysis/` structure
- [ ] Create initial pattern templates
- [ ] Add analysis hooks to all agents

### Phase 6: Verification

- [ ] Test orchestrator with sample task
- [ ] Verify sub-agent enforcement works
- [ ] Verify mode switching works
- [ ] Measure actual token usage
- [ ] Compare output quality vs v1

### Phase 7: Migration

- [ ] Move current agents to `/agents/legacy/`
- [ ] Update symlink: `.github/agents` → `/agents/v2/compiled`
- [ ] Monitor for issues
- [ ] Deprecate legacy after 2 weeks stable

---

## Success Criteria Verification

| Criterion                      | Status | Evidence                                  |
| ------------------------------ | ------ | ----------------------------------------- |
| v2 structure designed          | ✅     | `folder_structure.md`                     |
| Agent template has 5 layers    | ✅     | `agent_template_spec.md`                  |
| Sub-agent enforcement explicit | ✅     | `orchestrator_v2_spec.md` - blocking gate |
| Compilation agent has I/O spec | ✅     | `compilation_agent_spec.md`               |
| Self-analysis actionable       | ✅     | `self_analysis_protocol.md`               |
| Mode switching has triggers    | ✅     | `mode_switching_protocol.md`              |
| Handoff provides checklist     | ✅     | This document                             |

---

## Open Questions for Implementation

1. **Compiler Bootstrap**

   - How to compile the compiler? Manual first iteration, then self-compile?

2. **Training Data Integration**

   - Should `lib/training/data/` examples be compressed or kept verbose?

3. **Metrics Collection**

   - How to automate consistency measurement during execution?

4. **Rollback Procedure**

   - If v2 causes issues, exact steps to revert to v1?

5. **Incremental Migration**
   - Can we run v2 orchestrator with v1 sub-agents during transition?

---

## Context for Implementer

### Key Files to Read

| File                                    | Purpose                    |
| --------------------------------------- | -------------------------- |
| `02_research/_handoff.md`               | Research findings to apply |
| `02_research/compression_techniques.md` | Compression rules          |
| `02_research/consistency_patterns.md`   | 5-layer stack details      |
| `02_research/creativity_patterns.md`    | Mode behavior details      |
| Current `agents/end-to-end.agent.md`    | Baseline to improve        |

### Compression Guidelines

Apply these to all v2 content:

| Safe                | Moderate                  | Never                |
| ------------------- | ------------------------- | -------------------- |
| Remove filler       | Abbreviate repeated terms | Remove examples      |
| Remove articles     | Remove pronouns           | Remove emphasis      |
| Use symbols (→ = !) | Merge bullets             | Compress code blocks |
| Prose → markdown    | Shorten headers           | Change thresholds    |

### Validation Approach

For each compiled agent:

1. Compare token count: source vs compiled
2. Target: 50-70% reduction
3. Run test task
4. Compare output quality
5. Check all 5 layers present

---

## Confidence Assessment

```yaml
confidence: high
rationale: Design directly applies validated research findings
concerns:
  - Compiler effectiveness needs empirical validation
  - Mode switching edge cases may emerge in practice
  - Self-analysis overhead unknown
recommendations:
  - Implement compiler first, manually validate
  - Test mode transitions with edge cases
  - Monitor self-analysis file sizes
```

---

## Recommended Implementation Order

1. **First:** Kernel rules (foundation for everything)
2. **Second:** Orchestrator source → compiled (core agent)
3. **Third:** Implementer source → compiled (most constrained)
4. **Fourth:** Compiler agent (enables automation)
5. **Fifth:** Remaining agents
6. **Sixth:** Templates
7. **Last:** Self-analysis hooks

Start with orchestrator and implementer because they address the core problem (implementation context overflow).
