# State Tracking System

This directory maintains the processing state for the end-to-end agent system.

## File: `processed.json`

Tracks which training data files have been processed and their content hashes to detect changes.

### Schema

```json
{
  "version": "1.0.0",
  "last_run": "ISO-8601 timestamp",
  "files": {
    "relative/path/to/file.prompt.md": {
      "hash": "sha256 hash of file content",
      "processed_at": "ISO-8601 timestamp",
      "status": "processed|failed|skipped",
      "notes": "optional processing notes"
    }
  }
}
```

### Hash Calculation

Files are hashed using SHA-256 of their raw content. A file is considered:
- **New**: Not present in `files` object
- **Modified**: Present but hash differs from stored value
- **Unchanged**: Present and hash matches

### Processing Rules

1. Only files matching `*.prompt.md` or `*.comment.md` are tracked
2. Unchanged files are skipped unless `--force` mode is used
3. Failed files are retried on next run
4. State is updated atomically after each file is processed
