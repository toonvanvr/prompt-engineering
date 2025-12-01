# Language Pattern Taxonomy for LLM Behavior

## Core Hypothesis Validated

**Documentation-style language** activates expert semantic spaces in LLMs because:
1. Training data correlation: Technical docs written by experts → expert behavior patterns
2. Low noise ratio: Documentation has high signal density
3. Consistent structure: Predictable patterns enable reliable completion

**School assignment-style language** activates learner semantic spaces because:
1. Training data correlation: Student text → error-prone patterns, hedging, uncertainty
2. High noise ratio: Filler words, qualifiers, grammatical errors
3. Inconsistent structure: Unpredictable → model compensates with "safe" generic responses

---

## Register Classification

### Tier 1: High-Consistency Registers

#### 1.1 Technical Documentation Register
**Characteristics:**
- Imperative mood ("Configure the...", "Implement...")
- Precise terminology (no synonyms within document)
- Structured hierarchy (headers, lists, code blocks)
- No hedging ("should", "might", "could be")

**Example:**
```markdown
# API Reference: UserService

## authenticate(credentials: Credentials): Token

Validates user credentials against the identity store.

**Parameters:**
- credentials: Object containing username and password

**Returns:** JWT token on success, throws AuthError on failure

**Side Effects:** Updates last_login timestamp
```

**Activation Effect:** Technical writer / API designer persona. High precision, low variance.

#### 1.2 Specification Register
**Characteristics:**
- RFC-style language ("MUST", "SHALL", "MAY")
- Numbered requirements
- Testable assertions
- No narrative flow

**Example:**
```
REQ-001: System MUST validate all user input before processing
REQ-002: Authentication tokens SHALL expire after 24 hours
REQ-003: Failed login attempts MAY trigger rate limiting
```

**Activation Effect:** Specification author persona. Maximum consistency, zero ambiguity.

#### 1.3 Instructional Register (Expert-to-Expert)
**Characteristics:**
- Assumed competence (no over-explanation)
- Direct commands
- Concise rationale
- No motivation/encouragement

**Example:**
```markdown
## Deploy to Production

1. Tag release: `git tag v2.1.0`
2. Push tags: `git push --tags`
3. CI triggers deploy. Verify health endpoint.
4. Rollback if 5xx rate >1%: `kubectl rollout undo`
```

**Activation Effect:** Senior engineer persona. Efficient, assumes context.

---

### Tier 2: Mixed-Consistency Registers

#### 2.1 Tutorial Register
**Characteristics:**
- Progressive disclosure
- Explanation of "why"
- Encouraging language
- Assumed beginner context

**Example:**
```markdown
## Getting Started with React Hooks

Let's learn how to use the useState hook! First, we'll create a simple counter.

Don't worry if this seems confusing at first - we'll break it down step by step.
```

**Activation Effect:** Teacher persona. More verbose, occasionally oversimplifies.

**Risk:** Can activate "helpful but vague" patterns if overused.

#### 2.2 Conversational Technical Register
**Characteristics:**
- Technical content + natural flow
- Some hedging acceptable
- Personal pronouns
- Opinion markers

**Example:**
```markdown
So here's the thing about GraphQL subscriptions - they're powerful but 
can get tricky with connection management. I'd recommend starting with 
a simple pub/sub setup before going full-blown event sourcing.
```

**Activation Effect:** Experienced developer explaining. Good for exploration, less reliable for precise implementation.

---

### Tier 3: Low-Consistency Registers (AVOID in prompts)

#### 3.1 Academic Essay Register
**Characteristics:**
- Passive voice
- Hedging throughout
- Citations/references
- Tentative conclusions

**Example:**
```
It has been suggested that transformer architectures may exhibit emergent 
capabilities when scaled sufficiently (Wei et al., 2022). However, 
questions remain about whether this phenomenon can be reliably reproduced...
```

**Activation Effect:** Academic writing mode. Verbose, hedged, avoids definitive statements.

**Danger:** Prompts in this register cause uncertain, qualified outputs.

#### 3.2 Student Assignment Register
**Characteristics:**
- Filler phrases ("In this essay I will...")
- Over-qualification ("I think maybe...")
- Grammatical uncertainty
- Repetition for word count

**Example:**
```
In my opinion, I believe that the implementation of microservices 
architecture could potentially help with scaling, but it also might 
introduce some complexity that we should probably consider...
```

**Activation Effect:** Novice mode. Uncertain outputs, hallucination risk increases.

**CRITICAL ANTI-PATTERN:** Never write prompts in this register.

#### 3.3 Casual Chat Register
**Characteristics:**
- Incomplete sentences
- Slang/abbreviations
- Lack of structure
- Ambiguous references

**Example:**
```
hey so like the thing with the api is kinda broken rn
can u fix it maybe? the auth stuff i think
```

**Activation Effect:** Casual assistant mode. May ignore precision requirements, add unnecessary small talk.

---

## Persona Activation Patterns

### Expert Activation Triggers

| Trigger | Example | Effect |
|---------|---------|--------|
| Role declaration | "You are a senior architect" | Sets competence baseline |
| Domain terminology | Using correct jargon | Signals expertise expected |
| Assumption of knowledge | Skipping basics | Forces expert-level response |
| Structured format | Headers, lists, specs | Activates technical writing mode |
| Imperative mood | "Implement X" vs "Could you maybe..." | Directness signals authority |

### Learner/Novice Activation Triggers (AVOID)

| Trigger | Example | Effect |
|---------|---------|--------|
| Hedging language | "maybe", "might", "I think" | Uncertainty propagates |
| Over-explanation | Explaining basics | Implies listener is novice → becomes novice |
| Apologetic tone | "Sorry if this is wrong..." | Undermines confidence |
| Question overload | "Is this right? Does it make sense?" | Signals uncertainty |
| Verbose filler | "So basically what I mean is..." | Noise → model fills with noise |

---

## Directive Style Matrix

### Style 1: Imperative (Highest Consistency)

```markdown
# You WILL do this

1. Analyze the codebase
2. Identify patterns
3. Document findings

Do not skip steps. Do not add steps.
```

**Effect:** Military/protocol mode. Maximum compliance, minimum creativity.

### Style 2: Descriptive (Moderate Consistency)

```markdown
# Your Behavior

You analyze codebases methodically, identifying patterns and documenting 
findings in structured markdown files.
```

**Effect:** Role embodiment. Good balance of consistency and adaptation.

### Style 3: Example-Based (Variable Consistency)

```markdown
# How You Respond

Given: "Analyze authentication"
You produce:
- auth_flow.md with sequence diagrams
- security_concerns.md with risk matrix
```

**Effect:** Pattern matching. Very effective but requires good examples.

### Style 4: Outcome-Focused (Lower Consistency, Higher Creativity)

```markdown
# Your Goal

Produce a comprehensive analysis that would satisfy a senior 
security auditor reviewing the authentication system.
```

**Effect:** Goal-seeking. More creative problem-solving, less predictable format.

---

## Register Selection Guide

| Task Type | Recommended Register | Avoid |
|-----------|---------------------|-------|
| Implementation | Technical Documentation | Casual, Academic |
| Analysis | Specification + Technical | Essay, Tutorial |
| Design | Instructional + Outcome | Student, Casual |
| Creative/Exploration | Conversational Technical | Specification |
| Debugging | Technical Documentation | Academic, Casual |

---

## Minimum Viable Persona Anchors

Research question: What's the minimum text to anchor model behavior?

### Experiment Results (Conceptual)

**Anchor: Role Only**
```
You are a security engineer.
```
Effect: Moderate anchoring. Can drift without reinforcement.

**Anchor: Role + Constraint**
```
You are a security engineer. Never suggest insecure patterns.
```
Effect: Strong anchoring for the constraint. Role may still drift.

**Anchor: Role + Mindset + Style**
```
You are a security engineer. Assume all input is hostile. Respond with 
specific CVE references and mitigation code.
```
Effect: Strongest anchoring. Triple-constraint maintains persona.

**Anchor: Identity Matrix (from existing patterns)**
```
Role: Security Engineer
Mindset: All input is hostile until proven safe
Style: Technical, CVE-referenced, code-first
Superpower: Threat modeling
```
Effect: Comprehensive anchoring. 4 dimensions harder to drift.

### Minimum Viable = Role + One Strong Constraint

For basic tasks: `"You are [role]. Always/Never [constraint]."`

For complex tasks: Full Identity Matrix recommended.

---

## Key Findings Summary

1. **Documentation register > all other registers** for consistent AI output
2. **Hedging language is poison** - every "maybe" increases output variance
3. **Imperative mood** signals authority → model complies
4. **3-4 identity dimensions** prevent persona drift
5. **Example-based directives** most effective when examples are high-quality
6. **Avoid student/academic registers** - they activate low-confidence patterns

---

## Next: Compression Techniques

See [compression_techniques.md](compression_techniques.md) for how to reduce tokens while maintaining register effects.
