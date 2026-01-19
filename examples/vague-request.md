# Example: Vague Feature Request

This example shows how the agent system handles a vague, high-level request.

## User Prompt

```markdown
Add user authentication to my app
```

## What Happens

### 1. Orchestrator Interprets

The Orchestrator:
1. Creates `.ai/scratch/2026-01-19_user-auth/`
2. Parses intent: authentication feature needed
3. Identifies unknowns: tech stack? existing patterns? requirements?

### 2. Researcher Investigates

Dispatched with:
```markdown
## To: @researcher
## Objective
Analyze existing codebase for authentication patterns and requirements.

## Output
- .ai/scratch/.../02_analysis/auth_patterns.md
- .ai/scratch/.../02_analysis/existing_users.md
```

Researcher discovers:
- Express.js backend
- PostgreSQL with existing users table
- No current auth implementation
- JWT would fit the stack

### 3. Designer Creates Spec

Dispatched with findings:
```markdown
## To: @designer
## Objective
Design authentication system for Express.js + PostgreSQL

## Context
- 02_analysis/auth_patterns.md
- 02_analysis/existing_users.md

## Output
- 03_design/auth_architecture.md
- 03_design/_approval.md
```

Designer produces:
- JWT-based authentication
- Login/logout endpoints
- Middleware for protected routes
- Password hashing strategy

### 4. Implementer Executes

After design approval:
```markdown
## To: @implementer
## Objective
Implement JWT authentication per design spec

## Design
- 03_design/auth_architecture.md

## Constraints
- Follow existing Express patterns
- Use bcrypt for password hashing
```

### 5. Verification & Handoff

Orchestrator verifies:
- [ ] Tests pass
- [ ] No errors
- [ ] Endpoints work

Creates `_handoff.md` with summary.

## Key Takeaway

A simple 5-word prompt triggers:
- Codebase analysis
- Architecture design
- Implementation plan
- Verified execution

The agent system fills in the gaps autonomously.
