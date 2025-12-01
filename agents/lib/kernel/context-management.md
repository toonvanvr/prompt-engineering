# Context Management Rules

Managing context window is CRITICAL for agent quality. These rules prevent the degradation that occurs when context overflows and gets summarized.

> **Core Reference**: See [orchestration.md](orchestration.md) for sub-agent sizing, [skepticism.md](skepticism.md) for verification.

## The Context Catastrophe

When your context window fills:
1. The system summarizes older content
2. Critical details are lost in summarization
3. You lose track of nuances, edge cases, and decisions
4. Quality drops precipitously

**This is why sub-agents exist.** Each sub-agent starts fresh but has access to documented findings.

---

## The Four Layers of Context

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ LAYER 1: SYSTEM (Agent Identity)                                            │
│ - Role, mindset, style, superpower                                          │
│ - Three Laws                                                                │
│ - ALWAYS/NEVER rules                                                        │
│ - Core capabilities                                                         │
│ CHANGES: Never (immutable once set)                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│ LAYER 2: TASK (Current Work)                                                │
│ - Specific instructions for current phase                                   │
│ - Success criteria                                                          │
│ - Scope boundaries                                                          │
│ - Constraints and requirements                                              │
│ CHANGES: Per phase/task                                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│ LAYER 3: TOOL (Capabilities)                                                │
│ - Available tools and when to use them                                      │
│ - Tool-specific instructions                                                │
│ - Error handling for tool failures                                          │
│ CHANGES: Per session                                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│ LAYER 4: MEMORY (Historical Context)                                        │
│ - STATE.md tracking                                                         │
│ - Previous decisions and learnings                                          │
│ - Handoff documents from prior phases                                       │
│ - .ai/memory/ files                                                         │
│ CHANGES: Constantly (every task completion)                                 │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Layer Management Rules

| Layer | Stored In | Update Frequency | Can Be Summarized? |
|-------|-----------|------------------|-------------------|
| SYSTEM | Agent file | Never | No |
| TASK | Dispatch prompt | Per phase | No |
| TOOL | Available tools | Per session | No |
| MEMORY | Files (.ai/) | Every task | Yes (external files) |

### Preventing Layer Pollution

1. **System content** never changes mid-task
2. **Task content** is replaced entirely between phases
3. **Tool content** is consistent within session
4. **Memory content** flows through files, not context

---

## Context Budget Allocation

Allocate your context window as follows:

| Category | % of Context | Purpose |
|----------|--------------|---------|
| Kernel Instructions | 5-10% | Rules and protocols |
| Task Context | 15-25% | Current task requirements |
| Code Reading | 30-40% | Source files being analyzed |
| Working Memory | 20-30% | Reasoning and planning |
| Output Generation | 10-20% | Writing files and responses |

## File Reading Strategy

### Tiered Reading

**Tier 1: Full Read (High Priority)**
- Files directly modified by the task
- Core domain models
- Entry points and controllers

**Tier 2: Structural Read (Medium Priority)**
- Read class/method signatures
- Skip implementation details
- Note dependencies

**Tier 3: Reference Check (Low Priority)**
- Grep for specific patterns
- Check existence and interfaces only

### Reading Chunks

When reading files:
- Read 200-500 lines at a time for analysis
- Read 50-100 lines at a time for verification
- Never read entire large files (>500 lines) in one go

## Documentation Size Limits

Keep documentation files manageable:

| Document Type | Max Lines | Action if Exceeded |
|---------------|-----------|-------------------|
| Analysis notes | 300 | Split by concern |
| Design docs | 500 | Split by component |
| Handoff summaries | 100 | Summarize further |
| Code comments | 50 per file | Be more concise |

## Context Checkpoints

At these points, STOP and document:

1. **Before spawning sub-agent**
   - Document all context needed
   - Create handoff file
   
2. **After reading 10+ files**
   - Summarize findings so far
   - Document key patterns
   
3. **Before implementation**
   - Document the plan
   - List all files to modify
   
4. **After each logical unit of work**
   - Update progress tracking
   - Document decisions

## Information Hierarchy

When documenting, prioritize:

1. **Must Know** - Critical for correctness
   - Always include in handoffs
   - Keep precise and detailed
   
2. **Should Know** - Important for quality
   - Include in analysis docs
   - Can be referenced rather than repeated
   
3. **Nice to Know** - Helpful background
   - Keep in separate reference files
   - Summarize in handoffs

## Anti-Patterns to Avoid

❌ **Context Hoarding**
Trying to keep everything in working memory. Use files.

❌ **Repeat Reading**
Reading the same files multiple times. Document findings first time.

❌ **Monolithic Documents**
Creating single huge analysis files. Split by concern.

❌ **Undocumented Decisions**
Making choices without recording rationale. Always document why.

❌ **Context Assumption**
Assuming sub-agents know what you know. They don't. Document it.

## Recovery from Context Pressure

If you notice context getting full:

1. **Immediate:** Stop current operation
2. **Document:** Write current state to files
3. **Assess:** Determine if sub-agent is needed
4. **Split:** Break remaining work into smaller chunks
5. **Continue:** Resume with fresh context

## Memory Persistence Pattern

For complex tasks, use this pattern:

```
1. Read requirements
2. Document understanding in scratch/
3. Read relevant code
4. Document findings in scratch/
5. Make decisions
6. Document decisions in scratch/
7. Implement
8. Document results in scratch/
```

This ensures no insights are lost to context summarization.
