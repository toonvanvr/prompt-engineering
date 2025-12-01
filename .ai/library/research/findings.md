# Research Findings

Permanent discoveries from prompt engineering research.

---

## Language Register Taxonomy

**Core finding:** Documentation-style language activates expert semantic spaces.

| Register | Consistency | Use For |
|----------|-------------|---------|
| Technical Documentation | ⬛⬛⬛⬛⬛ | Implementation |
| Specification (RFC) | ⬛⬛⬛⬛⬛ | Requirements |
| Instructional | ⬛⬛⬛⬛⬜ | Procedures |
| Conversational Tech | ⬛⬛⬛⬜⬜ | Exploration |
| Academic/Student | ⬜⬜⬜⬜⬜ | **NEVER USE** |

**Why documentation works:**
1. Training correlation: Tech docs → expert patterns
2. High signal density
3. Predictable structure

**Anti-patterns:**
- Hedging language ("maybe", "might") → uncertainty propagates
- Student register → activates low-confidence patterns
- Passive voice → verbose, uncertain outputs

---

## Compression Effectiveness

| Element | Safe Compression | Target |
|---------|------------------|--------|
| Role definitions | 55% | 50-60% |
| Behavioral rules | 60% | 55-65% |
| Scope definitions | 55% | 50-60% |
| Examples | 10% | 0-20% |
| Emphasis markers | **0%** | 0% |

**Key insight:** Structure > prose. Markdown lists preserve meaning with fewer tokens.

---

## Pattern Impact Matrix

| Pattern | Impact | Effort | Priority |
|---------|--------|--------|----------|
| Three Laws | HIGH | LOW | 9/10 |
| Identity Matrix | HIGH | LOW | 9/10 |
| ALWAYS/NEVER | HIGH | LOW | 9/10 |
| 3-Attempt Escalation | HIGH | MEDIUM | 8/10 |
| Skepticism Framework | HIGH | MEDIUM | 8/10 |
| 1-1-1 Rule | MEDIUM | LOW | 7/10 |
| Resume Protocol | MEDIUM | LOW | 6/10 |

---

## Persona Activation

**Minimum viable:** Role + 1 strong constraint
```
You are [role]. Always/Never [constraint].
```

**Robust:** Full Identity Matrix (4 dimensions harder to drift)

**Expert triggers:**
- Domain terminology
- Assumed competence
- Imperative mood
- Structured format

---

## Sub-Agent Critical Finding

Sub-agent usage = primary scaling mechanism.

**Thresholds:**
- >5 files → sub-agent REQUIRED
- >2 domains → sub-agent per domain
- >100 lines change → sub-agent REQUIRED

**Without sub-agents:** Context overflow in long tasks.

---

## Mode Switching

| Mode | When | Creativity |
|------|------|------------|
| EXPLORE | Analysis, Design | Enabled |
| EXPLOIT | Implementation | Disabled |

**Transition:** Explicit in dispatch. Never inferred.

---

## 5-Layer Consistency Stack

```
Layer 5: Output Format
Layer 4: Phase/Gate
Layer 3: ALWAYS/NEVER
Layer 2: Three Laws
Layer 1: Identity Matrix
```

Each layer reinforces others. Complex agents need all 5.

---

*Research completed: 2025-12-01*
*Sources: External agent analysis, compression experiments*
