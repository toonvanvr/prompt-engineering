# Dispatch Sub-Agent

## Description
How to dispatch a sub-agent using the v2 template, including pre-dispatch checklist.

## Pre-Dispatch Checklist
1. Read `.ai/feedback/pattern_failures.md` for relevant anti-instructions
2. Prepare scope (DO/DON'T lists with equal specificity)
3. Identify output path and format skeleton
4. Extract state summary from progress.md (2-3 sentences max)
5. Prepare verification command

## v2 Dispatch Template

### SCOPE
- DO: {1-3 specific deliverables with file paths}
- DO NOT: {explicit exclusions}
- MAX DELIVERABLES: 3 per SA

### OUTPUT
- Write to: {exact file path}
- Format: {heading skeleton or reference to template}
- Max length: {line count guideline}

### CONTEXT
- Read first: {max 3 file paths}
- State: {2-3 sentences from progress.md}
- Anti-instructions: {from feedback files}

### VERIFY
- Command: {exact shell command}
- Expected: {what success looks like}

### CONSTRAINTS
- Write ALL output to specified file, not to chat
- Do NOT spawn sub-agents
- Do NOT modify files outside scope
- Use scratch/ for WIP, library/ only for finalized generic knowledge
- Non-interactive CLI flags: --no-interaction, -y, --reporter=dot
