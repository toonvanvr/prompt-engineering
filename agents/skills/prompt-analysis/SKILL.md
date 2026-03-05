---
name: Prompt Analysis
description: Classify user prompts to derive execution mode and pipeline customization
repo-only: true
---

# Prompt Analysis

Classify the user's prompt along 4 dimensions to determine execution strategy.

## Dimensions

|Dimension|Values|Signal|
|-|-|-|
|Size|Micro (≤2 lines), Small (≤10), Medium (≤50), Mega (>50)|Line count|
|Type|fix, feature, refactor, create, investigate, meta|Keywords + intent|
|Scope|Scoped (specific files/lines cited), Expansive (vague, broad)|Presence of file refs|
|Complexity|Single-domain, Multi-domain, Architectural|Domain count|

## Mode Derivation

|Size|Type|Scope|→ Mode|→ Pipeline|
|-|-|-|-|-|
|Micro|fix|Scoped|EXPLOIT|Skip interpretation + design. 1 impl SA.|
|Small|fix/feature|Scoped|EXPLOIT|Lightweight interpret → design → impl|
|Small|fix|Scoped|EXPLOIT|Skip R/D if ≤3 files. 1-2 impl SAs. See §6 Small-Task Protocol.|
|Small|investigate|Any|EXPLORE|Research only, no implementation|
|Medium|feature/refactor|Any|EXPLORE→EXPLOIT|Standard pipeline (all phases)|
|Mega|Any|Any|EXPLORE→EXPLOIT|Full pipeline, multi-wave batching|
|Any|meta|Any|EXPLORE→EXPLOIT|Full pipeline (self-repo awareness)|

## Methodology Selection

|When|Approach|
|-|-|
|Vague/expansive prompt ("create an app")|Brainstorming, contrarian evaluation, persona isolation|
|Scoped with ambiguity ("add feature X")|Targeted research, single contrarian pass|
|Clear ticket/spec|Direct design → implementation|
|Internal/meta prompt|Self-repo awareness + full analysis|

## Usage
Orchestrator applies this at startup step 4.5. Classification is inline (no SA). Result logged to handbook.md.
