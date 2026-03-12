# TODO Priority Conventions

Standardized TODO annotations for consistent priority handling.

---

## Priority Levels

|Tag|Priority|Description|Action|
|-|-|-|-|
|`TODO(0)`|Critical|Never merge with this|Block release|
|`TODO(1)`|High|Architectural flaws, major bugs|Fix before PR|
|`TODO(2)`|Medium|Minor bugs, missing features|Fix soon|
|`TODO(3)`|Low|Polish, tests, documentation|Backlog|
|`TODO(4)`|Question|Investigation needed|Research|
|`PERF`|Special|Performance optimization|Profile first|

---

## Usage Format

### In Code

```
// TODO(1): Fix race condition in auth flow
// TODO(3): Add unit tests for edge cases
// PERF: Optimize database query, currently O(n²)
```

### In Markdown

```md
<!-- TODO(2): Add example for edge case -->
- [ ] TODO(1): Implement error handling
```

---

## Priority Rules

### Never Merge

- `TODO(0)` blocks all merges
- Must be resolved or downgraded with justification

### PR Requirements

|Priority|Requirement|
|-|-|
|0|Block — must resolve|
|1|Resolve OR escalate with plan|
|2|Document in PR, create issue|
|3-4|Optional to address|

---

## Discovery Protocol

When finding existing TODOs:

1. Assess priority level
2. Add number if missing: `TODO` → `TODO(3)`
3. Document in analysis if relevant to task

---

## Agent Behavior

### On TODO Discovery

- Log to analysis artifacts
- Do not "fix" TODOs outside scope
- Report blocking TODOs (0-1) in handoff

### On TODO Creation

- Always include priority number
- Match to severity:
  - Bug that breaks flow → TODO(1)
  - Missing feature → TODO(2)
  - Enhancement idea → TODO(3)
  - Unknown behavior → TODO(4)

---

## Summary

```
TODO(0): Critical — never merge
TODO(1): High — fix before PR
TODO(2): Medium — fix soon
TODO(3): Low — backlog
TODO(4): Question — research
PERF: Performance — profile first

Always include priority number.
```
