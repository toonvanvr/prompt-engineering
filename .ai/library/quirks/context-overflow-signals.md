# Quirk: Context Overflow Signals

## Signs the orchestrator is running low on context
- Repeating instructions already given
- Forgetting earlier decisions or contradicting them
- Degrading output quality (shorter, less precise responses)
- Losing track of which SAs have completed
- Re-reading files already read in this session
- Starting to merge distinct task scopes

## Mitigations
1. Write current state to progress.md immediately
2. Write key decisions to decisions section
3. Create a continuation checkpoint file
4. Summarize aggressively: retain max 5 bullet points per completed SA
5. Consider restarting with a new orchestrator session reading from progress.md
