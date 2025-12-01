# General Remarks

## Prompt Engineering Research Findings (December 2025)

### High-Value Patterns Discovered
1. **Three Laws Pattern** - 88% of effective agents use 3 memorable, action-oriented laws
2. **ALWAYS/NEVER Lists** - 100% usage in analyzed agents; binary constraints > prose
3. **Identity Matrix** - Role/Mindset/Style/Superpower creates multi-dimensional persona
4. **3-Attempt Escalation** - Prevents infinite loops while ensuring effort
5. **Skepticism Default** - "Verify then trust" > "Trust but verify"

### Sub-Agent Orchestration Critical Finding
Sub-agent usage is the primary scaling mechanism for complex tasks. External agents that underutilize sub-agents show context overflow symptoms in longer tasks.

### File Anomaly Noted
`external/agents/product-designer.agent.md` and `external/agents/technical-architect.agent.md` appear to have identical content (Product Designer). This may indicate a copy error in the external corpus.

### Pattern Application Priority
When optimizing agents, apply in this order:
1. Identity (Three Laws, Role matrix) - LOW effort, HIGH impact
2. Behavioral Constraints (ALWAYS/NEVER) - LOW effort, HIGH impact  
3. Error Recovery (3-attempt, STOP-READ-DIAGNOSE-FIX-VERIFY) - MEDIUM effort, HIGH impact
4. Verification (Skepticism, Red Flags) - MEDIUM effort, HIGH impact
5. State (Resume protocol, Confidence) - LOW effort, MEDIUM impact

## Project Conventions

### Agent File Structure
- YAML frontmatter with tools, model, handoffs
- Identity section (Role/Mindset/Style/Superpower)
- Three Laws
- ALWAYS/NEVER lists
- Phase workflow
- Error recovery protocol
- Communication examples

### Kernel Structure
- orchestration.md - Master rules
- sub-agent-protocol.md - Delegation rules
- context-management.md - 4-layer architecture
- quality-gates.md - Verification requirements
- skepticism.md - Verification mindset
- error-patterns.md - Common errors
