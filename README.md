# Ticket Analysis Suite — Kiro Steering Skills

A modular set of Jira ticket analysis skills for [Kiro](https://kiro.dev), designed to bring structured quality review to backlog items, sprint work, and epics — without requiring manual QA involvement at every stage.

## What This Is

A collection of 14 steering files that teach Kiro how to analyse Jira tickets across multiple quality dimensions. Each skill focuses on a specific aspect of ticket health and can be run independently or combined into a full-suite review.

The skills are board-agnostic — they discover custom fields dynamically and adapt to whatever Jira configuration they encounter.

## The Journey

This suite was built iteratively through real-world use:

1. **Started with structured analysis** — individual skills for type correctness, content quality, INVEST readiness, and value measurement.
2. **Calibrated through feedback** — early runs revealed false positives (scoring "gracefully handled" as ✅ when it's ambiguous). Each miss became a new calibration rule, like the weasel phrase detection list.
3. **Removed noise** — assignment status was initially flagged as a risk. Learned that pre-dev tickets are intentionally unassigned in most workflows. Added a global rule to ignore it.
4. **Tightened the false positive test** — the core question became: "Could someone unfamiliar with this ticket act on it without asking a single clarifying question?" If the answer is no, it's not a pass.
5. **Genericised for publication** — removed all company-specific references (internal tool names, team names, org-specific suppressions) without impacting analysis quality.
6. **Added implied rules and adjacent feature detection** — the skill now probes for what's unwritten (state preconditions, boundary rejection, concurrent actors) and checks for companion features that logically must exist (inverse operations, lifecycle companions, recovery flows).
7. **Added specification vs expectation** — checks whether the AC deliver what the user story promises. A broad user story paired with narrow AC gets flagged as an expectation gap.
8. **Shifted from analysis to conversation** — the full suite is thorough but heavy. Teams found it more useful as reference material than as a live workflow tool. Phase 8 introduced the Spark: a ~30-line output designed to galvanise discussion rather than do the team's thinking for them. The Spark runs at two checkpoints (post-PO write-up and post-refinement) and surfaces only decisions and gaps — no scoring, no explanations, no suggested rewrites. The team reasons independently; the tool catches what they might have missed. This preserves the team's ownership of their process while providing a systematic safety net.

## Skills

| Skill | File | Purpose |
|-------|------|---------|
| Index | `ticket-analysis-index.md` | Orchestration guide, scoring philosophy, global rules |
| Type Correctness | `ticket-analysis-type-correctness.md` | Validates issue type and hierarchy/split |
| Content Quality | `ticket-analysis-content-quality.md` | Description, AC, and user story clarity |
| INVEST | `ticket-analysis-invest.md` | Sprint readiness check |
| Value & Measurement | `ticket-analysis-value-measurement.md` | Epic hypothesis, ticket contribution, success criteria |
| Implementation & Test | `ticket-analysis-implementation-test.md` | Dev/test approach alignment with AC |
| Release & Operations | `ticket-analysis-release-operations.md` | Dependencies, toggles, monitoring, rollback |
| Quality Attributes | `ticket-analysis-quality-attributes.md` | Non-functional requirements (performance, security, a11y) |
| Documentation | `ticket-analysis-documentation.md` | Doc links and quality of referenced docs |
| Bugs | `ticket-analysis-bugs.md` | Dedicated bug assessment framework |
| Spikes | `ticket-analysis-spikes.md` | Time-box, output, scope, success criteria |
| Spark | `ticket-analysis-spark.md` | Lightweight checkpoint — run post-write-up and post-refinement to galvanise discussion |
| Sprint Retro | `sprint-analysis-retro.md` | Sprint-level quality patterns with sprint-over-sprint comparison |
| Propose Corrections | `ticket-propose-corrections.md` | Safe corrections from existing content (propose only) |
| Formatting | `ticket-analysis-formatting.md` | Structural consistency and field placement |

## How to Use

### Setup

1. Copy the `.kiro/steering/` directory into your workspace
2. All skills use `inclusion: manual` — activate them via `#skill-name` in Kiro chat

### Single Ticket Review

Activate the index and one or more skills:

```
#ticket-analysis-index
#ticket-analysis-content-quality

Analyse SN-1234
```

### Full Suite Review

```
#ticket-analysis-index

Full suite analysis on PROJ-567
```

The index guides skill selection based on ticket type (bugs route to the bug skill, spikes to the spike skill, etc.).

### Epic + Children

```
#ticket-analysis-index

Analyse PROJ-100 and all child tickets
```

## Requirements

- **Kiro** with Jira MCP integration configured
- **Jira access** to the boards you want to analyse
- Optionally, **Confluence** access if you want results posted to wiki pages

## Design Principles

- **Quality over presence** — the question is never "is this field populated?" but "is this good enough to act on without questions?"
- **Board-agnostic** — discovers fields dynamically rather than hardcoding IDs
- **Lifecycle-aware** — the same gap is informational in backlog, concerning in sprint, critical at release
- **No auto-writes** — the Propose Corrections skill generates proposals but never writes to Jira without human approval
- **Calibrated scoring** — weasel phrases, ambiguous AC, and false positives are caught by explicit rules

## Customisation

The skills are designed to be extended. Common customisations:

- **Add role-specific actors** to the content quality skill's user story validation
- **Add known documentation gaps** to suppress in the documentation skill (things your org knows are missing and doesn't want flagged per-ticket)
- **Adjust severity framing** if your workflow statuses differ from the defaults
- **Add weasel phrases** to the index as you discover them in your team's tickets

## License

MIT — use it, fork it, adapt it.
