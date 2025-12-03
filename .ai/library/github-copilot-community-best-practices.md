# GitHub Copilot Custom Instructions: Community Best Practices

> **Source**: Community blogs, tutorials, and developer experiences (non-official)  
> **Last Updated**: December 2025  
> **Status**: Living document — update as patterns evolve

---

## TL;DR

Custom instructions are your chance to onboard Copilot like you would a senior developer. Keep them concise, use examples, test regularly, and remember: old instructions are as dangerous as no instructions.

---

## Table of Contents

1. [Instruction System Architecture](#instruction-system-architecture)
2. [File Locations and Priority](#file-locations-and-priority)
3. [Writing Effective Instructions](#writing-effective-instructions)
4. [Token Optimization Strategies](#token-optimization-strategies)
5. [Common Pitfalls to Avoid](#common-pitfalls-to-avoid)
6. [Interoperability with Other AI Tools](#interoperability-with-other-ai-tools)
7. [Real-World Patterns](#real-world-patterns)
8. [Testing and Validation](#testing-and-validation)
9. [Community Resources](#community-resources)

---

## Instruction System Architecture

### Four-Tier Instruction Hierarchy (2025)

GitHub Copilot uses a layered instruction system:

```
Priority Order (Highest to Lowest):
1. Personal Instructions (user profile on GitHub.com)
2. Repository Instructions (.github/copilot-instructions.md)
3. Path-Specific Instructions (.github/instructions/*.instructions.md)
4. Organization Instructions (Copilot Business/Enterprise)
```

### Key Insight: Non-Deterministic Behavior

> "These do not behave like you expect them to and since Copilot is non-deterministic by design, it's also not supposed to."  
> — Ashley Childress, Dev.to

All instruction files are merged into context, not prioritized like CSS cascades. Conflicts between personal and repo instructions can cause unpredictable results.

---

## File Locations and Priority

### Supported File Locations

| File | Location | Format | When Loaded |
|------|----------|--------|-------------|
| `copilot-instructions.md` | `.github/` | Markdown | Always (all Copilot surfaces) |
| `*.instructions.md` | `.github/instructions/` | Markdown + YAML frontmatter | Based on `applyTo` pattern |
| Personal Instructions | GitHub Settings | Web UI | Cross-project |
| Organization Guidelines | Admin Console | Web UI | Copilot Business/Enterprise |

### IDE Support Matrix

| Platform | Repo Instructions | Path-Specific | Personal | Org Guidelines |
|----------|------------------|---------------|----------|----------------|
| VS Code | ✅ | ✅ | ✅ | ✅ |
| JetBrains | ✅ | ✅ | ✅ | ✅ |
| GitHub.com | ✅ | ✅ | ✅ | ✅ |
| GitHub CLI | ✅ | Limited | ✅ | ✅ |
| GitHub Desktop | ❌ | ❌ | ❌ | ⚠️ Enterprise only |

---

## Writing Effective Instructions

### The 15-Minute Onboarding Rule

> "That's exactly how you should treat Copilot. And you'll see the exact same returns from Copilot as you would any well-trained developer who's capable of reading documentation and making the right call when it matters."  
> — Ashley Childress

Think of instructions as the onboarding you'd give a new senior developer, not a style guide.

### Structural Best Practices

**DO include:**
- Project overview and purpose
- Technology stack with specific versions
- Critical patterns and anti-patterns (with examples)
- Testing requirements and commands
- Security considerations
- Dependencies on other systems

**DON'T include:**
- Exhaustive code style rules (use linters instead)
- Generic programming advice
- Obvious instructions
- Duplicate information from other config files

### Example Structure Template

```markdown
# GitHub Copilot Instructions

**Project**: [Name]  
**Last Updated**: [Date]  

---

## Project Overview

[One-paragraph description]

---

## Technology Stack

- **Language**: TypeScript 5.4 (strict mode)
- **Framework**: Next.js 15 (App Router, NOT Pages Router)
- **Database**: PostgreSQL 16
- **ORM**: Drizzle ORM

---

## Critical Patterns

### Error Handling (REQUIRED)

```typescript
// ✅ CORRECT: Use Result type
type Result<T> = 
  | { success: true; data: T }
  | { success: false; error: string };

// ❌ WRONG: Throwing exceptions
throw new Error('Something went wrong');
```

---

## Anti-Patterns (NEVER DO)

- NO `any` types in TypeScript
- NO hardcoded secrets
- NO direct database queries without orgId filter

---

## Testing Requirements

- Run: `pnpm test`
- Coverage: 80% minimum
- Pattern: AAA (Arrange, Act, Assert)

---

## Security Checklist

- [ ] OrgId filter on all queries
- [ ] Input validation with Zod
- [ ] Parameterized SQL only
```

---

## Token Optimization Strategies

### Practical Limits

| Metric | Recommendation | Maximum |
|--------|---------------|---------|
| Word count | 2,000-5,000 words | ~50KB before context dilution |
| Organization instructions | 609 characters | Hard limit |
| User instructions | 2-3 high-impact rules | More causes confusion |

### Compression Techniques

**1. Use bullet points over prose:**

```markdown
# ❌ Verbose
We believe that type safety is very important because it helps prevent 
runtime errors and makes the code easier to maintain. Therefore, we 
would like you to please try to use TypeScript's strict mode whenever 
possible and avoid using the 'any' type unless absolutely necessary.

# ✅ Concise
- TypeScript strict mode REQUIRED
- NO `any` types (use `unknown` + type guards)
```

**2. Reference existing config files:**

```markdown
## Code Style
Follow rules in `.eslintrc.js`
```

**3. Use examples instead of descriptions:**

```markdown
# ❌ Description only
Use the repository pattern for data access.

# ✅ With example
## Repository Pattern

```typescript
class UserRepository {
  constructor(private db: Database) {}
  
  async findById(id: string): Promise<User | null> {
    return this.db.users.findFirst({ where: { id } });
  }
}
```
```

**4. Strong keywords for enforcement:**

Use `REQUIRED`, `MANDATORY`, `NEVER`, `ALWAYS`, `CRITICAL` for non-negotiable rules. Copilot responds better to positive reinforcement (show correct patterns) than negative ("don't do X").

---

## Common Pitfalls to Avoid

### 1. Instruction Conflicts

**Problem**: User and repo instructions contradict each other.

**Symptom**: Copilot alternates between styles or ignores both.

**Solution**: 
- Keep personal instructions minimal (3 lines max)
- Focus personal instructions on response style, not code patterns
- Align instructions across all layers

### 2. Stale Instructions

> "⚠️ Seriously, y'all! Old instructions are just as dangerous as no instructions at all!"  
> — Ashley Childress

**Solution**: 
- Update instructions when tech stack changes
- Schedule monthly/quarterly reviews
- Add `Last Updated` date to file header

### 3. Context Dilution

**Problem**: Instructions too long, pushing actual code context out of window.

**Symptom**: Copilot ignores both instructions and current file patterns.

**Solution**:
- Keep under 5,000 words
- Use path-specific instructions to scope rules
- Prioritize high-impact rules

### 4. Formatting Rules Overload

**Problem**: Wasting instruction space on code style.

**Solution**: 
- Let linters/formatters handle formatting
- Only add style instructions if Copilot consistently violates them
- Remove once behavior corrects

### 5. Not Verifying Instructions Load

**How to verify:**
1. Open any file in project
2. Open Copilot Chat
3. Ask: "What are the coding standards for this project?"
4. Check the "references" section shows your instruction files

---

## Interoperability with Other AI Tools

### Comparison: Copilot vs Cursor vs Windsurf

| Feature | Copilot | Cursor | Windsurf |
|---------|---------|--------|----------|
| Primary file | `.github/copilot-instructions.md` | `.cursor/rules/*.mdc` | `.windsurfrules` |
| Path-specific | `.github/instructions/*.instructions.md` | YAML frontmatter with globs | `.windsurf/rules/*.md` |
| Format | Markdown | MDC (Markdown Components) | Markdown |
| Character limit | ~50KB (practical) | 6,000 chars | Varies |
| Rule adherence | Moderate | Strong | Moderate |

### Community Findings (from dev.family comparison)

- **Cursor**: Followed rules most accurately, cleanest results
- **Windsurf**: Requires more guidance but performs well with adjustments  
- **Copilot**: Struggles with strict rule adherence compared to alternatives

### Migration Patterns

**From Cursor to Copilot:**
```yaml
# Cursor (.cursor/rules/typescript.mdc)
---
description: TypeScript rules
globs: ["**/*.ts"]
---
Use strict mode.

# Copilot (.github/instructions/typescript.instructions.md)
---
applyTo: "**/*.ts"
---
Use strict mode.
```

**From Windsurf to Copilot:**
1. Extract rules from `.windsurfrules` or `.windsurf/rules/*.md`
2. Combine universal rules into `.github/copilot-instructions.md`
3. Move file-specific rules to `.github/instructions/*.instructions.md`

### Cross-Tool Strategy

For projects using multiple AI assistants:

1. Create a shared `docs/coding-standards.md`
2. Reference it from each tool's instruction file
3. Keep tool-specific syntax in separate files
4. Document which instructions apply to which tools

---

## Real-World Patterns

### Pattern 1: Multi-Tenant SaaS (Security Focus)

```markdown
## Multi-Tenancy (CRITICAL)

Every database query MUST filter by `orgId`:

```typescript
// ✅ CORRECT
const projects = await db.query.projects.findMany({
  where: eq(projects.orgId, user.orgId)
});

// ❌ SECURITY RISK - Leaks data across organizations
const projects = await db.query.projects.findMany();
```
```

### Pattern 2: Legacy Application Migration

```markdown
## Technology Stack

- **Language**: Java 21+ ONLY (NOT Java 8 patterns)
- **Testing**: JUnit 5 for all new or modified code

## Migration Context

This is a Java 8 → 21 migration in progress. When suggesting code:
- Use modern Java features (records, sealed classes, pattern matching)
- Do NOT copy patterns from existing legacy code
- Flag any Java 8-isms for review
```

### Pattern 3: Persona-Based Instructions

```markdown
## Copilot Persona

You are assisting JUNIOR developers. Requirements:
- Explain solutions simply with concrete examples
- After explanations, follow up with a multiple-choice question to verify understanding
- If needed, break problems into clear, separate steps
- Never assume advanced knowledge
```

### Pattern 4: DevOps/Infrastructure

```markdown
## Terraform Best Practices

- Provider: `azurerm` version `~>3.0`
- **Private Networking First!** Use private endpoints for Azure PaaS services
- Never hardcode secrets - reference from Key Vault
- Prefer `for_each` over `count` for multiple resources
- Naming convention: `rg-<project>-<environment>-<region>-<type>-<3digitnumber>`
```

---

## Testing and Validation

### Verification Checklist

1. **File loads correctly:**
   - Check Copilot Chat "references" panel
   - Ask about project standards in chat

2. **Rules are applied:**
   - Create test file
   - Ask Copilot to generate code
   - Verify it follows instructions

3. **No conflicts exist:**
   - Review all instruction layers
   - Check for contradictions
   - Test edge cases

### Automated Testing

```bash
# Create test file
cat > src/test/copilot-test.ts << 'EOF'
// Ask Copilot to generate a state management solution
// Verify it uses project-specified library
EOF

# In Copilot Chat:
# "Generate a global state store for user authentication"

# Check:
# - Did it use specified state library?
# - Did it follow error handling patterns?
# - Are security rules applied?
```

### Continuous Validation

- Review Copilot suggestions weekly
- Log instruction failures
- Update instructions based on patterns
- Remove temporary rules once behavior corrects

---

## Community Resources

### Blog Posts & Tutorials

- [Complete Guide to AI Coding Rules for GitHub Copilot](https://dev.to/yigit-konur/complete-guide-how-to-set-ai-coding-rules-for-github-copilot-2i99) — Yigit Konur (20 min)
- [All I've Learned About GitHub Copilot Instructions](https://dev.to/anchildress1/all-ive-learned-about-github-copilot-instructions-so-far-5bm7) — Ashley Childress
- [Instructions and Prompt Files to Supercharge VS Code](https://dev.to/pwd9000/supercharge-vscode-github-copilot-using-instructions-and-prompt-files-2p5e) — Marcel.L

### GitHub Repositories

- [awesome-github-copilot](https://github.com/anchildress1/awesome-github-copilot) — Custom instructions, prompts, and chat modes
- [github/awesome-copilot](https://github.com/github/awesome-copilot) — Official GitHub collection (MCP-focused)

### Key Concepts from Community

1. **Instructions vs Prompts**: Instructions are persistent context; prompts are one-time requests
2. **applyTo patterns**: Use `.gitignore`-style globs in YAML frontmatter
3. **Premium requests**: Some features (like Copilot Spaces) consume premium quota
4. **Chat modes/Agents**: Custom "personalities" for specific tasks

---

## Quick Reference Card

### File Setup (Minimal)

```
.github/
├── copilot-instructions.md    # Main instructions (always loaded)
└── instructions/
    ├── typescript.instructions.md  # applyTo: "**/*.{ts,tsx}"
    └── tests.instructions.md       # applyTo: "**/*.test.*"
```

### VS Code Settings

```json
{
  "github.copilot.chat.codeGeneration.useInstructionFiles": true,
  "github.copilot.enable": {
    "*": true,
    "plaintext": false,
    "markdown": false
  }
}
```

### Path-Specific Instruction Template

```markdown
---
applyTo: "src/components/**/*.tsx"
---

# React Component Standards

- Functional components only
- Props interface above component
- Maximum 200 lines per file
```

### Troubleshooting Commands

```bash
# Verify file exists
ls -la .github/copilot-instructions.md

# Check file size
wc -c .github/copilot-instructions.md

# Validate markdown
npx markdownlint .github/copilot-instructions.md
```

---

## Changelog

| Date | Change |
|------|--------|
| Dec 2025 | Initial community research compilation |

---

*This document synthesizes community knowledge from Dev.to, GitHub discussions, and developer blogs. Always verify against current GitHub Copilot documentation as features evolve.*
