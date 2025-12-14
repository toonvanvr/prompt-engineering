# Thoroughness Protocol

Read-completeness guarantees for critical operations.

---

## Core Principle

> MUST read entire file before modifying. MUST read entire document before analyzing.

**Budget:** UNLIMITED TIME on critical files. Thoroughness > speed.

---

## Size-Aware Strategy

|Size|Strategy|Verification|
|-|-|-|
|<100 lines|Single read|Implicit|
|100-300 lines|Single read|State total lines|
|300-500 lines|Chunked reads|List section inventory|
|>500 lines|Multi-pass|Full inventory + verification|

---

## Mandatory Assertions

### Before Modifying Any File

- MUST: Read to file end before editing
- MUST: Acknowledge if partial read (state what's missing)
- NEVER: Assume first N lines = complete file
- NEVER: Edit based on truncated context

### For Design Documents

- MUST: Read entire design before implementation
- MUST: Cross-reference all sections mentioned
- MUST: Verify no sections skipped

---

## Verification Protocol

### For Files 100-300 Lines

```md
Read complete: {filename} ({N} lines total)
```

### For Files 300-500 Lines

```md
Section inventory for {filename}:
- Lines 1-50: {section name}
- Lines 51-120: {section name}
- ...
- Lines {N-50}-{N}: {section name}
All sections read: YES
```

### For Files >500 Lines

```md
## File Inventory: {filename}

Total lines: {N}
Read passes: {count}

### Structure
|Section|Lines|Status|
|-|-|-|
|{name}|1-100|✓|
|{name}|101-250|✓|
|...|...|...|

Verification: All sections read
```

---

## Time Budget Declaration

For critical files (modify targets, design docs):

- Multiple read passes: ALLOWED
- Re-read for verification: ALLOWED
- Extended analysis time: ALLOWED
- Timeout pressure: IGNORED

**Rationale:** Incomplete reads cause implementation errors. Time spent reading < time fixing errors.

---

## Integration

Add to agent ALWAYS lists:

```md
- **Full-read critical files** — modify targets, design docs (thoroughness.md)
```

### Critical File Types

|File Type|Thoroughness Level|
|-|-|
|Files being modified|MANDATORY|
|Design documents|MANDATORY|
|Kernel files|MANDATORY|
|Reference files|RECOMMENDED|
|Examples|OPTIONAL|
