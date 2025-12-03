# GitHub Copilot Custom Agents & Instructions Specification

> Complete reference for GitHub Copilot customization mechanisms across all supported environments.
> 
> **Last Updated**: December 2025  
> **Sources**: GitHub Docs, VS Code Docs, openai/agents.md

---

## Table of Contents

1. [Overview](#overview)
2. [File Types & Extensions](#file-types--extensions)
3. [File Locations](#file-locations)
4. [Frontmatter Formats](#frontmatter-formats)
5. [Instruction Types](#instruction-types)
6. [Custom Agents](#custom-agents)
7. [Prompt Files](#prompt-files)
8. [Agent Mode vs Chat Mode](#agent-mode-vs-chat-mode)
9. [Variable & Template Support](#variable--template-support)
10. [Tool References](#tool-references)
11. [Glob Pattern Syntax](#glob-pattern-syntax)
12. [Environment-Specific Features](#environment-specific-features)
13. [Priority & Precedence](#priority--precedence)
14. [Limitations & Constraints](#limitations--constraints)
15. [Best Practices](#best-practices)

---

## Overview

GitHub Copilot supports multiple customization mechanisms:

| Mechanism | Purpose | Scope | Auto-Apply |
|-|-|-|-|
| `copilot-instructions.md` | Repository-wide guidelines | All requests | Yes |
| `*.instructions.md` | Path-specific instructions | Matched files | Yes |
| `AGENTS.md` / `CLAUDE.md` / `GEMINI.md` | Agent-specific instructions | All agents | Yes |
| `*.agent.md` | Custom agent definitions | When selected | Yes |
| `*.prompt.md` | Reusable prompt templates | On-demand | No |
| Settings-based | Task-specific instructions | Per-feature | Yes |

---

## File Types & Extensions

### Instruction Files

| Extension | Purpose | Location |
|-|-|-|
| `copilot-instructions.md` | Repository-wide custom instructions | `.github/` |
| `*.instructions.md` | Path-specific instructions | `.github/instructions/` |
| `global-copilot-instructions.md` | User-global instructions (JetBrains) | OS-specific |

### Agent Files

| Extension | Purpose | Location |
|-|-|-|
| `*.agent.md` | Custom agent definitions | `.github/agents/` or user profile |
| `AGENTS.md` | Agent instructions (OpenAI format) | Repository root or subfolders |
| `CLAUDE.md` | Claude-specific instructions | Repository root |
| `GEMINI.md` | Gemini-specific instructions | Repository root |
| `*.chatmode.md` | Legacy chat mode files (deprecated) | `.github/chatmodes/` |

### Prompt Files

| Extension | Purpose | Location |
|-|-|-|
| `*.prompt.md` | Reusable prompt templates | `.github/prompts/` |

---

## File Locations

### Repository Locations

```
repository/
├── .github/
│   ├── copilot-instructions.md      # Repository-wide (all environments)
│   ├── instructions/
│   │   └── *.instructions.md        # Path-specific
│   ├── agents/
│   │   └── *.agent.md               # Custom agents (VS Code)
│   └── prompts/
│       └── *.prompt.md              # Prompt files
├── AGENTS.md                         # Agent instructions (root)
├── CLAUDE.md                         # Claude-specific (root)
├── GEMINI.md                         # Gemini-specific (root)
└── subdirectory/
    └── AGENTS.md                     # Subfolder agent instructions (experimental)
```

### User Profile Locations

#### VS Code

- **User agents**: Stored in current VS Code profile folder
- **User prompts**: Stored in current VS Code profile folder
- **User instructions**: Stored in current VS Code profile folder

#### JetBrains

| OS | Global Instructions Path |
|-|-|
| macOS | `/Users/YOUR-USERNAME/.config/github-copilot/intellij/global-copilot-instructions.md` |
| Windows | `C:\Users\YOUR-USERNAME\AppData\Local\github-copilot\intellij\global-copilot-instructions.md` |

---

## Frontmatter Formats

### Instructions Files (`*.instructions.md`)

```yaml
---
description: Short description of the instructions
name: Display name (optional, defaults to filename)
applyTo: "**/*.py"                    # Glob pattern for auto-apply
excludeAgent: "code-review"           # Optional: "code-review" or "coding-agent"
---
```

| Field | Type | Required | Description |
|-|-|-|-|
| `description` | string | No | UI description |
| `name` | string | No | Display name |
| `applyTo` | string | No | Glob pattern (comma-separated for multiple) |
| `excludeAgent` | string | No | Exclude from specific agent type |

### Custom Agent Files (`*.agent.md`)

```yaml
---
name: Agent Name
description: Brief description shown in chat input
argument-hint: Hint text for user input
tools: ['edit', 'search', 'fetch', 'runSubagent']
model: Claude Sonnet 4
target: vscode                        # or github-copilot
mcp-servers: []                       # For github-copilot target
handoffs:
  - label: Start Implementation
    agent: implementation
    prompt: Implement the plan above.
    send: false
---
```

| Field | Type | Required | Description |
|-|-|-|-|
| `name` | string | No | Display name (defaults to filename) |
| `description` | string | No | Placeholder text in chat input |
| `argument-hint` | string | No | Guidance for user interaction |
| `tools` | array | No | Available tool/tool-set names |
| `model` | string | No | AI model to use |
| `target` | string | No | `vscode` or `github-copilot` |
| `mcp-servers` | array | No | MCP server configs (for github-copilot) |
| `handoffs` | array | No | Workflow transitions |
| `handoffs.label` | string | Yes* | Button text |
| `handoffs.agent` | string | Yes* | Target agent ID |
| `handoffs.prompt` | string | No | Pre-filled prompt |
| `handoffs.send` | boolean | No | Auto-submit (default: false) |

### Prompt Files (`*.prompt.md`)

```yaml
---
name: Prompt Name
description: Short description
argument-hint: Hint for user input
agent: agent                          # ask, edit, agent, or custom agent name
model: GPT-4o
tools: ['search', 'fetch']
---
```

| Field | Type | Required | Description |
|-|-|-|-|
| `name` | string | No | Name shown after `/` |
| `description` | string | No | UI description |
| `argument-hint` | string | No | Input guidance |
| `agent` | string | No | Agent to use: `ask`, `edit`, `agent`, or custom name |
| `model` | string | No | Override language model |
| `tools` | array | No | Available tools |

---

## Instruction Types

### 1. Repository-Wide Instructions

**File**: `.github/copilot-instructions.md`

- Applies to ALL chat requests in repository context
- Automatically included when repository attached
- Format: Plain Markdown, no frontmatter required
- Whitespace between instructions ignored

**Example**:
```markdown
# Copilot Instructions

## Code Style
- Use TypeScript for all new files
- Follow ESLint configuration
- Prefer functional components in React

## Testing
- Write Jest tests for all new functions
- Aim for 80% code coverage
```

### 2. Path-Specific Instructions

**Files**: `.github/instructions/*.instructions.md`

- Apply to files matching glob patterns
- Combined with repository-wide instructions
- Requires `applyTo` frontmatter

**Example**:
```yaml
---
applyTo: "src/api/**/*.ts"
---
# API Guidelines

- Use Zod for request validation
- Return consistent error responses
- Document all endpoints with JSDoc
```

### 3. Agent Instructions (AGENTS.md)

**Files**: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`

- OpenAI format for multi-agent compatibility
- Root file applies to all, subfolder files take precedence
- Plain Markdown, no frontmatter
- Supported by GitHub Copilot, Claude, Gemini, and other agents

**Example**:
```markdown
# AGENTS.md

## Build Instructions
- Run `pnpm install` before any operations
- Use `pnpm test` to run all tests
- Check `.github/workflows/` for CI configuration

## Code Standards
- Follow existing patterns in codebase
- Add tests for all new functionality
```

### 4. Settings-Based Instructions

| Setting | Purpose |
|-|-|
| `github.copilot.chat.reviewSelection.instructions` | Code review |
| `github.copilot.chat.commitMessageGeneration.instructions` | Commit messages |
| `github.copilot.chat.pullRequestDescriptionGeneration.instructions` | PR descriptions |
| `github.copilot.chat.codeGeneration.instructions` | Code generation (deprecated) |
| `github.copilot.chat.testGeneration.instructions` | Test generation (deprecated) |

**Format** (in `settings.json`):
```json
{
  "github.copilot.chat.reviewSelection.instructions": [
    { "text": "Focus on security vulnerabilities" },
    { "file": "guidance/review-guidelines.md" }
  ]
}
```

---

## Custom Agents

### Definition

Custom agents are specialized chat personas with:
- Custom instructions (body)
- Tool restrictions (frontmatter)
- Model selection (frontmatter)
- Handoff workflows (frontmatter)

### File Structure

```markdown
---
name: Security Reviewer
description: Review code for security vulnerabilities
tools: ['search', 'usages', 'problems']
model: Claude Sonnet 4
handoffs:
  - label: Fix Issues
    agent: agent
    prompt: Fix the security issues identified above.
---
# Security Reviewer

You are a security-focused code reviewer. Your task is to:

1. Identify potential security vulnerabilities
2. Check for common attack vectors (XSS, SQL injection, etc.)
3. Review authentication and authorization logic
4. Suggest security improvements

## Guidelines
- Prioritize critical vulnerabilities
- Provide specific remediation steps
- Reference OWASP guidelines where applicable
```

### Built-in Agents (VS Code)

| Agent | Purpose |
|-|-|
| `Agent` | Autonomous coding with full tools |
| `Plan` | Generate implementation plans |
| `Ask` | Answer questions (read-only) |
| `Edit` | Make code changes |

### Tool References

Reference tools in body with `#tool:<tool-name>` syntax:
```markdown
Use #tool:search to find relevant code patterns.
Use #tool:githubRepo to search GitHub repositories.
```

### Handoffs

Create guided workflows between agents:
```yaml
handoffs:
  - label: Implement Plan
    agent: agent
    prompt: Implement the plan outlined above.
    send: false
```

---

## Prompt Files

### Purpose

Reusable prompt templates invoked via `/` commands.

### Usage

1. Type `/` in chat input
2. Select prompt from list
3. Optionally add arguments
4. Submit

### Example

```markdown
---
name: create-component
description: Create a React component
agent: agent
tools: ['edit', 'search']
---
# Create React Component

Create a new React component with the following requirements:

1. Use TypeScript
2. Include proper prop types
3. Add basic styling with CSS modules
4. Include a simple test file

Component name: ${input:componentName}
Location: ${input:location:src/components}
```

### Variable Support

| Variable | Description |
|-|-|
| `${workspaceFolder}` | Workspace root path |
| `${workspaceFolderBasename}` | Workspace folder name |
| `${selection}` | Current editor selection |
| `${selectedText}` | Selected text content |
| `${file}` | Current file path |
| `${fileBasename}` | Current filename |
| `${fileDirname}` | Current file directory |
| `${fileBasenameNoExtension}` | Filename without extension |
| `${input:varName}` | User input prompt |
| `${input:varName:placeholder}` | User input with placeholder |

---

## Agent Mode vs Chat Mode

### Agent Mode

- Autonomous operation
- Full tool access
- Makes code changes directly
- Runs terminal commands
- Creates/modifies files

### Chat Mode (Ask)

- Read-only operations
- Answers questions
- Provides explanations
- No file modifications

### Selection

VS Code agent picker options:
- **Agent**: Full autonomous capabilities
- **Plan**: Planning mode (read-only tools)
- **Ask**: Q&A mode
- **Edit**: Code editing focus
- **Custom agents**: User-defined

---

## Variable & Template Support

### File References

Reference other files using:
- Markdown links: `[filename](../path/to/file.ts)`
- Hash syntax: `#file:../path/to/file.ts`

Paths are relative to the instruction/prompt file.

### Tool References

Reference tools: `#tool:<tool-name>`

Examples:
- `#tool:search` - Workspace search
- `#tool:fetch` - Web fetch
- `#tool:githubRepo` - GitHub search
- `#tool:usages` - Find usages

---

## Glob Pattern Syntax

For `applyTo` patterns:

| Pattern | Matches |
|-|-|
| `*` | All files in current directory |
| `**` or `**/*` | All files recursively |
| `*.py` | `.py` files in current directory |
| `**/*.py` | All `.py` files recursively |
| `src/*.py` | `.py` files directly in `src/` |
| `src/**/*.py` | All `.py` files under `src/` |
| `**/subdir/**/*.py` | `.py` files in any `subdir/` at any depth |

Multiple patterns: Comma-separated
```yaml
applyTo: "**/*.ts,**/*.tsx"
```

---

## Environment-Specific Features

### VS Code

| Feature | Support |
|-|-|
| Repository instructions | ✅ |
| Path-specific instructions | ✅ |
| Custom agents (`.agent.md`) | ✅ |
| Prompt files (`.prompt.md`) | ✅ |
| AGENTS.md (root) | ✅ |
| AGENTS.md (subfolders) | ⚠️ Experimental |
| Handoffs | ✅ |
| MCP servers | ✅ |

Settings:
- `github.copilot.chat.codeGeneration.useInstructionFiles`: Enable instructions
- `chat.promptFiles`: Enable prompt files
- `chat.useAgentsMdFile`: Enable AGENTS.md support
- `chat.useNestedAgentsMdFiles`: Enable nested AGENTS.md (experimental)

### Visual Studio

| Feature | Support |
|-|-|
| Repository instructions | ✅ |
| Path-specific instructions | ✅ |
| Custom agents | ❌ |
| Prompt files | ✅ |
| AGENTS.md | ❌ |

### JetBrains IDEs

| Feature | Support |
|-|-|
| Repository instructions | ✅ |
| Global instructions | ✅ |
| Path-specific instructions | ❌ |
| Custom agents | ❌ |
| Prompt files | ✅ |

### GitHub.com (Web)

| Feature | Support |
|-|-|
| Repository instructions | ✅ |
| Path-specific instructions | ⚠️ Coding agent & code review only |
| AGENTS.md | ✅ |
| CLAUDE.md / GEMINI.md | ✅ |
| Custom agents | ❌ |

### Xcode / Eclipse

| Feature | Support |
|-|-|
| Repository instructions | ✅ |
| Path-specific instructions | ❌ |
| Custom agents | ❌ |
| Prompt files | ❌ |

---

## Priority & Precedence

### Instruction Priority (Highest → Lowest)

1. Personal instructions (user settings)
2. Repository instructions (`.github/copilot-instructions.md`)
3. Organization instructions

### Tool List Priority

1. Tools in prompt file
2. Tools from referenced agent in prompt
3. Default tools for selected agent

### AGENTS.md Precedence

- Nearest `AGENTS.md` in directory tree takes precedence
- Subfolder files override root files for operations in that directory

---

## Limitations & Constraints

### General

- Instructions are NOT used for inline suggestions (only chat)
- Maximum ~2 pages recommended for instructions
- Avoid conflicting instructions (non-deterministic resolution)
- Some participant names are reserved in VS Code

### File Detection

- Files must exist to be recognized
- Changes apply on save
- References shown in chat response "References" list

### Cross-Tool Compatibility

- `.agent.md` format specific to VS Code
- AGENTS.md supported by multiple tools (VS Code, Claude, Copilot coding agent)
- CLAUDE.md / GEMINI.md are single-file alternatives

### Security

- Command links require trusted domains
- Images require trusted domains
- MCP policy controlled by organization (disabled by default for enterprise)

---

## Best Practices

### Writing Instructions

1. **Keep instructions concise** — Single, clear statements
2. **Use natural language** — Write as you would explain to a developer
3. **Be specific** — Avoid ambiguity
4. **Avoid conflicts** — Don't contradict between instruction files
5. **Use Markdown formatting** — Headers, lists, code blocks

### Organization

1. **Repository-level** — General coding standards, project overview
2. **Path-specific** — Language/framework-specific guidelines
3. **Prompt files** — Repeatable tasks (component creation, migrations)
4. **Custom agents** — Specialized workflows (security review, planning)

### Recommended Structure

```
.github/
├── copilot-instructions.md           # Project overview, general standards
├── instructions/
│   ├── typescript.instructions.md    # TypeScript guidelines
│   ├── react.instructions.md         # React guidelines
│   └── testing.instructions.md       # Testing guidelines
├── agents/
│   ├── planner.agent.md              # Planning workflow
│   ├── reviewer.agent.md             # Code review focus
│   └── security.agent.md             # Security audit
└── prompts/
    ├── create-component.prompt.md    # Component scaffolding
    ├── add-tests.prompt.md           # Test generation
    └── refactor.prompt.md            # Refactoring guidance
```

### Content Guidelines

- **DO include**: Build commands, test commands, project structure, coding standards
- **DO include**: Framework preferences, error handling patterns, naming conventions
- **DON'T include**: Task-specific instructions in general files
- **DON'T include**: Secrets, credentials, or sensitive information
- **DON'T include**: Extremely long documentation (link instead)

### Testing Instructions

1. Enable instructions in settings
2. Start a chat session
3. Check "References" to verify instructions loaded
4. Iterate and refine based on results

---

## Quick Reference Card

### File Extensions

| Extension | Purpose |
|-|-|
| `copilot-instructions.md` | Repository-wide |
| `*.instructions.md` | Path-specific |
| `*.agent.md` | Custom agent |
| `*.prompt.md` | Reusable prompt |
| `AGENTS.md` | Agent instructions (OpenAI format) |

### Frontmatter Fields

| File Type | Key Fields |
|-|-|
| Instructions | `applyTo`, `excludeAgent`, `description`, `name` |
| Agent | `tools`, `model`, `target`, `handoffs`, `description`, `name` |
| Prompt | `agent`, `tools`, `model`, `description`, `name` |

### Common Tools

| Tool | Purpose |
|-|-|
| `edit` | File editing |
| `search` | Workspace search |
| `fetch` | Web fetching |
| `usages` | Find code usages |
| `problems` | Get diagnostics |
| `changes` | Git changes |
| `runSubagent` | Spawn sub-agents |
| `githubRepo` | GitHub search |

### Key Settings (VS Code)

| Setting | Purpose |
|-|-|
| `github.copilot.chat.codeGeneration.useInstructionFiles` | Enable instructions |
| `chat.promptFiles` | Enable prompt files |
| `chat.useAgentsMdFile` | Enable AGENTS.md |
| `chat.instructionsFilesLocations` | Custom instruction paths |
| `chat.promptFilesLocations` | Custom prompt paths |

---

## Changelog

| Date | Version | Changes |
|-|-|-|
| 2025-12 | 1.0 | Initial specification compiled from GitHub & VS Code docs |

---

## References

- [GitHub Docs: Adding repository custom instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot)
- [VS Code: Custom instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [VS Code: Custom agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [VS Code: Prompt files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [VS Code: Chat Participant API](https://code.visualstudio.com/api/extension-guides/ai/chat)
- [OpenAI AGENTS.md](https://github.com/openai/agents.md)
- [Awesome GitHub Copilot Customizations](https://github.com/github/awesome-copilot)
