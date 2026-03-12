# Frontmatter Schema

YAML frontmatter specification for agent `.agent.md` files. Extracted from `agents/source/compiler.src.md`.

---

## Passthrough Rules

1. **Read** the source's `## Frontmatter` section (YAML code block)
2. **Validate** all properties against the known schema (see below)
3. **Emit** the frontmatter as-is in the compiled output's YAML front matter block (`---` delimiters)
4. **NEVER** modify frontmatter values, reorder properties, or add properties not in source
5. **WARN** if required properties are missing

---

## Known Frontmatter Properties

|Property|Type|Required|Description|
|-|-|-|-|
|`name`|string|YES|Agent display name|
|`description`|string|YES|One-line agent purpose|
|`user-invocable`|boolean|NO|Whether user can invoke directly. Default: `true`. Sub-agents set `false`|
|`disable-model-invocation`|boolean|NO|Prevents model from auto-invoking this agent|
|`agents`|string[]|NO|List of sub-agents this agent can spawn|
|`model`|string or string[]|NO|Preferred model(s). Array = fallback order|
|`target`|string|NO|Target scope for the agent|
|`argument-hint`|string|NO|Hint shown to user for agent invocation|
|`tools`|string[]|NO|Available tools list|
|`skills`|string[]|NO|Skill paths (Agent Skills GA)|
|`infer`|boolean|NO|Whether agent can be inferred as relevant|

---

## Architecture Rules

|Agent|`user-invocable`|Rationale|
|-|-|-|
|Orchestrator|`true` (or omit)|Only user-facing agent|
|Implementer|`false`|Sub-agent only|
|Designer|`false`|Sub-agent only|
|Researcher|`false`|Sub-agent only|
|Compiler|`false`|Sub-agent only|

---

## Validation Checks

- `name` and `description` MUST be present
- If `user-invocable: false`, agent MUST NOT have `argument-hint` (hidden agents have no user-facing hints)
- If `agents` is present, each listed agent MUST be a known agent name
- If `model` is an array, it represents fallback order (first = preferred)
- `tools` entries should follow the format `'namespace/tool'` or `'namespace'`

---

## Tools Frontmatter Generation

The `tools:` property has special handling — an EXCEPTION to "never modify frontmatter":

|Scenario|Rule|Rationale|
|-|-|-|
|Source has NO `tools:` frontmatter|Compiler MAY ADD a standard tool set|Generation, not modification|
|Source HAS `tools:` frontmatter|Compiler MUST preserve ALL listed tools|NEVER drop tools — functional dependencies|

**Key distinction:** Adding `tools:` where none exists = generation (permitted). Modifying/removing existing `tools:` = modification (FORBIDDEN).
