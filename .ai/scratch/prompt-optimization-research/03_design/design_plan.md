# Design Phase: Internal Agent Optimization

## Executive Summary

Based on the comprehensive pattern analysis (30 patterns identified) and gap analysis (19 gaps found), this document defines the optimization strategy for internal agents.

## Optimization Targets

### Primary Target: `agents/end-to-end.agent.md`
The main orchestrator agent that will receive the most significant enhancements.

### Secondary Targets:
- `agents/lib/kernel/orchestration.md`
- `agents/lib/kernel/quality-gates.md`
- `agents/lib/kernel/sub-agent-protocol.md`
- `agents/lib/kernel/context-management.md`
- `agents/lib/templates/*.md`

## Pattern Application Plan

### Tier 1: Identity & Behavioral Foundation (Immediate)

| Pattern | Target File | Change |
|---------|-------------|--------|
| Three Laws Identity | end-to-end.agent.md | Add after PRIME DIRECTIVE |
| Role-Mindset-Style-Superpower | end-to-end.agent.md | Add Identity section |
| ALWAYS/NEVER Lists | end-to-end.agent.md | Convert FORBIDDEN PATTERNS |

### Tier 2: Error Recovery & Skepticism (Core Enhancement)

| Pattern | Target File | Change |
|---------|-------------|--------|
| 3-Attempt Escalation | orchestration.md | Add protocol section |
| Escalation Template | templates/ | Create escalation.md |
| Skepticism Framework | kernel/ | Create skepticism.md |
| STOP-READ-DIAGNOSE-FIX-VERIFY | orchestration.md | Add mnemonic |

### Tier 3: Verification & Quality (Hardening)

| Pattern | Target File | Change |
|---------|-------------|--------|
| Verification Non-Negotiable | quality-gates.md | Add emphasis section |
| Red Flag Recognition | quality-gates.md | Add red flag table |
| Common Error Tables | kernel/ | Create error-patterns.md |

### Tier 4: State & Communication (Polish)

| Pattern | Target File | Change |
|---------|-------------|--------|
| Resume Protocol | end-to-end.agent.md | Add resume section |
| Confidence Tracking | phase-handoff.md | Add confidence field |
| Communication Examples | end-to-end.agent.md | Add examples block |
| 1-1-1 Rule | dispatch-implementation.md | Add rule section |

### Tier 5: New Files to Create

1. `agents/lib/kernel/skepticism.md` - Skepticism framework
2. `agents/lib/kernel/error-patterns.md` - Common error catalog
3. `agents/lib/templates/escalation.md` - Escalation template

## Design Decisions

| Decision | Rationale |
|----------|-----------|
| Keep sub-agent emphasis prominent | User requirement - core capability |
| Preserve existing phase structure | Internal strength to maintain |
| Add patterns inline, not just references | Ensures patterns are in context |
| Use external lib files as reference | Proven effective in external agents |

## Implementation Order

1. end-to-end.agent.md (main agent with identity, laws, ALWAYS/NEVER)
2. kernel/orchestration.md (error recovery protocols)
3. kernel/quality-gates.md (verification & red flags)
4. kernel/skepticism.md (new file)
5. kernel/error-patterns.md (new file)
6. templates/escalation.md (new file)
7. kernel/sub-agent-protocol.md (tool matrix, context)
8. kernel/context-management.md (layered context)
9. All dispatch templates (1-1-1 rule)
10. phase-handoff.md (confidence tracking)

## Success Criteria

- [ ] 30 patterns from external agents applied or adapted
- [ ] 19 gaps closed
- [ ] Sub-agent emphasis maintained throughout
- [ ] All new files created
- [ ] Internal strengths preserved
