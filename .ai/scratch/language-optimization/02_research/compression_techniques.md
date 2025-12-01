# Prompt Compression Techniques

## Core Principle

**Compression Goal:** Reduce tokens while preserving semantic activation.

LLMs don't need grammatically correct prompts—they need semantically rich prompts. Many English conventions exist for human readers, not for vector space navigation.

---

## Safe Compressions (No Semantic Loss)

### 1. Remove Articles (the, a, an)

Articles add grammatical correctness but minimal semantic value.

| Original | Compressed | Savings |
|----------|------------|---------|
| "Analyze the codebase and identify the patterns" | "Analyze codebase, identify patterns" | 4 tokens |
| "You are a senior engineer working on the backend" | "You: senior engineer, backend" | 7 tokens |
| "Create a new file in the directory" | "Create file in directory" | 3 tokens |

**Risk Level:** ⬛ SAFE - No observed semantic drift

### 2. Remove Filler Phrases

| Original | Compressed | Savings |
|----------|------------|---------|
| "What I need you to do is..." | [DELETE] | 7 tokens |
| "Please make sure that you..." | [DELETE] | 5 tokens |
| "I would like you to..." | [DELETE] | 5 tokens |
| "In order to..." | "To" | 2 tokens |
| "Due to the fact that..." | "Because" | 4 tokens |
| "At this point in time" | "Now" | 4 tokens |

**Risk Level:** ⬛ SAFE - Filler phrases are noise, not signal

### 3. Use Symbols for Common Words

| Original | Compressed | Savings |
|----------|------------|---------|
| "therefore", "thus", "so" | "→" | 1 token |
| "equals", "is equal to" | "=" | 2-3 tokens |
| "not", "do not" | "≠" or "!" | 1-2 tokens |
| "and" | "&" or "+" | 0-1 tokens |
| "greater than" | ">" | 2 tokens |
| "results in" | "→" | 2 tokens |

**Risk Level:** ⬛ SAFE - Symbols are unambiguous

### 4. Collapse Verbose Constructions

| Original | Compressed | Savings |
|----------|------------|---------|
| "You should always make sure to verify" | "Always verify" | 5 tokens |
| "It is important that you do not skip" | "Never skip" | 6 tokens |
| "The system is responsible for handling" | "System handles" | 4 tokens |
| "In the event that an error occurs" | "On error" | 5 tokens |

**Risk Level:** ⬛ SAFE - Semantically equivalent

### 5. Use Markdown Structure Instead of Prose

**Original (47 tokens):**
```
When you encounter an error, you should first stop what you're doing. 
Then you should read the error message carefully. After that, you 
should diagnose the root cause before attempting any fix.
```

**Compressed (16 tokens):**
```markdown
On error:
1. STOP
2. READ error
3. DIAGNOSE root cause
4. Then fix
```

**Savings:** 31 tokens (66% reduction)
**Risk Level:** ⬛ SAFE - Structure preserves sequence

---

## Moderate-Risk Compressions (Monitor for Drift)

### 6. Remove Connector Words Selectively

Connectors create logical flow but are sometimes redundant.

| Original | Compressed | Risk |
|----------|------------|------|
| "First analyze, then design, and finally implement" | "Analyze → design → implement" | Low |
| "However, this approach has limitations" | "Limitation:" | Medium |
| "Additionally, you should consider..." | "[new bullet]" | Low |
| "Furthermore, it's worth noting that..." | "[DELETE or new bullet]" | Low |

**Risk Level:** 🟨 MODERATE - May lose nuance in complex logic

**Safe Pattern:** Replace prose connectors with structural elements (bullets, arrows, numbered lists)

### 7. Abbreviate Common Terms (With Definition)

**Only safe when definition is provided once:**

```markdown
## Definitions
- SA: Sub-Agent
- HO: Handoff
- QG: Quality Gate

## Rules
- SA spawns when >5 files
- Every SA creates HO before terminating
- QG must pass before phase transition
```

**Risk Level:** 🟨 MODERATE - Requires definition section; avoid for rare terms

### 8. Pronoun Elimination

| Original | Compressed | Risk |
|----------|------------|------|
| "When you find an error, you should log it" | "On error: log" | Low |
| "The user provides input and the system processes it" | "User input → system process" | Low |
| "If they don't respond, you should retry" | "No response → retry" | Low |

**Risk Level:** 🟨 MODERATE - Context usually clear from structure

---

## High-Risk Compressions (Potential Meaning Drift)

### 9. Removing Emphasis Words

| Original | Compressed | Risk |
|----------|------------|------|
| "You MUST verify" | "Verify" | HIGH |
| "NEVER skip this step" | "Don't skip" | HIGH |
| "This is CRITICAL" | "Important" | HIGH |
| "Absolutely do not..." | "Don't..." | HIGH |

**Risk Level:** 🟥 HIGH - Emphasis words carry behavioral weight

**Recommendation:** Keep emphasis. Consider symbol alternatives:
- MUST → `[!]` or `⚠️`
- NEVER → `❌`
- CRITICAL → `🔴`

### 10. Removing Examples

| Original | Has Example | Without |
|----------|-------------|---------|
| "Format: YYYY-MM-DD (e.g., 2024-01-15)" | ✅ Precise | ❌ May vary |
| "Use snake_case like user_name" | ✅ Clear | ❌ Ambiguous |

**Risk Level:** 🟥 HIGH - Examples anchor interpretation

**Recommendation:** Keep at least one example for ambiguous formats

### 11. Collapsing Multi-Step Logic

**Original:**
```
If the file exists, check if it's writable. 
If it's writable, append the log. 
If not writable, create a new file. 
If file doesn't exist, create it first.
```

**Over-Compressed:**
```
Write to file (create if needed)
```

**Risk Level:** 🟥 HIGH - Lost the writability check entirely

**Safe Compression:**
```markdown
Write log:
- File exists + writable → append
- File exists + !writable → create new
- !File exists → create
```

---

## Compression Templates

### Template 1: Role Definition

**Before (42 tokens):**
```markdown
You are a highly experienced software architect who specializes in 
distributed systems. You should approach problems with a focus on 
scalability and reliability. Your communication style should be 
technical but clear.
```

**After (18 tokens):**
```markdown
Role: Distributed systems architect
Focus: Scalability, reliability
Style: Technical, clear
```

**Savings:** 57%

### Template 2: Behavioral Rules

**Before (67 tokens):**
```markdown
When you are working on a task, you should always make sure to document 
your progress as you go. You should never proceed to the next step without 
first verifying that the current step was completed successfully. If you 
encounter any errors, you should stop immediately and assess the situation.
```

**After (28 tokens):**
```markdown
## Rules
1. Document progress continuously
2. Verify step completion before proceeding
3. On error: STOP, assess, then continue
```

**Savings:** 58%

### Template 3: Scope Definition

**Before (51 tokens):**
```markdown
For this task, you should focus only on the authentication module. 
Please do not make any changes to the user interface components or 
the database layer. Your scope is limited to the auth service and 
its direct dependencies.
```

**After (22 tokens):**
```markdown
## Scope
IN: auth service + direct dependencies
OUT: UI components, database layer
```

**Savings:** 57%

---

## Compression Ratios by Element Type

| Element | Typical Compression | Safe Target |
|---------|---------------------|-------------|
| Role definitions | 50-60% | 55% |
| Behavioral rules | 55-65% | 60% |
| Scope definitions | 50-60% | 55% |
| Examples | 0-20% | 10% |
| Emphasis markers | 0% | 0% |
| Success criteria | 30-40% | 35% |
| Error handling | 40-50% | 45% |

---

## Token Counting Reference

Approximate token costs (GPT-4/Claude):

| Element | Tokens |
|---------|--------|
| Common word (the, is, to) | 1 |
| Technical term (authentication) | 1-2 |
| Code block marker (```) | 1 |
| Markdown header (#, ##) | 1 |
| Bullet point (-) | 1 |
| Emoji | 1-2 |
| Symbol (→, ≠) | 1 |
| Line break | 0 |
| Space | 0 (included in word tokens) |

---

## The Compression Decision Matrix

```
┌─────────────────────────────────────────────────────────────────┐
│                   SHOULD I COMPRESS THIS?                        │
│                                                                  │
│  Does removing it change meaning?                                │
│      YES → Keep it                                               │
│      NO  → ↓                                                     │
│                                                                  │
│  Does it provide emphasis/priority?                              │
│      YES → Keep it (or replace with symbol)                      │
│      NO  → ↓                                                     │
│                                                                  │
│  Is it an example of ambiguous format?                           │
│      YES → Keep at least one                                     │
│      NO  → ↓                                                     │
│                                                                  │
│  Is it grammatical filler (articles, "please", "I would like")? │
│      YES → COMPRESS                                              │
│      NO  → Keep unless obviously redundant                       │
└─────────────────────────────────────────────────────────────────┘
```

---

## Before/After: Full Prompt Compression

### Before (189 tokens)

```markdown
# Instructions for Code Analysis

Hello! I would like you to analyze the codebase that I'm going to 
share with you. Please focus specifically on the authentication 
module, as this is the area that we're most concerned about.

When you do your analysis, please make sure that you:
1. First, look at the overall structure of the authentication code
2. Then, identify any potential security vulnerabilities that you find
3. After that, document your findings in a clear and organized way
4. Finally, provide recommendations for how we could improve the security

Please note that you should not make any actual changes to the code. 
This is just an analysis task. Also, please make sure to be thorough 
in your investigation.

Thank you for your help!
```

### After (52 tokens)

```markdown
# Auth Module Security Analysis

## Scope
- IN: Authentication module
- OUT: Code changes (analysis only)

## Tasks
1. Map auth code structure
2. Identify security vulnerabilities
3. Document findings (structured)
4. Recommend security improvements

## Output
Markdown report with findings + recommendations
```

### Savings: 72% (137 tokens)

---

## Key Takeaways

1. **Structure > Prose** - Markdown formatting preserves meaning with fewer tokens
2. **Keep emphasis markers** - MUST/NEVER carry behavioral weight
3. **Keep one example** - Especially for format specifications
4. **Delete all filler** - "I would like you to" = 0 semantic value
5. **Symbols work** - → ≠ ✅ ❌ are unambiguous and token-efficient
6. **Test after compression** - Run compressed prompt, check for drift

---

## Next: Consistency Patterns

See [consistency_patterns.md](consistency_patterns.md) for patterns that produce reliable outputs.
