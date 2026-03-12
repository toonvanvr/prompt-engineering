## Thoroughness Protocol

Read-completeness guarantees for critical operations.

> MUST read entire file before modifying. MUST read entire document before analyzing AS PRIMARY TARGET.

**Scope:** Applies to files the agent is WORKING ON (modifying, analyzing as primary target). Does NOT apply to files read for routing, reporting to other agents, or verification.

### Size-Aware Strategy

|Size|Strategy|Verification|
|-|-|-|
|<100 lines|Single read|Implicit|
|100-300 lines|Single read|State total lines|
|300-500 lines|Chunked reads|List section inventory|
|>500 lines|Multi-pass|Full inventory + verification|

### Mandatory Assertions

**Before Modifying Any File:**
- MUST: Read to file end before editing
- MUST: Acknowledge if partial read (state what's missing)
- NEVER: Assume first N lines = complete file
- NEVER: Edit based on truncated context

**For Design Documents:**
- MUST: Read entire design before implementation
- MUST: Cross-reference all sections mentioned
- MUST: Verify no sections skipped

### Ellipsis Expansion

When generating ANY list ending with `..`, `...`, or similar:
1. STOP — do not emit the ellipsis
2. Spend reasoning time: what concrete items remain unstated?
3. Either enumerate them explicitly or state "N additional items omitted: {category}"
4. Ellipsis in OUTPUT = specification defect

### Critical File Types

|File Type|Thoroughness Level|Applies To|
|-|-|-|
|Files being modified|MANDATORY|Implementer|
|Files being analyzed (primary targets)|MANDATORY|Researcher|
|Research findings being consumed|MANDATORY|Designer|
|Design documents|MANDATORY|Implementer, Designer|
|Files for routing decisions|SKIM ONLY|Orchestrator|
|SA output for verification|HANDOFF ONLY|Orchestrator|
|Reference files|RECOMMENDED|All|

### Read-Before-Write Guard
Before creating/modifying any output file: read existing content at that path (or confirm it doesn't exist). Writing without reading = overwrite risk.
