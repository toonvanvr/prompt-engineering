# HumanLayer Integration Lessons

Lessons learned from analyzing HumanLayer repository and integrating patterns into prompt-engineering framework.

---

## Key Patterns Adopted

### 1. TODO Priority Annotations — TODO(0-4)

**Source:** HumanLayer `CLAUDE.md`

**Pattern:**
```
TODO(0) — Drop everything, fix now
TODO(1) — Do before current task ends
TODO(2) — Do before current phase ends
TODO(3) — Do before project ends
TODO(4) — Nice to have, no deadline
```

**Why Adopted:**
- Zero implementation cost
- Immediate clarity in task prioritization
- Self-documenting urgency levels
- Compatible with existing TODO usage

**Location:** `agents/kernel/todo-conventions.md`

---

### 2. AGENTS.md Per-Component Guidance

**Source:** HumanLayer has CLAUDE.md at multiple levels (`/CLAUDE.md`, `hld/CLAUDE.md`)

**Pattern:**
- Root AGENTS.md for project-wide guidance
- Component AGENTS.md for specific subsystems
- Contains AI-specific instructions, not human docs

**Why Adopted:**
- Distributes AI guidance to relevant contexts
- Reduces context window usage (only relevant guidance loaded)
- Consistent with Claude Code's discovery mechanism
- Allows specialized instructions per component

**Locations Created:**
- `/AGENTS.md` — Root project guidance
- `/agents/AGENTS.md` — Agent system guidance
- `/agents/kernel/AGENTS.md` — Kernel rules guidance
- `/.ai/AGENTS.md` — Working space guidance

---

### 3. Tool Stakes Framework

**Source:** HumanLayer `humanlayer.md` (require_approval patterns)

**Pattern:**
- LOW stakes: Proceed without confirmation
- MEDIUM stakes: Verify understanding, proceed
- HIGH stakes: Explicit approval required

**Why Adopted:**
- Fills gap in current risk classification
- Natural extension of existing human-loop
- Enables pre-approval for high-risk operations
- Consistent with HumanLayer's core philosophy

**Location:** `agents/kernel/tool-stakes.md`

---

### 4. Approval Request Pattern

**Source:** HumanLayer approval workflows

**Pattern:**
- Structured template for requesting approval
- Contains: action, stakes level, justification, reversibility
- Clear YES/NO decision point

**Why Adopted:**
- Formalizes existing implicit approval patterns
- Provides consistent format for high-stakes decisions
- Enables audit trail for major changes

**Location:** `agents/templates/approval-request.md`

---

### 5. Commands Cheat Sheet

**Source:** HumanLayer structured command documentation

**Pattern:**
- Quick-reference table of available commands
- Organized by workflow phase
- Includes dependencies and outputs

**Why Adopted:**
- Reduces cognitive load during orchestration
- Provides at-a-glance workflow reference
- Complements existing mode documentation

**Location:** Added to `agents/source/orchestrator.src.md`

---

## Patterns NOT Adopted (With Rationale)

### 1. Runtime SDK Integration

**Source:** HumanLayer TypeScript/Python SDKs

**Why Skipped:**
- Prompt-engineering is prompt-time, not runtime
- Would require code dependencies
- Out of scope for behavioral control system
- Future consideration only

---

### 2. Daemon Architecture

**Source:** HumanLayer `hld/` daemon system

**Why Skipped:**
- Requires persistent process management
- Overkill for prompt-based workflows
- File-based approach is simpler and git-friendly
- Would fundamentally change system architecture

---

### 3. Database Persistence

**Source:** HumanLayer uses PostgreSQL for state

**Why Skipped:**
- Conflicts with file-based philosophy
- Git already provides versioning
- Would require infrastructure setup
- Human-readable files preferred

---

### 4. Multi-Channel Contact Routing

**Source:** HumanLayer `hlyr/config.md` (Slack, email, etc.)

**Why Skipped:**
- Runtime feature requiring integrations
- Current file-based human-loop sufficient
- Documented as future aspiration only
- Would require external service dependencies

---

### 5. Session Tracking with IDs

**Source:** HumanLayer session management

**Why Skipped:**
- Existing handoff pattern provides sufficient audit trail
- Would add complexity without clear benefit
- Phase-based tracking already exists
- File naming provides implicit session identity

---

## Future Consideration Items

|Item|HumanLayer Feature|Potential Value|Complexity|
|-|-|-|-|
|Multi-channel|Slack/email routing|Real-time notifications|HIGH|
|Contact matching|Role-based routing|Right person for approval|MEDIUM|
|Session persistence|Database-backed state|Cross-session continuity|HIGH|
|Approval audit log|Structured approval history|Compliance/review|MEDIUM|

---

## Key Learnings

### System Complementarity

HumanLayer and prompt-engineering address different phases:
- **HumanLayer:** Runtime tool execution control
- **Prompt-engineering:** Prompt-time behavioral control

Systems are complementary, not competing. Integration focused on conceptual adoption, not runtime integration.

### Additive Integration Success

All integration was additive:
- 7 new files created
- 7 files modified (append-only)
- 0 files deleted
- 0 breaking changes

This approach enabled:
- Safe rollback via git
- No regression risk
- Incremental verification
- Clear change tracking

### Pattern Over Implementation

Adopted the *patterns* from HumanLayer, not the *implementation*:
- Stakes concept → file-based classification
- Approval workflow → template-based requests
- AGENTS.md → AI guidance distribution
- TODO priorities → annotation convention

This preserved the file-based, prompt-time nature of prompt-engineering.
