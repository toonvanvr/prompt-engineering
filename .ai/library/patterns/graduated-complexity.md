# Pattern: Graduated Complexity Delegation

## Problem
Orchestrators assign tasks of wildly varying complexity in the same dispatch wave, leading to uneven quality.

## Solution
Sort tasks by complexity and delegate in waves:
1. Wave 1: Trivial fixes (1-line changes, config tweaks) — batch 5+ per SA
2. Wave 2: Small features (single-file changes) — 1-2 per SA
3. Wave 3: Cross-cutting changes (multi-file) — 1 per SA
4. Wave 4: Architectural changes — research SA first, then implementation SA

## Rules
- Never mix wave levels in a single SA
- Each wave completes before next starts (dependencies allowing)
- Research SAs always precede implementation SAs for wave 3+

## Evidence
- Logger project: Phase B (3 renderer implementations) was appropriately scoped for one SA
- Phase C (3 distinct features) was borderline — passed but risk was higher
