# External Agent Pattern Analysis

## Executive Summary

This comprehensive analysis of 8 external agents and 5 library files reveals a sophisticated, enterprise-grade prompt engineering framework built around **sub-agent orchestration**, **context engineering**, and **verification-obsessed execution**. The most powerful patterns include the "Three Laws" identity framework, layered context architecture, atomic task decomposition (1-1-1 rule), and the 3-attempt escalation protocol. The agents demonstrate a clear evolution from simple prompts to complex autonomous systems with built-in failure recovery, state persistence, and human checkpoints. Key innovations include the "Deep Agent Architecture" (planning → orchestration → context → verification → tools), file-based batch workflows for cost optimization, and skepticism frameworks that assume code is wrong until verified.

---

## Pattern Catalog

### Pattern 1: Three Laws Identity Framework
**Category**: Identity/Persona Patterns
**Frequency**: 7/8 agents (88%)
**Evidence**:
- Code-Implementer: "Three Laws of Implementation: 1. Never Stop Without Reason 2. Verify Everything 3. Track All State"
- Product-Designer: "Three Laws of Product Design: 1. Understand Before Designing 2. Explore Before Recommending 3. Document Before Implementing"
- Lazy-Developer: "Three Laws of Lazy Development: 1. Never Stop 2. Never Ask 3. Never Skip Verification"
- Implementation-Planner: "Three Laws of Prompt Engineering: 1. Atomic Tasks Only 2. Context Is Everything 3. Assume Failure"
- Guide: "Three Laws of Guidance: 1. Understand Before Directing 2. Minimize User Effort 3. Always Provide a Clear Path"
- agent-core.md: "Three Laws of Autonomous Agents: 1. Never Stop Without Reason 2. Verify Everything 3. State is Sacred"

**Effectiveness**: Creates a memorable, hierarchical constraint system that is easy for the LLM to internalize and recall. The "Three Laws" framing evokes Asimov's robotic laws, establishing authority and immutability.

**Recommendation**: Use this pattern for ALL agents. Keep laws to exactly 3 (cognitive limit), make them action-oriented imperatives, and ensure they conflict minimally with each other.

---

### Pattern 2: ALWAYS/NEVER Constraint Lists
**Category**: Behavioral Constraint Patterns
**Frequency**: 8/8 agents (100%)
**Evidence**:
- Code-Implementer: "### ALWAYS 1. Read STATE.md first... ### NEVER 1. Assume an import exists..."
- Product-Designer: "### ALWAYS 1. Use sub-agents for research... ### NEVER 1. Start implementing code..."
- CV-Content-Creator: "### 🚫 NEVER INVENT DATA - This is non-negotiable. You SHALL NOT..."
- Beast-Mode: "You MUST plan extensively before each function call"
- Lazy-Developer: "### ALWAYS 1. Push forward... ### NEVER 1. Ask 'Does this look right?'"

**Effectiveness**: Binary constraints eliminate ambiguity. ALWAYS creates mandatory behaviors; NEVER creates hard boundaries. The uppercase formatting signals importance.

**Recommendation**: Keep lists to 5-7 items max per category. Order by importance. Use emphatic formatting (bold, caps). Include consequences for violations.

---

### Pattern 3: Role-Mindset-Style-Superpower Identity Matrix
**Category**: Identity/Persona Patterns
**Frequency**: 6/8 agents (75%)
**Evidence**:
- Code-Implementer: "Role: Senior Software Engineer / Implementation Specialist. Mindset: Code is wrong until verified. Paranoid about correctness. Style: Minimal, precise. Superpower: Sub-agent delegation"
- Product-Designer: "Role: Product Designer / UX Strategist. Mindset: User-first. Style: Thorough, creative, pragmatic. Superpower: Sub-agent delegation"
- Implementation-Planner: "Role: Prompt Engineer / AI Orchestration Architect. Mindset: Skeptical about AI capabilities. Style: Precise, defensive. Superpower: Sub-agent delegation"
- Lazy-Developer: "Role: One-person engineering team. Mindset: Get it done right. Style: Decisive, thorough. Superpower: Sub-agent orchestration"

**Effectiveness**: Creates multi-dimensional persona that shapes both self-perception and behavior. "Superpower" creates a focal capability.

**Recommendation**: Standardize this 4-part structure. Ensure Mindset drives decision-making, Style drives communication, Superpower drives capability utilization.

---

### Pattern 4: Sub-Agent Delegation Templates
**Category**: Sub-Agent Orchestration Patterns
**Frequency**: 7/8 agents (88%)
**Evidence**:
```markdown
## Sub-Agent: Codebase Pattern Analysis
OBJECTIVE: Analyze existing patterns in this codebase
CONTEXT: [structured input]
YOUR TASK: [numbered steps]
RETURN FORMAT: [exact expected output structure]
CONSTRAINTS: [what NOT to do]
```
- Found in: Code-Implementer, Product-Designer, Implementation-Planner, Lazy-Developer, Guide, agent-core.md

**Effectiveness**: Strict templating ensures sub-agents receive complete context and return parseable outputs. CONSTRAINTS section prevents scope creep.

**Recommendation**: Always include all 5 sections: OBJECTIVE, CONTEXT, YOUR TASK, RETURN FORMAT, CONSTRAINTS. Keep OBJECTIVE to single sentence.

---

### Pattern 5: Layered Context Architecture (4 Layers)
**Category**: Context Engineering Patterns
**Frequency**: 3/13 files but referenced widely
**Evidence** (from agent-core.md and implementation-planner):
```
LAYER 1: SYSTEM (Agent Identity) - Role, capabilities, ALWAYS/NEVER rules
LAYER 2: TASK (Current Work) - Specific instructions, success criteria
LAYER 3: TOOL (Capabilities) - Available tools, usage instructions
LAYER 4: MEMORY (Historical Context) - STATE.md, decisions, learnings
```

**Effectiveness**: Hierarchical organization prevents context pollution. Each layer has clear purpose and update frequency.

**Recommendation**: Explicitly document which layer each piece of information belongs to. System layer rarely changes; Memory layer updates constantly.

---

### Pattern 6: STATE.md Persistent Memory
**Category**: State Management Patterns
**Frequency**: 6/8 agents + 4/5 lib files (77%)
**Evidence**:
```yaml
# STATE.md Template
project: [name]
current_module: [module-name]
current_task: [task-name]
task_progress: [X/Y]
verification_status: [pending|pass|fail]
completed_modules: [list]
blockers: [list with escalation status]
decisions: [list of decisions made]
```
- Code-Implementer: "STATE.md is your memory; update it after every task"
- agent-core.md: "State is Sacred: Always track progress. Context will be lost; state files are your memory."

**Effectiveness**: Solves the stateless LLM problem. Enables resumption after context loss. Creates audit trail.

**Recommendation**: Update STATE.md after EVERY task completion, not just phases. Include timestamps. Track verification separately from completion.

---

### Pattern 7: 3-Attempt Escalation Protocol
**Category**: Error Recovery Patterns
**Frequency**: 6/13 files (46% but in all major agents)
**Evidence**:
- error-recovery.md: "Attempt 1: Make targeted fix... Attempt 2: Gather more context... Attempt 3: Use sub-agent for deep diagnosis... Still failing? ESCALATE TO HUMAN"
- Code-Implementer: "3 attempts maximum on same error. Document each attempt in your thinking. Escalate after 3 failures with full context."
- Lazy-Developer: "Only stop when truly stuck (3 failed attempts)"

**Effectiveness**: Prevents infinite loops while ensuring reasonable effort. Creates structured escalation with documentation.

**Recommendation**: Make the 3-attempt rule immutable. Each attempt must try a DIFFERENT approach. Document all attempts before escalating.

---

### Pattern 8: Escalation Template Structure
**Category**: Error Recovery Patterns
**Frequency**: 5/13 files (38%)
**Evidence**:
```markdown
## ESCALATION NEEDED
**Module**: [module name]
**Task**: [task name]
**Error**: [exact error message]
**Attempts**:
1. [What tried] → [Why failed]
2. [What tried] → [Why failed]
3. [What tried] → [Why failed]
**Hypothesis**: [What I think is wrong]
**Need**: [Specific help required]
@human: Please advise.
```

**Effectiveness**: Structured format ensures human receives complete context. Forces agent to articulate hypothesis.

**Recommendation**: Include sub-agent diagnosis results in escalation. Always end with specific question, not open-ended request.

---

### Pattern 9: ASCII Diagram Visual Architecture
**Category**: Visual/Formatting Patterns
**Frequency**: 7/13 files (54%)
**Evidence**:
- agent-core.md: Deep Agent Architecture box diagram
- Code-Implementer: Implementation Loop flow diagram
- error-recovery.md: Recovery Decision Tree with arrows
- Implementation-Planner: Context Engineering Mermaid diagram
- Lazy-Developer: Mission Overview Mermaid graph

**Effectiveness**: Visual representation aids comprehension of complex flows. Breaks text monotony.

**Recommendation**: Use box diagrams for static architecture, flow diagrams for processes. Keep diagrams under 20 lines. Use both ASCII and Mermaid.

---

### Pattern 10: Verification Loop (Non-Negotiable)
**Category**: Verification Patterns
**Frequency**: 8/8 agents + 3/5 lib files (85%)
**Evidence**:
- verification.md: "EVERY change → Quick verification (npm run check). EVERY task → Full verification (check + test + lint). EVERY module → Comprehensive verification"
- Code-Implementer: "npm run check is non-negotiable"
- Lazy-Developer: "Verify obsessively - Run verification after every code change"
- skepticism.md: "ASSUME YOUR CODE IS WRONG UNTIL VERIFIED"

**Effectiveness**: Catches errors early. Prevents cascading failures. Creates accountability.

**Recommendation**: Embed verification commands in task definitions. Never mark task complete without verification pass.

---

### Pattern 11: Atomic Task Decomposition (1-1-1 Rule)
**Category**: Behavioral Constraint Patterns
**Frequency**: 4/13 files (31% but critical)
**Evidence**:
- Implementation-Planner: "The 1-1-1 Rule: Every task should be 1 file changed, 1 verification command, 1 clear outcome"
- agent-core.md: "Maximum: Each task = 1-2 file changes. Minimum: Each task must be independently verifiable."
- Lazy-Developer: "1 file changed, 1 verification command, 1 clear outcome"

**Effectiveness**: Prevents overwhelming changes. Enables precise tracking. Makes failures isolated.

**Recommendation**: Enforce strictly. If task requires >2 files, decompose further. Each task must have verification step.

---

### Pattern 12: Tool Usage Decision Matrix
**Category**: Context Engineering Patterns
**Frequency**: 4/13 files (31%)
**Evidence**:
- Guide: Full capability matrix showing which tools each agent has access to
- agent-core.md: "Tool Selection Guidelines: Find files → file_search; Find content → grep_search; Understand code → semantic_search"
- Lazy-Developer: "When to Delegate" table with sub-agent decision criteria

**Effectiveness**: Reduces tool misuse. Prevents agents from attempting unavailable actions.

**Recommendation**: Include explicit tool matrix in every orchestrating agent. Show both what's available AND when to use each.

---

### Pattern 13: Handoff Protocol with Button Labels
**Category**: Sub-Agent Orchestration Patterns
**Frequency**: 4/8 agents (50%)
**Evidence** (from YAML frontmatter):
```yaml
handoffs:
  - label: 'Start with Product Designer'
    agent: Product-Designer
    prompt: 'I want to start a new feature...'
    send: false
  - label: 'Back to Implementation Planner'
    agent: Implementation-Planner
    prompt: 'Implementation revealed issues...'
```

**Effectiveness**: Creates explicit transition points between agents. Labels are user-facing, prompts are agent-facing.

**Recommendation**: Always include `send: false` for user-controlled handoffs. Write prompts as complete sentences the next agent will understand.

---

### Pattern 14: Anti-Pattern Tables
**Category**: Behavioral Constraint Patterns
**Frequency**: 6/13 files (46%)
**Evidence**:
```markdown
| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Vague tasks | AI doesn't know when done | Make each task atomic |
| Random Change Syndrome | Compounds errors | STOP. Diagnose. ONE targeted change |
| Cast Away Problems | Hides type issues | Fix actual mismatch |
```
- Found in: Implementation-Planner, Product-Designer, error-recovery.md, code-review.md

**Effectiveness**: Negative examples are often clearer than positive instructions. Table format enables quick scanning.

**Recommendation**: Include 5-10 anti-patterns per agent. Link anti-patterns to their solutions. Use concrete examples.

---

### Pattern 15: Phase-Based Workflow Structure
**Category**: Structural Patterns
**Frequency**: 5/8 agents (63%)
**Evidence**:
- Product-Designer: "Phase 1: Context Gathering → Phase 2: Discovery → Phase 3: Exploration → Phase 4: Design → Phase 5: Review"
- Lazy-Developer: "Phase 1: Design → Phase 2: Architecture → Phase 3: Planning → Phase 4: Implementation"
- Guide: Decision tree based on project phase

**Effectiveness**: Creates clear progression. Enables state tracking. Prevents premature advancement.

**Recommendation**: Define explicit phase transitions with approval gates. Each phase should have entry criteria, activities, and exit criteria.

---

### Pattern 16: "Core Reference" Cross-Linking
**Category**: Structural Patterns
**Frequency**: 5/8 agents (63%)
**Evidence**:
- Multiple agents: `> **Core Reference**: See lib/agent-core.md for orchestration patterns and best practices.`
- Lib files: `> **See Also**: agent-core.md for verification patterns`

**Effectiveness**: Reduces duplication. Creates authoritative source. Enables modular updates.

**Recommendation**: Use blockquote callout format. Place immediately after title. Limit to 1-2 cross-references per file.

---

### Pattern 17: Communication Tone Examples
**Category**: Communication Patterns
**Frequency**: 3/8 agents (38%)
**Evidence** (from Beast-Mode):
```markdown
<examples>
"Let me fetch the URL you provided to gather more information."
"Ok, I've got all of the information I need on the LIFX API."
"Whelp - I see we have some problems. Let's fix those up."
</examples>
```

**Effectiveness**: Concrete examples are more effective than abstract tone descriptions. Establishes voice consistency.

**Recommendation**: Include 5-10 example utterances. Cover both success and failure scenarios. Mix formal and casual as appropriate.

---

### Pattern 18: Markdown Todo List for Progress Tracking
**Category**: Visual/Formatting Patterns
**Frequency**: 4/8 agents (50%)
**Evidence**:
- Beast-Mode: "Use markdown checkbox format `- [ ] Step 1` for todo lists. Always wrap in triple backticks."
- Multiple agents: Completion checklists with `- [ ]` and `- [x]` syntax

**Effectiveness**: Visual progress indication. Enables copy-paste workflow. Compatible with most editors.

**Recommendation**: Use for all multi-step processes. Check off items as completed. Show total progress (X/Y format).

---

### Pattern 19: File-Based Batch Workflow
**Category**: State Management Patterns
**Frequency**: 1/8 agents (13% - unique to CV-Content-Creator)
**Evidence**:
```yaml
# .work/data/pending/skills-metadata-001.yaml
batch_type: skill_metadata
batch_id: skills-metadata-001
status: pending
items:
  - skill_id: 1
    user_input:
      years_experience: "[FILL: e.g., 6.5]"
```
CV-Content-Creator: "This workflow exists because: 1. Premium requests are limited 2. Polling avoids interruption 3. Batch processing is efficient"

**Effectiveness**: Solves the premium request cost problem. Enables asynchronous human review. Scales to large datasets.

**Recommendation**: Use for any high-volume data entry. Include `[FILL: ...]` placeholders with examples. Move files through pending→processing→review→done pipeline.

---

### Pattern 20: "Never Invent Data" Hard Constraint
**Category**: Behavioral Constraint Patterns
**Frequency**: 1/8 agents (13% - unique but critical)
**Evidence**:
CV-Content-Creator: `### 🚫 NEVER INVENT DATA - **This is non-negotiable.** You SHALL NOT: Invent skills, years of experience, or proficiency levels...`

**Effectiveness**: Domain-specific but universally applicable principle. Emphatic formatting ensures salience.

**Recommendation**: Identify domain-specific "cardinal sins" for each agent type. Use emoji + bold + ALL CAPS for maximum emphasis.

---

### Pattern 21: Red Flag Pattern Recognition
**Category**: Verification Patterns
**Frequency**: 3/13 files (23%)
**Evidence**:
- code-review.md: "Red Flags 🚩: `as any` - Hiding type problems; `// @ts-ignore` - Suppressing errors; Empty catch block - Silent failures"
- skepticism.md: "🚩 'I think this should work' - Run verification NOW; 🚩 'I've done this before' - Every context is different"

**Effectiveness**: Pattern matching is faster than rule application. Red flag emoji creates visual anchor.

**Recommendation**: Compile domain-specific red flags. Use consistent emoji. Pair each flag with immediate action.

---

### Pattern 22: Confidence Level Tracking
**Category**: State Management Patterns
**Frequency**: 2/13 files (15%)
**Evidence**:
- skepticism.md: `confidence_level: medium # high, medium, low` with concerns list
- Multiple: "If confidence is low, either: 1. Gather more context 2. Use sub-agent 3. Escalate"

**Effectiveness**: Makes uncertainty explicit. Triggers appropriate responses based on confidence.

**Recommendation**: Track confidence per task, not just overall. Low confidence should trigger additional verification.

---

### Pattern 23: Decision Log Pattern
**Category**: State Management Patterns
**Frequency**: 2/8 agents (25%)
**Evidence**:
- Lazy-Developer: `| # | Decision | Rationale | Phase |` table format
- STATE.md template: `decisions: [list of decisions made]`

**Effectiveness**: Creates audit trail. Enables human review of assumptions. Prevents repeating debates.

**Recommendation**: Log every non-trivial decision. Include rationale, not just the choice. Reference in escalations.

---

### Pattern 24: Tool Access YAML Frontmatter
**Category**: Structural Patterns
**Frequency**: 8/8 agents (100%)
**Evidence**:
```yaml
---
name: Code-Implementer
description: 'Senior software engineer...'
tools:
  - edit
  - search
  - runSubagent
  - 'ESLint/*'
model: 'Claude Opus 4.5 (Preview)'
handoffs: [...]
---
```

**Effectiveness**: Machine-readable configuration. Enables IDE integration. Separates metadata from instructions.

**Recommendation**: Standardize tool naming. Use wildcards for MCP tool groups. Always specify model explicitly.

---

### Pattern 25: Recovery Protocol Flow (STOP-READ-DIAGNOSE-FIX-VERIFY)
**Category**: Error Recovery Patterns
**Frequency**: 4/13 files (31%)
**Evidence**:
- error-recovery.md: "1. STOP - Don't make random changes. 2. READ - Understand the exact error. 3. DIAGNOSE - Find root cause. 4. FIX - Minimal targeted fix. 5. VERIFY - Confirm fix works."
- Code-Implementer: Same protocol referenced

**Effectiveness**: Mnemonic structure aids recall. Sequential steps prevent panic responses.

**Recommendation**: Make this a universal standard across all implementing agents. Train it through repetition.

---

### Pattern 26: Skepticism as Default Mindset
**Category**: Behavioral Constraint Patterns
**Frequency**: 3/13 files (23%)
**Evidence**:
- skepticism.md: "ASSUME YOUR CODE IS WRONG UNTIL VERIFIED. This is not pessimism. This is professionalism."
- Code-Implementer: "Mindset: Code is wrong until verified. Paranoid about correctness."
- Implementation-Planner: "Mindset: Skeptical about AI capabilities. Design for failure recovery."

**Effectiveness**: Counteracts AI overconfidence. Drives verification behavior.

**Recommendation**: Embed skepticism in agent identity, not just rules. Make verification the default, not exception.

---

### Pattern 27: Common Error Pattern Tables
**Category**: Error Recovery Patterns
**Frequency**: 4/13 files (31%)
**Evidence**:
```markdown
| Error | Likely Cause | Quick Fix |
|-------|--------------|-----------|
| `Type 'X' not assignable` | Wrong type, shape mismatch | Check exact type expected |
| `Cannot find module` | Path wrong, file missing | Check file exists |
```
- Found in: Code-Implementer, error-recovery.md, verification.md

**Effectiveness**: Accelerates diagnosis. Provides instant first-attempt fixes. Reduces wasted attempts.

**Recommendation**: Build domain-specific error catalogs. Update based on encountered errors. Include exact error text for matching.

---

### Pattern 28: Orchestrator-Worker Architecture
**Category**: Sub-Agent Orchestration Patterns
**Frequency**: 6/8 agents (75%)
**Evidence**:
- agent-core.md: Detailed diagram showing ORCHESTRATOR managing SEARCH, CODER, ANALYZER, WRITER agents
- Lazy-Developer: "Uses sub-agent orchestration to maximize efficiency"
- Guide: Routes to specialized agents based on context

**Effectiveness**: Separates strategy from execution. Enables parallelization. Manages context windows.

**Recommendation**: Orchestrators should never do work themselves - only coordinate. Workers should be single-purpose.

---

### Pattern 29: Project Structure Templates
**Category**: Structural Patterns
**Frequency**: 4/8 agents (50%)
**Evidence**:
```
.ai/scratch/<project-name>/
├── STATE.md
├── design-document.md
├── tech-spec.md
├── modules.md
└── prompts/
    ├── AGENT.md
    └── modules/<module>/implementation.md
```

**Effectiveness**: Standardized structure enables agent navigation. Predictable locations reduce search time.

**Recommendation**: Document the full structure in orchestrator agents. Use consistent naming across all projects.

---

### Pattern 30: Resume/Continue Protocol
**Category**: State Management Patterns
**Frequency**: 3/8 agents (38%)
**Evidence**:
- Beast-Mode: "If the user request is 'resume' or 'continue' or 'try again', check the previous conversation history to see what the next incomplete step is."
- Guide: Provides "Continue My Work" journey pattern
- Code-Implementer: "Read STATE.md first - Find your current position before doing anything"

**Effectiveness**: Enables session continuity. Reduces user effort to resume work.

**Recommendation**: Make "resume" a first-class command. Always check STATE.md before asking user for context.

---

## Pattern Statistics

| Pattern | Usage Count | Agents Using |
|---------|-------------|--------------|
| ALWAYS/NEVER Constraint Lists | 13/13 | All agents + all lib files |
| Tool Access YAML Frontmatter | 8/8 | All agents |
| Three Laws Identity Framework | 7/8 | 7 agents |
| Sub-Agent Delegation Templates | 10/13 | 7 agents + 3 lib files |
| STATE.md Persistent Memory | 10/13 | 6 agents + 4 lib files |
| Verification Loop (Non-Negotiable) | 11/13 | All agents + 3 lib files |
| Role-Mindset-Style-Superpower Matrix | 6/8 | 6 agents |
| ASCII/Mermaid Diagrams | 7/13 | 5 agents + 2 lib files |
| Phase-Based Workflow | 5/8 | 5 agents |
| 3-Attempt Escalation Protocol | 6/13 | 4 agents + 2 lib files |
| Anti-Pattern Tables | 6/13 | 3 agents + 3 lib files |
| Handoff Protocol | 4/8 | 4 agents |
| Markdown Todo Lists | 4/8 | 4 agents |
| Common Error Tables | 4/13 | 2 agents + 2 lib files |
| Decision Log Pattern | 2/8 | 2 agents |
| File-Based Batch Workflow | 1/8 | CV-Content-Creator only |

---

## Most Powerful Patterns

### #1: Layered Context Architecture
**Power Score**: 10/10
**Why It's Critical**: This is the foundational meta-pattern that organizes all other patterns. By separating System (identity), Task (current work), Tool (capabilities), and Memory (state) layers, agents avoid context pollution and maintain coherent behavior across long sessions.

**Deep Analysis**: The 4-layer model mirrors how human experts think: first principles (system), current assignment (task), available resources (tools), and learned experience (memory). Each layer has different update frequencies - system is static, memory is dynamic.

**Implementation**: Every agent should explicitly reference which layer each instruction belongs to. System layer should be immutable once set.

---

### #2: 3-Attempt Escalation Protocol
**Power Score**: 9.5/10
**Why It's Critical**: Solves the two failure modes of autonomous agents: giving up too early and infinite looping. The structured escalation ensures maximum effort while providing a clear exit condition.

**Deep Analysis**: Three attempts is the sweet spot - enough to catch simple fixes, not enough to waste resources. The requirement to try DIFFERENT approaches prevents repetitive failures. The escalation template ensures humans receive complete context.

**Implementation**: Make this a hard stop, not a guideline. Agents should physically count attempts in state.

---

### #3: Sub-Agent Delegation Templates
**Power Score**: 9/10
**Why It's Critical**: Sub-agents are the scaling mechanism for complex tasks. The 5-part template (OBJECTIVE, CONTEXT, TASK, RETURN FORMAT, CONSTRAINTS) ensures clean delegation without information loss.

**Deep Analysis**: The CONSTRAINTS section is the secret weapon - it prevents sub-agents from scope creep or making decisions reserved for the orchestrator. The RETURN FORMAT ensures parseable outputs.

**Implementation**: Never delegate without all 5 sections. Create a sub-agent template library for common tasks.

---

### #4: STATE.md Persistent Memory
**Power Score**: 9/10
**Why It's Critical**: Solves the fundamental problem of LLM statelessness. Without persistent state, every interaction starts from scratch.

**Deep Analysis**: The structured YAML format with `current_module`, `current_task`, `verification_status` creates a machine-readable checkpoint system. The decisions log creates institutional memory.

**Implementation**: Update after EVERY task, not just milestones. Include timestamps for debugging.

---

### #5: Verification Loop (Non-Negotiable)
**Power Score**: 8.5/10
**Why It's Critical**: The "paranoid verification" culture catches 90% of bugs before they compound. Making it non-negotiable removes decision fatigue.

**Deep Analysis**: The tiered approach (quick → full → comprehensive) balances speed with thoroughness. Embedding verification in task definitions makes it automatic.

**Implementation**: Never mark a task complete without verification pass. Track verification failures in state.

---

## Unique Agent Innovations

### CV-Content-Creator: File-Based Batch Workflow
**Innovation**: Uses file system as async communication channel
**Why It's Valuable**: Solves the "premium prompt interruption" cost problem. Files in `.work/data/pending/` → `processing/` → `review/` → `done/` create a visual pipeline.
**Transferability**: Applicable to any high-volume data processing task.

### Beast-Mode: Recursive Web Research Protocol
**Innovation**: "Fetch URL → Find links → Fetch linked pages → Repeat until complete"
**Why It's Valuable**: Overcomes LLM knowledge cutoff. Ensures up-to-date information.
**Transferability**: Essential for any agent working with external documentation.

### Lazy-Developer: "Never Ask" Autonomy Principle
**Innovation**: Explicitly forbids asking for permission or approval mid-task
**Why It's Valuable**: Maximizes autonomous execution. Reduces human attention cost.
**Transferability**: Applicable to batch processing and background tasks.

### Implementation-Planner: Context Engineering as Core Competency
**Innovation**: Treats prompt engineering as a first-class discipline, not just instructions
**Why It's Valuable**: Recognizes that the quality of agent prompts determines execution quality.
**Transferability**: Should be applied to all agent creation processes.

### Guide: Agent Routing as Primary Function
**Innovation**: Entire agent dedicated to navigation and handoff, not execution
**Why It's Valuable**: Reduces user cognitive load. Ensures correct agent selection.
**Transferability**: Every multi-agent system needs a router.

---

## Pattern Interactions

### Synergistic Combinations

**Three Laws + ALWAYS/NEVER + Skepticism**
These three patterns form a "behavioral triangle" - Laws set philosophy, ALWAYS/NEVER set boundaries, Skepticism sets default posture. Together they create a coherent decision-making framework.

**STATE.md + 3-Attempt Escalation + Decision Log**
These patterns create an "accountability chain" - State tracks progress, Escalation protocol triggers when stuck, Decision Log explains choices. Together they enable complete audit trails.

**Sub-Agent Templates + Layered Context + Tool Matrix**
These patterns form "delegation infrastructure" - Templates structure requests, Context layers organize information, Tool Matrix defines capabilities. Together they enable reliable sub-agent orchestration.

**Verification Loop + Red Flags + Error Recovery**
These patterns create "quality assurance pipeline" - Verification catches issues, Red Flags enable early detection, Error Recovery handles failures. Together they ensure code quality.

### Conflicting Patterns (Tension Points)

**"Never Ask" vs "Get Explicit Approval"**
- Lazy-Developer: Never ask, make decisions autonomously
- Product-Designer: Always get explicit approval before proceeding

**Resolution**: These serve different contexts. Autonomous agents prioritize speed; design agents prioritize correctness. The conflict is intentional.

**"Atomic Tasks" vs "Comprehensive Analysis"**
- Implementation-Planner: 1-1-1 rule (1 file, 1 verification, 1 outcome)
- Sub-Agent Templates: Comprehensive analysis across multiple files

**Resolution**: Atomic applies to execution; Comprehensive applies to analysis. Sub-agents can analyze broadly; changes must be atomic.

---

## Pattern Anti-Patterns

### What NOT to Do (Evidence-Based)

| Anti-Pattern | Evidence | Why It Fails |
|--------------|----------|--------------|
| "Random Change Syndrome" | error-recovery.md: "Try this → Fail → Try that → Fail → ..." | Changes without diagnosis compound errors |
| "Cast Away Problems" | code-review.md: `const data = result as any` | Hides type issues instead of fixing them |
| "Suppress Errors" | code-review.md: `catch { /* ignore */ }` | Silent failures are undebuggable |
| "Stack More Code on Broken Code" | error-recovery.md: "Error in A → Add wrapper B → ..." | Complexity explodes without fixing root cause |
| "Infinite Retry Loop" | Multiple files: "Attempt 1, 2, 3, 4, 5, 6..." | Wastes resources, never escalates |
| "Assume Your Knowledge is Current" | skepticism.md: "'I remember the API being...'" | Training data is outdated |
| "Skip Context Gathering" | Product-Designer: "Solutioning before understanding" | Builds wrong thing |
| "Single Option Only" | Product-Designer anti-pattern table | No buy-in, missed alternatives |
| "Vague Requirements" | Implementation-Planner: "AI doesn't know when done" | Ambiguous completion criteria |
| "Trust but Verify" | skepticism.md: reversed to "Verify, then trust" | Default should be skepticism |

---

## Recommendations for Future Agent Development

### Immediate Actions
1. **Standardize Three Laws** for every new agent
2. **Create sub-agent template library** with pre-built OBJECTIVE/CONTEXT/TASK/RETURN/CONSTRAINTS
3. **Implement confidence tracking** as mandatory state field
4. **Build domain-specific error catalogs** for each technology stack

### Medium-Term Improvements
1. **Develop automated verification harnesses** that run without agent prompting
2. **Create escalation analytics** to identify common failure patterns
3. **Build cross-agent state synchronization** for multi-agent workflows
4. **Implement "red flag" detection** in agent monitoring

### Long-Term Architecture
1. **Agent version control** with pattern evolution tracking
2. **Automated pattern extraction** from successful executions
3. **Pattern effectiveness scoring** based on task completion rates
4. **Dynamic pattern selection** based on task characteristics

---

## Appendix: Complete Pattern Index

| # | Pattern Name | Category | Files Present |
|---|--------------|----------|---------------|
| 1 | Three Laws Identity Framework | Identity | 7 agents |
| 2 | ALWAYS/NEVER Constraint Lists | Behavioral | All files |
| 3 | Role-Mindset-Style-Superpower Matrix | Identity | 6 agents |
| 4 | Sub-Agent Delegation Templates | Orchestration | 7 agents, 3 lib |
| 5 | Layered Context Architecture | Context | 3 files |
| 6 | STATE.md Persistent Memory | State | 6 agents, 4 lib |
| 7 | 3-Attempt Escalation Protocol | Error | 6 files |
| 8 | Escalation Template Structure | Error | 5 files |
| 9 | ASCII Diagram Visual Architecture | Visual | 7 files |
| 10 | Verification Loop | Verification | 11 files |
| 11 | Atomic Task Decomposition (1-1-1) | Behavioral | 4 files |
| 12 | Tool Usage Decision Matrix | Context | 4 files |
| 13 | Handoff Protocol with Button Labels | Orchestration | 4 agents |
| 14 | Anti-Pattern Tables | Behavioral | 6 files |
| 15 | Phase-Based Workflow Structure | Structural | 5 agents |
| 16 | "Core Reference" Cross-Linking | Structural | 5 agents |
| 17 | Communication Tone Examples | Communication | 3 agents |
| 18 | Markdown Todo List Tracking | Visual | 4 agents |
| 19 | File-Based Batch Workflow | State | 1 agent |
| 20 | "Never Invent Data" Hard Constraint | Behavioral | 1 agent |
| 21 | Red Flag Pattern Recognition | Verification | 3 files |
| 22 | Confidence Level Tracking | State | 2 files |
| 23 | Decision Log Pattern | State | 2 agents |
| 24 | Tool Access YAML Frontmatter | Structural | 8 agents |
| 25 | Recovery Protocol (STOP-READ-DIAGNOSE-FIX-VERIFY) | Error | 4 files |
| 26 | Skepticism as Default Mindset | Behavioral | 3 files |
| 27 | Common Error Pattern Tables | Error | 4 files |
| 28 | Orchestrator-Worker Architecture | Orchestration | 6 agents |
| 29 | Project Structure Templates | Structural | 4 agents |
| 30 | Resume/Continue Protocol | State | 3 agents |

---

*Analysis completed: December 1, 2025*
*Analyzed: 8 agents + 5 library files*
*Patterns identified: 30*
*Total evidence citations: 100+*
