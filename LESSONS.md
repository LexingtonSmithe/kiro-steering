# Lessons — How This Suite Was Built

This documents the iterative journey from first draft to current state. Each phase represents a calibration or design decision made through real-world use.

---

## Phase 1: Single Monolithic Skill

Started as a single "ticket health" skill applied across multiple boards. One pass per ticket, scoring everything at once.

**Result**: Produced broad findings but couldn't distinguish between "AC is missing" and "AC exists but is vague." Scored everything on a single axis.

**Key learning**: A monolithic skill tries to do too much in one pass. Different concerns (content quality, type correctness, release readiness) need different lenses.

## Phase 2: Improved Single Skill

Same single-skill approach but with a revised framework. Tighter scoring criteria, more dimensions assessed.

**Result**: Better output but still suffered from trying to assess everything simultaneously. The skill was too long and the agent would lose focus on later dimensions.

**Key learning**: Improving the prompt helps but doesn't solve the structural problem. The skill needs splitting.

## Phase 3: Separated Skills

Split the monolithic skill into 10 focused skills, each with its own lens. Applied all 10 to a real board's To Do column (37 tickets).

**Result**: Significantly better findings. Each skill could go deep on its concern without being distracted by others. Produced the first actionable board-level health report.

**Key learning**: Separation works. But the skills were only reading the `description` field — they missed content in custom fields entirely.

## Phase 4: Correction Skill

Added a "propose corrections" skill that generates safe improvements based on existing ticket content.

**Result**: Produced useful proposals (AC rewrites, description synthesis, cascade from parent Epic). But presented recommendations as a flat list — contradictory proposals weren't structured.

**Key learning**: Proposals need hierarchy (primary → fallback → apply regardless). A flat list creates wasted effort when one recommendation supersedes another.

## Phase 5: The Major Flaw — Field Reading

Discovered that all previous iterations were only reading the `description` field. The dedicated Acceptance Criteria and User Story custom fields were being ignored entirely.

**Impact**: Every ticket scored as "❌ Missing AC" when many actually had detailed AC in the dedicated field. The entire board-level assessment was wrong.

**Fix**: Added mandatory field verification — before scoring ❌, the agent must explicitly state what the AC and User Story fields contain. Added re-fetch requirement for batch analysis.

**Key learning**: "Fetch with all fields" isn't enough if the agent doesn't actually read the response carefully. Verification must be enforced in the output format.

## Phase 6: Fine Tuning

Systematic correction of biases, gaps, and inconsistencies discovered through testing:

| Issue found | Fix applied |
|-------------|-------------|
| Sub-task User Stories scored as ✅ when they contradicted the parent | Added rule: sub-tasks don't need User Stories; flag contradictions |
| Only one ticket flagged as "too large" (bias from conversation context) | Applied splitting criteria objectively to all tickets |
| Hardcoded custom field IDs made skills project-specific | Replaced with field discovery by purpose/name |
| Propose corrections didn't check for duplicate siblings before splits | Added duplicate check requirement |
| AC rewrites presented alongside split recommendations (contradictory) | Added structuring rules: primary → fallback → apply regardless |
| "Analyse" interpreted inconsistently | Clarified: "analyse" = full suite, named skills = just those |
| Problem Statement field (Tasks) had no validation criteria | Added distinct validation: problem, affected party, impact, cause |
| User Story actors used role labels without mapping to real user types | Added actor check against recognised user types |
| Proposed descriptions could be synthesised from AC + User Story | Added as capability in propose corrections |

**Key learning**: Skills need to be project-agnostic, bias-resistant, and self-verifying. Every rule added came from a real failure observed during testing.

## Phase 7: Calibration Through Feedback

Applied the suite to real sprint work and calibrated based on false positives:

- Scored "gracefully handled" as ✅ when it's ambiguous → added weasel phrase detection
- Flagged unassigned tickets as a risk → learned assignment is intentional pre-dev → added global ignore rule
- Tightened the false positive test: "Could someone unfamiliar with this ticket act on it without asking a single clarifying question?"
- Added implied rules detection (state preconditions, boundary rejection, concurrent actors, partial success, replay)
- Added adjacent feature detection (inverse operations, lifecycle companions, recovery flows)
- Added specification vs expectation (does the AC deliver what the user story promises?)

## Phase 8: From Analysis to Conversation

The full suite is thorough but heavy. Teams found it more useful as reference material than as a live workflow tool.

Introduced the **Spark**: a ~30-line output that surfaces only questions and gaps. No scoring, no explanations, no suggested rewrites. The team reasons independently; the tool catches what they might have missed.

The insight: **you can't LGTM on a bunch of questions.** A finding requires acknowledgement. A question requires an answer. Questions force engagement in a way that findings don't.

The Spark runs at two checkpoints (post-PO write-up and post-refinement) and preserves the team's ownership of their process while providing a systematic safety net.

## Phase 9: Report Modes, Organisation, and Sprint Patterns

- Reorganised the suite by purpose (Workflow / Deep Dive / Housekeeping) rather than by skill name
- Added two report modes: **Full report** (everything) and **Gaps only** (just issues, no noise)
- Added **Sprint Retro** skill — analyses all tickets in a sprint for recurring patterns with sprint-over-sprint comparison
- Genericised for publication — removed all company-specific references without impacting quality
- Established naming conventions: `ticket-analysis-*` (ticket-level), `sprint-analysis-*` (sprint-level), `ticket-analysis-suite-*` (orchestration)

---

## Key Principles (emerged over time)

- **Quality over presence** — never "is this field populated?" always "is this good enough to act on?"
- **Board-agnostic** — discover fields dynamically, never hardcode IDs
- **Lifecycle-aware** — same gap is informational in backlog, critical at release
- **No auto-writes** — proposals only, human decides
- **Verification before ❌** — must state field contents before scoring missing
- **Trust the team** — surface questions, don't dictate answers
- **Aggregate over enumerate** — patterns matter more than individual findings
- **Questions over findings** — questions force decisions, findings allow deferral
- **No bias** — output identical regardless of who runs it or what's been discussed in context
- **Structured recommendations** — primary → fallback → apply regardless
- **Distinct validation by type** — Stories use User Story, Tasks use Problem Statement, Bugs need reproduction
