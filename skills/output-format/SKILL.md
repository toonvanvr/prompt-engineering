# Output Format

## Description
Task sizing, output budget, and TODO annotation conventions.

## Task Sizing

Score = (files × 10) + (domains × 30) + (estimated_lines × 0.5)

|Size|Score|Max Output/Response|Verbosity|
|-|-|-|-|
|S (Small)|<100|500 lines|Normal — full explanations|
|M (Medium)|100–200|300 lines|Terse — key points only|
|L (Large)|≥200|150 lines|Minimal — action + result only|

## Domains
Frontend, Backend, Infra, Kernel, Docs — each counts as 1 domain.

## Artifact-First Rule
- S: inline OK
- M: file preferred for code/analysis
- L: file required — reference paths, don't quote

## TODO Annotations

|Tag|Priority|Action|
|-|-|-|
|`TODO(0)`|Critical|Block release — never merge|
|`TODO(1)`|High|Fix before PR|
|`TODO(2)`|Medium|Fix soon, create issue|
|`TODO(3)`|Low|Backlog|
|`TODO(4)`|Question|Research needed|
|`PERF`|Special|Profile before optimizing|
