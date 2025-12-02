# Instructions Folder

Active human instructions are placed here.

## How to Use
1. Copy a template from `../templates/`
2. Fill in the checkboxes and fields
3. Save to this folder
4. AI will process on next checkpoint

## Processing
- AI checks this folder at defined checkpoints
- Processed instructions move to `../processed/`
- Multiple instructions processed in filename order

## Checkpoint Triggers
- Before sub-agent dispatch
- After gate verification
- Before phase transition
- Before file modification (multi-file tasks)
