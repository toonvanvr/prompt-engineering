## Handoff Format

### Skeleton

|Section|Content|
|-|-|
|Task|Task name from dispatch|
|Completed|ISO timestamp|
|Output|Path to main deliverable|
|Summary|One-line description|
|Deliverables|File / Purpose / Lines table|
|Scope Verification|DO items completed + DON'T items respected|
|Confidence|Level (HIGH/MEDIUM/LOW) + Concerns|
|Human Input|Processed: {count} entries / None|
|Feedback Captured|Category / File / Entry table|

Role-specific sections (add in source): Unresolved items, trade-offs, deviations, test results, etc.

### Completion Signal (MANDATORY)

Every SA MUST end output with:

```
## Handoff
Status: COMPLETE | PARTIAL | BLOCKED
Confidence: HIGH | MEDIUM | LOW
Files: {count created}, {count modified}
```
