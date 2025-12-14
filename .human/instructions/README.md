# Instructions Folder

Active human instructions are placed here.

## How to Use
1. Copy a template from `../templates/`
2. Fill in the checkboxes and fields
3. Save to this folder
4. AI will process on next checkpoint

## Processing
- AI scans this folder at defined checkpoints
- Processed instructions move to `.ai/scratch/{workfolder}/00_prompts/`
- Multiple instructions processed in filename order

## Checkpoint Triggers (6 Total)
- **Task-start** — Session init
- **Phase-start** — Before Analysis/Design/Review
- **Pre-gate** — Before phase gate (Analysis/Design/Review)
- **Pre-impl** — Before Implementation Gate
- **Deviation** — Before design deviation
- **Escalation** — Before escalating (halt)
