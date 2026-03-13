# Multi-concern: Examples

Multiple related changes in one prompt — typically 2-5 bullet points.

## Example 1: Convert and validate

```text
- Convert all sh scripts like bootstrap into the JS, unless they're meant to run client side and would add a dependency..
- Have a validation to check asynchronously which hosts have which services working or not, maybe with error? with an easy way to check logs for them.
```

**What happens:** Two independent concerns get parallel sub-agents. The orchestrator identifies these as separate domains (script conversion vs. validation system), designs each independently, and implements in parallel. Typos and informal language are fine — the orchestrator interprets intent, not syntax.

## Example 2: Fix and migrate

```text
- fix the status --help ambiguity
- get rid of the /networking, /gitops, /secrets, /services, /scripts folder as the intention was to move all of that to the /src folder; after check => actually do the movement WITH CONVERSION TO FOLLOW THE NEW PATTERNS IN TS. It does make sense as you're reusing IP addresses and want single sources of truth for variables. If you didn't get that, find a way to understand my intent so this is finally merged with the specs and intention of this repo for further AI use.
```

**What happens:** The orchestrator handles this as a small fix (item 1) plus a large migration (item 2). The fix goes first as a quick SA. The migration gets full pipeline treatment — research to understand the current structure and intent, design the migration plan, then implement with conversion to TypeScript patterns. The "if you didn't get that" part is interpreted as a directive to investigate deeper rather than guess.
