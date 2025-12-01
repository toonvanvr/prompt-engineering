# Consistency Patterns for Reliable LLM Output

## What is Consistency?

**Consistency** = Same input → Same (or equivalent) output across runs

Measured by:
- **Format consistency**: Output structure matches specification
- **Behavioral consistency**: Actions taken match expected patterns
- **Content consistency**: Information quality/accuracy stable
- **Tone consistency**: Voice/persona maintained throughout

---

## Structural Patterns That Anchor Behavior

### Pattern 1: Identity Matrix (4-Dimensional Anchoring)

Anchoring a persona across 4 dimensions creates stability.

```markdown
## Identity

**Role**: [What you are]
**Mindset**: [How you think]
**Style**: [How you communicate]
**Superpower**: [Your unique strength]
```

**Why it works:**
- Single role declaration can drift
- 4 dimensions create constraint intersection
- Each dimension reinforces the others
- Harder for model to "break character" on all 4

**Example:**
```markdown
Role: Senior Security Engineer
Mindset: Assume all input is hostile
Style: Technical, cite CVEs, show mitigation code
Superpower: Threat modeling from first principles
```

**Consistency Effect:** HIGH - Persona stable across extended interactions

---

### Pattern 2: Three Laws (Memorable Constraints)

Human memory research: 3-5 items stick. LLMs trained on human text inherit this.

```markdown
## Three Laws of [Domain]

1. **[Law One]** — [Brief explanation]
2. **[Law Two]** — [Brief explanation]
3. **[Law Three]** — [Brief explanation]
```

**Why it works:**
- 3 items = memorable pattern in training data
- "Laws" semantic = non-negotiable in training data
- Numbering creates priority/sequence
- Can reference "Law 2" in later context

**Example (from existing agents):**
```markdown
## Three Laws of Orchestration

1. **Sub-Agents for Complexity** — >5 files = spawn sub-agent
2. **Document Before Terminate** — No work without files
3. **Quality Gates Are Immutable** — Never skip, never rush
```

**Consistency Effect:** HIGH - Laws referenced and followed even in complex tasks

---

### Pattern 3: ALWAYS/NEVER Lists (Binary Constraints)

Binary rules are easier to follow than nuanced guidelines.

```markdown
### ALWAYS
1. [Action that must happen every time]
2. [Action that must happen every time]
...

### NEVER
1. [Action that must never happen]
2. [Action that must never happen]
...
```

**Why it works:**
- No ambiguity: binary is easier than spectrum
- Format emphasizes importance (ALL CAPS)
- Lists are easy to check against
- "Never" is stronger than "avoid" or "shouldn't"

**Optimal count:** 5-7 items per list. More = dilution. Fewer = gaps.

**Consistency Effect:** HIGH for listed behaviors

---

### Pattern 4: Explicit Output Format

Specifying exact format eliminates format variance.

```markdown
## Required Output Format

```json
{
  "analysis": {
    "summary": "<2-3 sentences>",
    "findings": ["<finding 1>", "<finding 2>"],
    "confidence": "high|medium|low"
  },
  "recommendations": ["<rec 1>", "<rec 2>"]
}
```
```

**Why it works:**
- JSON/structured formats have clear delimiters
- Example shows exact expectations
- Reduces "how should I format this?" decisions
- Can be validated programmatically

**Consistency Effect:** VERY HIGH for format; moderate for content

---

### Pattern 5: Phase/Gate Structure

Sequential phases with explicit gates prevent drift.

```
┌────────────┐    ┌────────────┐    ┌────────────┐
│   Phase 1  │ → │   Gate 1   │ → │   Phase 2  │ → ...
│  (Action)  │    │  (Check)   │    │  (Action)  │
└────────────┘    └────────────┘    └────────────┘
```

**Structure:**
```markdown
## Phase 1: Analysis
- Task: Identify patterns
- Gate: Patterns documented in patterns.md

## Phase 2: Design  
- Task: Create solution design
- Gate: Design addresses all patterns
- Pre-requisite: Phase 1 gate passed
```

**Why it works:**
- Forces completion before progression
- Gates are checkpoints that verify state
- Prevents "rushing ahead" behavior
- Each phase is bounded scope

**Consistency Effect:** HIGH - Prevents scope creep and incomplete work

---

### Pattern 6: Decision Trees

Explicit if/then logic removes ambiguity.

```markdown
## Decision Protocol

```
IF file_count > 5:
    → Spawn sub-agent
ELIF crosses_domain_boundary:
    → Spawn sub-agent
ELIF estimated_tokens > context_window * 0.5:
    → Spawn sub-agent
ELSE:
    → Handle inline
```
```

**Why it works:**
- No judgment calls needed
- Each branch is deterministic
- Can trace decision post-hoc
- Matches programming patterns in training data

**Consistency Effect:** VERY HIGH for decision points

---

## Red Flags That Cause Drift

### 🚩 Vague Scope

**Bad:**
```markdown
Analyze the authentication system and improve it.
```

**Problem:** "Improve" is unbounded. Model may go anywhere.

**Better:**
```markdown
Analyze auth system. Document:
1. Current auth flow (sequence diagram)
2. Token handling (lifecycle, storage)
3. Security gaps (OWASP Top 10 check)

Do NOT modify code.
```

### 🚩 Conflicting Instructions

**Bad:**
```markdown
Be concise. Provide thorough explanations with examples.
```

**Problem:** Concise ≠ thorough. Model oscillates or picks one.

**Better:**
```markdown
Format: Concise bullets with one example each
Max: 5 bullets per section
```

### 🚩 Hedging Language in Instructions

**Bad:**
```markdown
You might want to consider checking the logs, 
and it could be helpful to look at the config.
```

**Problem:** "Might", "could be" signal optional → model may skip.

**Better:**
```markdown
1. Check logs for error patterns
2. Verify config matches schema
```

### 🚩 Missing Success Criteria

**Bad:**
```markdown
Fix the bug in the payment system.
```

**Problem:** How does model know when it's done?

**Better:**
```markdown
Fix payment calculation bug.

Success Criteria:
- [ ] Payments calculate correct amount (test: order_total_test.py)
- [ ] Edge cases handled (zero, negative, max values)
- [ ] No regression in checkout flow
```

### 🚩 Open-Ended Time Bounds

**Bad:**
```markdown
Keep working on this until it's good enough.
```

**Problem:** "Good enough" is undefined. May continue forever or stop too early.

**Better:**
```markdown
Time box: 3 attempts max
Escalate if not resolved after attempt 3
```

---

## Consistency Metrics

### Metric 1: Format Compliance Rate

```
Compliance = (Outputs matching format) / (Total outputs) × 100%
```

**Target:** >95% for structured formats

**How to improve:** Add format examples, use JSON schemas

### Metric 2: Behavioral Adherence

```
Adherence = (Rules followed) / (Rules applicable) × 100%
```

**Target:** >90% for ALWAYS rules, 100% for NEVER rules

**How to improve:** Reduce rule count, increase emphasis, add consequences

### Metric 3: Persona Stability

Qualitative measure: Does output "sound like" the defined persona?

**How to measure:** Check for:
- Terminology consistency (using defined terms)
- Tone consistency (matches style definition)
- Decision consistency (matches mindset)

**How to improve:** 4-dimensional identity matrix, reinforcement throughout prompt

### Metric 4: Scope Containment

```
Containment = (In-scope actions) / (Total actions) × 100%
```

**Target:** 100%

**How to improve:** Explicit IN/OUT scope lists, gate checks

---

## Consistency Techniques by Task Type

| Task Type | Primary Technique | Secondary |
|-----------|-------------------|-----------|
| Code Generation | Format specification + Examples | NEVER list for anti-patterns |
| Analysis | Phase structure + Gates | Identity matrix for depth |
| Debugging | Decision tree | 3-attempt escalation |
| Creative Writing | Persona anchoring | ALWAYS for style markers |
| Refactoring | Scope boundary | NEVER for forbidden changes |

---

## The Consistency Stack

For maximum consistency, layer multiple patterns:

```
┌─────────────────────────────────────────────┐
│           Layer 4: Output Format            │  ← What to produce
├─────────────────────────────────────────────┤
│           Layer 3: Phase/Gate               │  ← How to sequence
├─────────────────────────────────────────────┤
│           Layer 2: ALWAYS/NEVER             │  ← Behavioral bounds
├─────────────────────────────────────────────┤
│           Layer 1: Identity Matrix          │  ← Who you are
└─────────────────────────────────────────────┘
```

**Each layer reinforces the others:**
- Identity defines who makes decisions
- ALWAYS/NEVER bounds the decision space
- Phase/Gate sequences the decisions
- Output Format captures the results

---

## Template: Maximum Consistency Prompt

```markdown
# [Task Name]

## Identity
Role: [specific role]
Mindset: [thinking approach]
Style: [communication pattern]
Superpower: [unique strength]

## Three Laws
1. **[Law]** — [explanation]
2. **[Law]** — [explanation]
3. **[Law]** — [explanation]

## ALWAYS
1. [behavior]
2. [behavior]
3. [behavior]

## NEVER
1. [behavior]
2. [behavior]
3. [behavior]

## Scope
IN: [list]
OUT: [list]

## Phases
1. [Phase] → Gate: [check]
2. [Phase] → Gate: [check]

## Output Format
[exact format specification with example]

## Success Criteria
- [ ] [Checkable criterion]
- [ ] [Checkable criterion]
```

---

## Key Takeaways

1. **Multi-layer anchoring** beats single-point anchoring
2. **Binary constraints** (ALWAYS/NEVER) are more reliable than nuanced guidelines
3. **Explicit formats** eliminate format variance entirely
4. **Gates prevent drift** by forcing verification
5. **Vague scope is the #1 consistency killer**
6. **Hedging language in prompts causes hedging behavior in outputs**

---

## Next: Creativity Patterns

See [creativity_patterns.md](creativity_patterns.md) for when and how to enable exploration.
