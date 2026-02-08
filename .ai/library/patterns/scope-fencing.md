# Pattern: Scope Fencing

## Problem
SAs expand scope mid-task, especially research SAs that discover "one more thing" to investigate.

## Solution
Every SA dispatch includes explicit DO NOT list with the same specificity as the DO list. The verification command acts as a scope gate.

## Template
```
DO: {1-3 specific deliverables with file paths}
DO NOT: {explicit exclusions}
VERIFY: {exact shell command checking only in-scope deliverables}
```

## Rules
- DO and DO NOT lists must be equally specific
- Max 3 deliverables per SA
- Verification only checks in-scope work
- Out-of-scope discoveries → document in handoff, don't act

## Evidence
- Logger project: research SA stayed in scope (512 lines pure analysis, zero code changes) with explicit scope fence
- Pattern failures: memory/scratch confusion happened because scope boundary was ambiguous ("save state" could mean either)
