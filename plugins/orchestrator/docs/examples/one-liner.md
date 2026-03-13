# One-liner: Examples

Short, targeted prompts for specific changes.

## Example 1: Add a validation step

```text
the validate task should also use ignition-validate on all compiled files
```

**What happens:** The orchestrator quickly interprets this as a single-file change, skips design, and dispatches an implementer to add the validation call. Fast turnaround — typically one research SA and one implementation SA.

## Example 2: Verify and extend

```text
Continuing from the last prompt, please do so, and find figure out other steps to verify and do them all
```

**What happens:** Even vague one-liners work. The orchestrator spawns a researcher to figure out what "other steps" exist, then implements them. Context from the current codebase (`.ai/scratch/*`) fills in the gaps.

## Example 3: Create a new tier

```text
Create that third verification tier AND think further on how to verify the inner workings within those VMs.
```

**What happens:** The orchestrator treats this as two concerns: (1) create the tier (implementation), (2) think about verification (research + design). The "think further" part triggers a research SA before any implementation.
