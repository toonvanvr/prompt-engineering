# Tool Risk Classification

## Description
Risk-based tool call handling. Higher stakes require higher oversight.

## Stakes Levels

|Level|Operations|Action|
|-|-|-|
|LOW|read_file, list_dir, grep_search, semantic_search, file_search|Proceed freely|
|MEDIUM|create_file, mkdir, template generation, analysis output|Log to scratch|
|HIGH|edit_file, delete_file, run_command, multi-file changes (>3)|Explicit justification required|

## FORBIDDEN Operations (never permitted)

|Operation|Risk|Use Instead|
|-|-|-|
|`cat > file`, `echo > file`|Bypasses VS Code, breaks undo|`create_file`|
|`cat >> file`, `echo >> file`|Same risks|`replace_string_in_file`|
|`sed -i`|Direct file modification|`replace_string_in_file`|
|Shell redirects (`>`, `>>`, `2>`)|Bypasses file watching|VS Code edit tools|

## Rules
- HIGH-stakes operations must state justification before execution
- FORBIDDEN violation → immediate self-analysis log + task failure
- Log HIGH-stakes operations in `implementation_changes.md`
