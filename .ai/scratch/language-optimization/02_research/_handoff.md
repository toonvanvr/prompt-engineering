# Research Phase Handoff: Language Optimization for LLM Consistency

## Executive Summary

This research phase investigated language patterns that affect LLM output consistency vs creativity. The core hypothesis was validated: **documentation-style language produces consistent outputs**, while **informal/hedging language produces unreliable outputs**. Four comprehensive research documents were produced covering taxonomy, compression, consistency, and creativity patterns.

---

## Key Findings

### 1. Language Register Effects (Validated)

| Register                  | Consistency | Creativity | Recommended For           |
| ------------------------- | ----------- | ---------- | ------------------------- |
| Technical Documentation   | ⬛⬛⬛⬛⬛  | ⬜⬜⬜⬜⬜ | Implementation, Analysis  |
| Specification (RFC-style) | ⬛⬛⬛⬛⬛  | ⬜⬜⬜⬜⬜ | Requirements, Constraints |
| Instructional (Expert)    | ⬛⬛⬛⬛⬜  | ⬜⬜⬜⬜⬜ | Procedures, Steps         |
| Conversational Technical  | ⬛⬛⬛⬜⬜  | ⬛⬛⬛⬜⬜ | Exploration, Discussion   |
| Tutorial                  | ⬛⬛⬜⬜⬜  | ⬛⬛⬛⬜⬜ | Avoid in agent prompts    |
| Academic Essay            | ⬛⬜⬜⬜⬜  | ⬛⬛⬜⬜⬜ | AVOID                     |
| Student Assignment        | ⬜⬜⬜⬜⬜  | ⬜⬜⬜⬜⬜ | NEVER USE                 |
| Casual Chat               | ⬜⬜⬜⬜⬜  | ⬛⬛⬜⬜⬜ | NEVER USE                 |

**Recommendation:** Agent prompts should use Technical Documentation register as default.

### 2. Compression Achievable (57-72% Token Reduction)

| Category               | Safe Reduction | Risk            |
| ---------------------- | -------------- | --------------- |
| Filler phrases         | 100%           | None            |
| Articles (the, a, an)  | 80%+           | None            |
| Verbose constructions  | 60%+           | Low             |
| Connectors → Structure | 50%+           | Low             |
| Examples               | 0-20%          | HIGH if removed |
| Emphasis markers       | 0%             | CRITICAL        |

**Recommendation:** Compress aggressively EXCEPT examples and emphasis.

### 3. Consistency Requires Multi-Layer Anchoring

Single-point anchoring (e.g., just a role) drifts. Stable behavior requires:

```
Identity Matrix (4 dimensions)
    + Three Laws (memorable constraints)
        + ALWAYS/NEVER (binary rules)
            + Phase/Gate (sequence control)
                + Output Format (structure enforcement)
```

**Recommendation:** Use the full Consistency Stack for complex agents.

### 4. Creativity is Sequential, Not Alternative

**Anti-pattern:** Trying to be consistent AND creative simultaneously.
**Pattern:** Explore phase → Converge → Exploit phase (strict consistency).

**Recommendation:** Design agents with explicit mode switching.

---

## Artifacts Produced

| File                        | Content                                   | Lines |
| --------------------------- | ----------------------------------------- | ----- |
| `language_taxonomy.md`      | Register classification, persona triggers | ~280  |
| `compression_techniques.md` | Token reduction with risk levels          | ~260  |
| `consistency_patterns.md`   | Structural patterns for reliable output   | ~280  |
| `creativity_patterns.md`    | Controlled exploration techniques         | ~270  |

---

## Design Phase Recommendations

### Recommendation 1: Register Standardization

Establish a register guide for agent prompts:

- **REQUIRED:** Technical Documentation register for all agent prompts
- **FORBIDDEN:** Hedging language (might, could, maybe, perhaps)
- **FORBIDDEN:** Apologetic constructions (sorry, please, I would like)

### Recommendation 2: Compression Pipeline

Create a "prompt compilation" step that:

1. Removes filler phrases
2. Removes articles where safe
3. Converts prose → structured markdown
4. Preserves examples and emphasis
5. Reports token savings

### Recommendation 3: Consistency Stack Template

Codify the 5-layer stack as a template:

```markdown
# Agent: [Name]

## Layer 1: Identity

Role: | Mindset: | Style: | Superpower:

## Layer 2: Laws

1. | 2. | 3.

## Layer 3: Constraints

ALWAYS: | NEVER:

## Layer 4: Phases

Phase → Gate → Phase → Gate

## Layer 5: Output

[Exact format specification]
```

### Recommendation 4: Explore/Exploit Mode Protocol

Design agents with explicit mode switching:

```markdown
## Mode: EXPLORE

- Creativity enabled
- Guardrails only
- Generate options

⚠️ MODE SWITCH ⚠️

## Mode: IMPLEMENT

- Consistency required
- Full stack active
- Follow plan exactly
```

### Recommendation 5: Quality Metrics

Define measurable consistency metrics:

| Metric            | Target      | How to Measure              |
| ----------------- | ----------- | --------------------------- |
| Format Compliance | >95%        | Automated schema check      |
| Rule Adherence    | >90%        | Review against ALWAYS/NEVER |
| Scope Containment | 100%        | Check IN/OUT boundaries     |
| Persona Stability | Qualitative | Spot-check terminology/tone |

---

## Open Questions for Design Phase

1. **Compilation Agent Scope**

   - Should it only compress, or also restructure?
   - What's the human-readable ↔ AI-optimized tradeoff?
   - Is reversibility required?

2. **Mode Switching Implementation**

   - How do agents signal mode switches to sub-agents?
   - Should modes be in prompt or in orchestration layer?

3. **Metrics Infrastructure**

   - How to automate consistency measurement?
   - What's acceptable variance threshold?

4. **Training Data Integration**
   - Should `lib/training/data/` examples be compressed?
   - Or kept verbose as "source of truth"?

---

## Context to Carry Forward

### Existing Patterns That Work (Keep)

From `prompt-patterns.md`:

- ✅ Three Laws pattern — aligns with our findings
- ✅ Identity Matrix — matches 4-dimensional anchoring
- ✅ ALWAYS/NEVER lists — binary constraints validated
- ✅ Skepticism default — "verify, then trust"

### Existing Patterns to Evolve

From `end-to-end.agent.md`:

- ⚡ Currently uses some filler language — compress
- ⚡ Mode switching implied but not explicit — make explicit
- ⚡ Compression not applied — apply our findings

---

## Confidence Assessment

```yaml
confidence_level: high
concerns:
  - Compression effects not empirically tested (theoretical)
  - Metrics need validation against real agent runs
  - Creative mode may need more guardrails than documented
```

---

## Recommended Next Phase

**Design Phase** should:

1. Create template structure for optimized agents
2. Design the compilation agent specification
3. Define metrics collection approach
4. Produce v2 agent architecture that applies these findings

**Suggested design phase scope:**

- IN: Agent template design, compilation agent spec, metrics design
- OUT: Implementation, testing, deployment

---

## References

- `./language_taxonomy.md` — Full register classification
- `./compression_techniques.md` — Token reduction guide
- `./consistency_patterns.md` — Anchoring patterns
- `./creativity_patterns.md` — Exploration protocols
- `../../01_interpretation.md` — Original request analysis
- `../../../memory/prompt-patterns.md` — Existing patterns
- `../../../../agents/end-to-end.agent.md` — Current agent structure

CHARTS SHOULD NOT BE ASCII
