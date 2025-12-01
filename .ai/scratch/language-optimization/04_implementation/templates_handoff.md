# Templates Implementation Handoff

**Phase:** Implementation
**Topic:** language-optimization/v2-templates
**Next:** Review

---

## Confidence Assessment

| Level | Concerns | Mitigation |
| ----- | -------- | ---------- |
| HIGH  | —        | —          |

---

## Summary

Created 6 compressed dispatch templates for v2 agents. All templates follow compressed format with symbols (→ & =), tables over prose, and clear placeholder markers. `dispatch-implement.md` explicitly enforces EXPLOIT mode with prominent warning box.

---

## Artifacts Produced

| Artifact           | Path                                        | Lines | Description                                           |
| ------------------ | ------------------------------------------- | ----- | ----------------------------------------------------- |
| dispatch-base      | `agents/v2/templates/dispatch-base.md`      | ~80   | Common preamble, prime directives, kernel inheritance |
| dispatch-analysis  | `agents/v2/templates/dispatch-analysis.md`  | ~100  | Analysis sub-agent, EXPLORE mode, file limits         |
| dispatch-design    | `agents/v2/templates/dispatch-design.md`    | ~100  | Design sub-agent, EXPLORE mode, specs output          |
| dispatch-implement | `agents/v2/templates/dispatch-implement.md` | ~110  | Implementation, **EXPLOIT enforced**, 1-1-1 rule      |
| dispatch-review    | `agents/v2/templates/dispatch-review.md`    | ~85   | Review sub-agent, checklist format, severity levels   |
| handoff            | `agents/v2/templates/handoff.md`            | ~85   | Phase transition, confidence, phase-specific sections |

---

## Key Design Decisions

| Decision                          | Rationale                                         |
| --------------------------------- | ------------------------------------------------- |
| EXPLOIT enforcement in implement  | Prominent warning box + explicit constraint stack |
| Tables for all structured content | Compression & scannability                        |
| Gate status in every handoff      | Three Laws compliance (Law 3)                     |
| Phase-specific handoff sections   | Reusable base + phase additions                   |
| Mode switch triggers included     | Clear escalation paths                            |

---

## Format Compliance

| Requirement                         | Status            |
| ----------------------------------- | ----------------- |
| Compressed (no filler)              | ✓                 |
| Symbols (→ & =)                     | ✓                 |
| Tables over prose                   | ✓                 |
| Placeholder markers `{placeholder}` | ✓                 |
| dispatch-implement EXPLOIT          | ✓ (prominent box) |

---

## Template Relationships

```
dispatch-base
    ↓ (preamble)
├── dispatch-analysis  (EXPLORE)
├── dispatch-design    (EXPLORE → EXPLOIT on approval)
├── dispatch-implement (EXPLOIT mandatory)
└── dispatch-review    (EXPLOIT)
    ↓ (all use)
handoff (phase transitions)
```

---

## Quality Gate

| Gate                    | Status |
| ----------------------- | ------ |
| Implementation Complete | PASS   |

| Check                   | Status | Evidence                            |
| ----------------------- | ------ | ----------------------------------- |
| All 6 templates created | ✓      | Files exist                         |
| Compressed format       | ✓      | Tables, symbols throughout          |
| EXPLOIT in implement    | ✓      | Warning box + constraint stack      |
| Placeholders marked     | ✓      | `{placeholder}` format              |
| Matches v1 patterns     | ✓      | Reviewed v1 templates               |
| Kernel consistency      | ✓      | References three-laws, gates, modes |

---

## Success Criteria

- [x] All 6 templates created
- [x] Each follows compressed format
- [x] dispatch-implement enforces EXPLOIT
- [x] Handoff template matches design
- [x] Placeholders clearly marked
