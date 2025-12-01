# Templates Library

This directory contains reusable templates for various agent operations.

## Template Categories

### Sub-Agent Dispatches
Templates for spawning sub-agents for specific tasks:
- `dispatch-analysis.md` - Analysis phase sub-agent
- `dispatch-design.md` - Design phase sub-agent
- `dispatch-implementation.md` - Implementation phase sub-agent (includes 1-1-1 rule)
- `dispatch-review.md` - Review phase sub-agent

### Phase Documents
Templates for phase-specific documentation:
- `phase-interpretation.md` - Request interpretation template
- `phase-handoff.md` - Standard handoff template (includes confidence tracking)

### Error Recovery
- `escalation.md` - 3-attempt escalation template for when stuck

## Key Patterns Applied

### 1-1-1 Rule (dispatch-implementation.md)
Every implementation task should be:
- 1 file changed (max 2)
- 1 verification step
- 1 clear outcome

### Confidence Tracking (phase-handoff.md)
Every handoff includes:
- Confidence level (HIGH/MEDIUM/LOW)
- Concerns list
- Mitigation for LOW confidence

### 3-Attempt Escalation (escalation.md)
After 3 failed attempts:
- Document all attempts
- Provide hypothesis
- Ask specific question

## Usage

Templates are referenced using Markdown links in agent files:
```markdown
Follow the template in [dispatch-analysis](./templates/dispatch-analysis.md)
```

The orchestrator and sub-agents should use these templates to ensure consistency.

