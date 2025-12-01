# Self-Analysis

Cross-session failure logging and pattern detection.

## Purpose

Agents log execution issues here. Future sessions read patterns to avoid repetition.

## Structure

```
self-analysis/
├── README.md          # This file
├── index.md           # Summary + statistics
├── sessions/          # Per-session logs
│   └── {date}-{topic}.md
└── compilations/      # Compilation-specific logs
    └── {date}-{file}.md
```

## Categories

| Code            | Meaning                 | Trigger                           |
| --------------- | ----------------------- | --------------------------------- |
| DRIFT           | Role deviation          | Output ≠ intent                   |
| OVERFLOW        | Context exceeded        | Truncated output                  |
| GATE_SKIP       | Verification skipped    | Phase change without check        |
| SCOPE_CREEP     | Scope exceeded          | Files outside IN list             |
| LAW_VIOLATION   | Three Laws breached     | Sub-agent not spawned, no handoff |
| SEMANTIC_DRIFT  | Meaning changed         | Compression altered intent        |
| DESIGN_MISMATCH | Implementation ≠ design | Code diverges from spec           |

## Entry Format

```markdown
# Self-Analysis: {CATEGORY}

## Metadata

- Date: {YYYY-MM-DD}
- Task: {task}
- Agent: {type}
- Phase: {phase}

## Trigger

{observable symptom}

## Analysis

{root cause}

## Correction

{fix applied}

## Prevention

{future avoidance}
```

## Usage

### Writing

On task completion → Log issues using format above

### Reading

Session start → Check `index.md` for recent patterns

### Pattern Detection

Same category >3 times → Update kernel rules
