# CLI Tool: Folder Rename Utility

## Prompt

> build a cli that renames folders in a directory matching pattern X to pattern Y, with dry-run mode

## What Happens

Vague but actionable — the orchestrator infers scope from the prompt and fills in reasonable defaults. No need for a lengthy spec when the intent is clear.

### Pipeline: Research → Design → Implement

**Research phase** checks:
- Current project language/runtime (Node.js in this case)
- Existing CLI patterns in the codebase (if any)
- No conflicting `bin/` entries in `package.json`

**Design phase** produces:
- CLI using `commander` or plain `process.argv` parsing
- Arguments: `--source <dir>`, `--match <pattern>`, `--replace <pattern>`, `--dry-run`
- Default: current directory, dry-run off
- Output: table of old → new names, summary count
- Safety: refuse to overwrite existing directories

**Implementation phase** builds:
- Single-file CLI with argument parsing
- Regex-based matching and renaming
- Dry-run prints what would change without touching the filesystem
- `package.json` bin entry

## How Vague Prompts Work

The orchestrator doesn't ask for clarification on things it can infer. "Pattern X to pattern Y" becomes regex arguments. "Dry-run mode" becomes a flag. It picks sensible defaults and builds something usable — you refine from there.
