# Pattern: File-Mediated State Transfer

## Problem
Sub-agents lose context when tasks span multiple invocations. Conversation state doesn't persist across SA boundaries.

## Solution
Every SA reads input from files and writes output to files. The orchestrator routes between SAs by pointing them at output files from previous SAs, never by summarizing conversations.

## Structure
SA₁ → writes findings.md → Orchestrator reads → SA₂ reads findings.md → writes implementation.md

## Rules
- Orchestrator READS files to decide what to do
- SAs READ files to know what to do  
- Nobody relies on conversation history across boundaries
- The orchestrator never forwards raw SA output — it reads the file, extracts key facts, points next SA at the file

## Anti-Pattern
Orchestrator summarizing SA₁'s output in SA₂'s prompt. This loses detail and costs orchestrator context.

## Evidence
- Logger project 2026-02-07: File-mediated handoffs preserved full analysis context across 4 implementation phases
- findings.md (512 lines) transferred full context without conversation replay
