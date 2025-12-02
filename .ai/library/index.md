# Knowledge Library Index

Persistent knowledge extracted from compilations & research.

## Structure

```
library/
├── index.md            # This file (auto-updated)
├── patterns/           # Reusable prompt patterns
│   └── core.md         # Universal patterns
└── research/           # Permanent findings
    └── findings.md     # Key discoveries
```

## Patterns

|Pattern|File|Use Case|
|-|-|-|
|Identity Matrix|patterns/core.md|Agent persona|
|Three Laws|patterns/core.md|Behavioral anchor|
|ALWAYS/NEVER|patterns/core.md|Binary constraints|
|Compression Rules|patterns/core.md|Token optimization|
|Dense Markdown|patterns/core.md|Output formatting (MANDATORY)|
|Register Taxonomy|research/findings.md|Language selection|

## Usage

Agents reference on-demand:
```markdown
@inherit: .ai/library/patterns/core.md#three-laws
```

## Update Protocol

After compilation:
1. Extract reusable patterns → `patterns/`
2. Extract permanent findings → `research/`
3. Update this index
4. Clean scratch directory

---

*Last updated: 2025-12-02*
