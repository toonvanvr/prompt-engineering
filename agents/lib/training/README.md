# Training Data Library

This directory contains training data that informs the end-to-end agent's behavior.

## File Types

### Prompt Files (`*.prompt.md`)
Raw prompts that have been used successfully. These serve as examples of:
- How to structure complex requests
- What information to include
- Successful sub-agent decomposition patterns

### Comment Files (`*.comment.md`)
Post-execution feedback and lessons learned:
- What worked well
- What didn't work
- Improvements to make

## Processing

The end-to-end agent processes new files in this directory to:
1. Extract patterns and best practices
2. Update internal heuristics
3. Refine sub-agent dispatch templates

## State Tracking

See `.github/agents/lib/state/` for processing state.
Files are tracked by SHA-256 hash to detect changes.

## Adding New Training Data

1. Create a new file with the next sequence number: `NNN.prompt.md`
2. Include the full prompt that was used
3. Optionally create a matching `NNN.comment.md` with feedback
4. The agent will process new files on next run
