````markdown
# Skepticism Framework

Your work is WRONG until verified. This is not pessimism. This is professionalism.

> **Core Reference**: See [quality-gates.md](quality-gates.md) for verification procedures, [orchestration.md](orchestration.md) for error recovery.

## The Core Principle

```
┌─────────────────────────────────────────────────────────────────────────────┐
│           ASSUME YOUR WORK IS WRONG UNTIL VERIFIED                          │
│                                                                             │
│  The moment you think "this should work" without verification               │
│  is the moment you introduce bugs.                                          │
│                                                                             │
│  CONFIDENCE = VERIFIED, not ASSUMED                                         │
│                                                                             │
│  "Trust but verify" → WRONG                                                 │
│  "Verify, then trust" → RIGHT                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

## The Five Skepticism Practices

### 1. Verify Every Output

Sub-agent returns → Check handoff exists → Check format valid → Check content complete

Never proceed on assumption. Verification is faster than debugging.

### 2. Read Before Assuming

Before making assumptions about prior work:
- Read the actual handoff document
- Check the actual files mentioned
- Look at actual content, not summary
- Don't rely on memory or guesses

### 3. Question Your Understanding

When you think you understand something:
- Can I explain exactly how it works?
- Have I seen this verified in the artifacts?
- Am I assuming or do I know?
- Is my understanding current? (Check the source)

### 4. Test Your Hypotheses

Before implementing based on an assumption:
```markdown
HYPOTHESIS: [what I think is true]
TEST: [how I can verify it]
RESULT: [what I actually found]
CONCLUSION: [proceed or adjust approach]
```

### 5. Validate Boundaries

Check scope explicitly:
- What if sub-agent output is incomplete?
- What if prior phase missed something?
- What if assumptions are wrong?
- What if context changed?

---

## Common Orchestrator Failure Modes

### 1. Scope Creep Blindness

**The Failure:** Not noticing when scope expands beyond original request.

**Prevention:**
- Re-read interpretation document frequently
- Check each phase against original scope
- Flag any additions in assumptions.md

**Self-Check:**
```markdown
Before proceeding:
- [ ] Is this in the original scope?
- [ ] Did I document the expansion?
- [ ] Is the user aware?
```

### 2. Sub-Agent Trust

**The Failure:** Trusting sub-agent output without verification.

**Prevention:**
- Always check handoff exists and is complete
- Verify key findings, don't just accept
- Cross-check between sub-agents if parallel

**Self-Check:**
```markdown
After sub-agent returns:
- [ ] Handoff document exists?
- [ ] Key findings documented?
- [ ] Format matches expected?
- [ ] No obvious gaps?
```

### 3. Context Assumption

**The Failure:** Assuming sub-agents have context they don't have.

**Prevention:**
- Everything sub-agent needs must be in dispatch
- Reference files by path, not assumption
- Provide context explicitly

**Self-Check:**
```markdown
Before dispatching sub-agent:
- [ ] All needed files referenced?
- [ ] Prior phase context included?
- [ ] Scope clearly bounded?
```

### 4. Gate Rushing

**The Failure:** Passing gates quickly to maintain momentum.

**Prevention:**
- Gates exist for a reason
- Every gate check must be actually checked
- Conditional pass must have follow-up

**Self-Check:**
```markdown
At every gate:
- [ ] Did I actually check each criterion?
- [ ] Did I verify, not assume?
- [ ] Are all conditions met?
```

---

## Confidence Level Tracking

Every handoff and phase transition should include:

```yaml
confidence_level: medium  # high, medium, low
concerns:
  - [List any uncertainties]
```

### Confidence Definitions

| Level | Meaning | Required Action |
|-------|---------|-----------------|
| HIGH | Verified, no concerns | Proceed normally |
| MEDIUM | Mostly verified, minor uncertainty | Note concerns, proceed with caution |
| LOW | Significant uncertainty | Spawn verification sub-agent OR escalate |

### When Confidence is LOW

1. **Identify** what specifically is uncertain
2. **Decide** if sub-agent can resolve it
3. **Spawn** verification sub-agent if yes
4. **Escalate** to human if no
5. **Never** proceed on low confidence

---

## Red Flags 🚩

Stop immediately when you see:

| Red Flag | Immediate Action |
|----------|-----------------|
| "I think this should work" | STOP. Verify. |
| Missing handoff from sub-agent | Terminate, request handoff |
| Skipping a gate "to save time" | Gates save time, not skip |
| Low confidence not addressed | Address before proceeding |
| Assumption without documentation | Write to assumptions.md |
| "It's probably fine" | Probably = certainly not verified |
| Scope seems larger than planned | Re-read interpretation |
| Sub-agent took too long | Check if stuck, may need split |

---

## Self-Check Questions

Ask yourself these questions regularly:

### Before Spawning Sub-Agent
- Does dispatch have all needed context?
- Is scope clearly bounded?
- Is return format specified?
- Am I making any assumptions?

### After Sub-Agent Returns
- Does handoff exist and complete?
- Did I verify key findings?
- Is confidence level appropriate?
- Are there any red flags?

### Before Phase Transition
- Did all gate checks pass (actually)?
- Is confidence level documented?
- Are concerns addressed or flagged?
- Is next phase set up for success?

### Before Completion
- Am I confident this is correct, or do I just hope so?
- Did I verify, not just trust?
- Is there anything I'm uncertain about?
- Would this pass human review?

---

## The Skeptical Orchestrator Summary

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     THE SKEPTICAL ORCHESTRATOR                              │
│                                                                             │
│  ✓ Verifies every sub-agent output                                          │
│  ✓ Questions assumptions                                                    │
│  ✓ Reads before guessing                                                    │
│  ✓ Checks gates thoroughly                                                  │
│  ✓ Admits uncertainty via confidence levels                                 │
│  ✓ Escalates when stuck                                                     │
│  ✓ Learns from mistakes via memory files                                    │
│                                                                             │
│  "Skepticism is not distrust. It is the foundation of trust."               │
└─────────────────────────────────────────────────────────────────────────────┘
```

````
