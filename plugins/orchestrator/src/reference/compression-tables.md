# Compression Phase Tables

Detailed compression rules for the Compiler agent. Extracted from `plugins/orchestrator/src/compiler.src.md`.

---

## Phase 1: Safe Compressions (Apply Always)

Zero observed semantic drift. Apply unconditionally unless source is marked for preservation.

### 1a. Filler Phrase Removal

|Original|Action|
|-|-|
|"I would like you to"|DELETE|
|"Please make sure that you"|DELETE|
|"What I need you to do is"|DELETE|
|"Make sure to"|DELETE|
|"Please" (standalone)|DELETE|
|"Thank you for your help"|DELETE|
|"Hello!" / greetings|DELETE|
|"I want you to"|DELETE|
|"You should"|DELETE|
|"It is important that you"|DELETE|
|"Please note that"|DELETE|

**Exception:** Keep if removing changes instruction meaning (e.g., "Please STOP" — keep both words).

### 1b. Article Removal

Remove articles where grammatically safe: "the user" → "user", "a file" → "file"

**KEEP articles in:**
- Disambiguation ("the main function" vs "a function")
- Proper nouns ("The Hague")
- Inside quotes, examples, or code blocks

### 1c. Verbose Construction Collapse

|Original|Compressed|Saved|
|-|-|-|
|"In order to"|"To"|2|
|"Due to the fact that"|"Because"|4|
|"At this point in time"|"Now"|4|
|"In the event that"|"If"|3|
|"For the purpose of"|"For"|3|
|"Is able to"|"Can"|2|
|"You should always make sure to"|"Always"|5|

### 1d. Symbol Substitution

|Word/Phrase|Symbol|Context|
|-|-|-|
|therefore, thus, consequently|→|Consequence|
|results in, leads to|→|Causation|
|and|& or +|Conjunction|
|equals, is equal to|=|Comparison|
|not, do not|! or ≠|Negation|
|greater than / less than|> / <|Comparison|
|for example|e.g.,|Illustration|
|that is|i.e.,|Clarification|

### 1e. Markdown Syntax Compression

|Element|Verbose|Dense|
|-|-|-|
|Table separators|`\| --- \| ---- \|`|`\|-\|-\|`|
|Fence: markdown|` ```markdown `|` ```md `|
|Fence: javascript|` ```javascript `|` ```js `|
|Fence: typescript|` ```typescript `|` ```ts `|
|Fence: python|` ```python `|` ```py `|
|Fence: bash|` ```bash `|` ```sh `|
|Table padding|Spaces to align|No padding|

**Fence tag rules:** Use standard abbreviations. No abbreviation exists → keep original. Never invent abbreviations.

### 1f. Prose to Structure

Convert paragraph prose to markdown lists/tables.

**Before (47 tokens):**
```
When you encounter an error, you should first stop what you're doing.
Then you should read the error message carefully. After that, you
should diagnose the root cause before attempting any fix.
```

**After (16 tokens):**
```md
On error:
1. STOP
2. READ error message
3. DIAGNOSE root cause
4. Then fix
```

### 1g. Register Transformation

Normalize input to Technical Documentation register:

|Register|Indicators|Action|
|-|-|-|
|Casual|Contractions, slang, "hey"|Full rewrite|
|Tutorial|"Let's", step explanations|Remove explanations|
|Academic|Passive voice, hedging|Remove hedging|
|Technical|Imperative, structured|Compress only|

Detection: Scan first 100 words. ≥3 casual indicators → Casual. ≥2 tutorial → Tutorial. ≥2 academic → Academic. Default: Technical.

When transforming: preserve all **actions** (verbs + objects), preserve all **constraints** (conditions, limits), remove only **style** (tone, explanations, hedging).

---

## Phase 2: Moderate Compressions (FULL Mode Only)

Require tracking. Skipped in CONSERVATIVE mode.

### 2a. Term Abbreviation

When a term appears 3+ times, define once and abbreviate:
- Term must appear 3+ times
- Definition placed at top (after Identity, before main content)
- Only abbreviate terms >6 characters
- Use first letters or standard industry abbreviation
- NEVER abbreviate: proper nouns, emphasis markers, terms in examples

### 2b. Pronoun Elimination

Delete pronouns when context is clear (referent identifiable within same or immediately prior sentence).

|Original|Compressed|
|-|-|
|"When you find an error, you should log it"|"On error: log"|
|"If they don't respond, you should retry"|"No response → retry"|

Keep pronouns when referent is ambiguous (multiple potential referents).

### 2c. Sequential Logic Collapse

Collapse multi-step conditionals into structured format:

**Before:**
```
If the file exists, check if it's writable.
If it's writable, append the log.
If not writable, create a new file.
If file doesn't exist, create it first.
```

**After:**
```md
Write log:
- File exists + writable → append
- File exists + !writable → create new
- !File exists → create
```

### 2d. Related Bullet Merge

Merge bullets that act on same object or are sequential steps of one operation.
- Maximum 4 items per merged bullet
- Use comma-separation
- Preserve order
- Do NOT merge if items have different objects, conditional dependencies, or would exceed 80 characters

**Before:** "Read the config file" / "Parse the config file" / "Validate the config values"
**After:** "Read, parse, validate config file"

---

## Phase 3: Validation (Mandatory for All Modes)

Verify critical anchors preserved. Flag risky compressions. MANDATORY.

### 3a. Semantic Preservation Checks

|Check|Pass Condition|
|-|-|
|Example Check|All code blocks and examples identical between original and compressed|
|Emphasis Check|Count of MUST/NEVER/ALWAYS/REQUIRED/FORBIDDEN matches original|
|Intent Check|Each instruction has corresponding instruction with same action verb, object, conditions|
|Structure Check|Section hierarchy preserved; no sections removed unless empty|
|Instruction Count|No instructions removed (only reformatted)|
|List Integrity|Bullet count stable (merges documented)|

### 3b. High-Risk Pattern Detection

Flag as HIGH risk and add to warnings:

|Pattern|Why|
|-|-|
|Conditional removed|Logic change|
|Number/threshold modified|Specification change|
|Emphasis marker missing|Behavioral anchor lost|
|Example altered|Interpretation anchor lost|
|Code block changed|Syntax may break|
|Format spec modified|Output spec changed|
|Negation removed ("not", "don't")|Inverts meaning|
