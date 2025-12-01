# Templates Library

This directory contains reusable templates for various agent operations.

## Template Categories

### Sub-Agent Dispatches
Templates for spawning sub-agents for specific tasks:
- `dispatch-analysis.md` - Analysis phase sub-agent
- `dispatch-design.md` - Design phase sub-agent  
- `dispatch-implementation.md` - Implementation phase sub-agent
- `dispatch-review.md` - Review phase sub-agent

### Phase Documents
Templates for phase-specific documentation:
- `phase-interpretation.md` - Request interpretation template
- `phase-analysis.md` - Analysis findings template
- `phase-design.md` - Design document template
- `phase-handoff.md` - Standard handoff template

### Quality Checklists
- `checklist-design-review.md` - Design review checklist
- `checklist-implementation-review.md` - Implementation review checklist

## Usage

Templates are referenced using Markdown links in agent files:
```markdown
Follow the template in [dispatch-analysis](./templates/dispatch-analysis.md)
```

The orchestrator and sub-agents should use these templates to ensure consistency.
