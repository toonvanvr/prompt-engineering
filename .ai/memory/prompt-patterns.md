# Prompt Engineering Patterns - Master Reference

## Universal Patterns (Use in ALL Agents)

### Identity Patterns
- **Three Laws**: Define 3 memorable, action-oriented laws that anchor behavior
- **Role-Mindset-Style-Superpower**: 4-part identity matrix
- **ALWAYS/NEVER**: Binary constraints, 5-7 items each, emphatic formatting

### Verification Patterns
- **Non-Negotiable Verification**: Every change must be verified
- **Skepticism Default**: Assume wrong until verified
- **Confidence Tracking**: HIGH/MEDIUM/LOW with concerns list

### Error Recovery Patterns
- **3-Attempt Escalation**: Attempt 1 → 2 → 3 → ESCALATE
- **STOP-READ-DIAGNOSE-FIX-VERIFY**: Mnemonic recovery protocol
- **Escalation Template**: Structured with attempts, hypothesis, specific question

### State Management Patterns
- **STATE.md**: Persistent memory across sessions
- **Decision Log**: Track all non-trivial decisions
- **Resume Protocol**: Check state before asking user

### Sub-Agent Patterns
- **5-Part Template**: OBJECTIVE, CONTEXT, YOUR TASK, RETURN FORMAT, CONSTRAINTS
- **Return Format Specification**: Exact structure for sub-agent output
- **Scope Boundaries**: Explicit IN SCOPE / OUT OF SCOPE

## High-Impact Patterns (Priority Application)

| Pattern | Impact | Effort | Priority |
|---------|--------|--------|----------|
| Three Laws | HIGH | LOW | 9/10 |
| Identity Matrix | HIGH | LOW | 9/10 |
| ALWAYS/NEVER | HIGH | LOW | 9/10 |
| 3-Attempt Escalation | HIGH | MEDIUM | 8/10 |
| Skepticism Framework | HIGH | MEDIUM | 8/10 |
| Verification Non-Negotiable | HIGH | LOW | 7/10 |
| Red Flag Recognition | MEDIUM | LOW | 7/10 |
| 1-1-1 Rule | MEDIUM | LOW | 6/10 |
| Resume Protocol | MEDIUM | LOW | 6/10 |

## Visual Patterns

- Mermaid for diagrams
- Tables for structured data
- Emoji 🚩 for red flags

## Anti-Patterns to Avoid

- Random changes without diagnosis
- Skipping sub-agents "to save time"
- Gate rushing
- Trust without verification
- Monolithic documents (>500 lines)
- Open-ended escalation questions
