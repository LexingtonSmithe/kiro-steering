# Lessons — How This Suite Was Built

This documents the iterative journey from first draft to current state. Each phase represents a calibration or design decision made through real-world use.

---

## Phase 1: Structured Analysis

Started with individual skills for type correctness, content quality, INVEST readiness, and value measurement. Each skill checks one dimension of ticket quality independently.

## Phase 2: Calibration Through Feedback

Early runs revealed false positives — scoring "gracefully handled" as ✅ when it's ambiguous. Each miss became a new calibration rule. This led to the weasel phrase detection list: phrases that *feel* specific but don't define observable behaviour.

## Phase 3: Noise Removal

Assignment status was initially flagged as a risk. Learned that pre-dev tickets are intentionally unassigned in most workflows — assignment happens when work begins. Added a global rule to ignore it entirely.

## Phase 4: False Positive Tightening

The core question became: "Could someone unfamiliar with this ticket act on it without asking a single clarifying question?" If the answer is no, it's not a pass — regardless of how confident the surrounding context makes it feel.

## Phase 5: Genericisation

Removed all company-specific references (internal tool names, team names, org-specific suppressions) without impacting analysis quality. The skills work against any Jira board with any field configuration.

## Phase 6: Implied Rules and Adjacent Features

The skill now probes for what's unwritten:
- **Implied rules**: state preconditions, boundary rejection, concurrent actors, partial success, replay/idempotency, temporal rules, data lifecycle
- **Adjacent features**: inverse operations, lifecycle companions, access paths, recovery flows, notification pairs, admin counterparts

## Phase 7: Specification vs Expectation

Checks whether the AC deliver what the user story promises. A broad user story paired with narrow AC gets flagged as an expectation gap. Also compares against product patterns and parent epic context.

## Phase 8: From Analysis to Conversation

The full suite is thorough but heavy. Teams found it more useful as reference material than as a live workflow tool.

Introduced the **Spark**: a ~30-line output that surfaces only questions and gaps. No scoring, no explanations, no suggested rewrites. The team reasons independently; the tool catches what they might have missed.

The insight: **you can't LGTM on a bunch of questions.** A finding requires acknowledgement. A question requires an answer. Questions force engagement in a way that findings don't.

The Spark runs at two checkpoints (post-PO write-up and post-refinement) and preserves the team's ownership of their process while providing a systematic safety net.

## Phase 9: Report Modes and Organisation

Reorganised the suite by purpose (workflow tools, deep dives, housekeeping) rather than by what each skill checks. Added two report modes for deep dives:
- **Full report**: everything — what's good, what's bad, and why
- **Gaps only**: just the issues, no commentary on what passes — reduces noise for teams that only want action items

---

## Key Principles (emerged over time)

- **Quality over presence** — never "is this field populated?" always "is this good enough to act on?"
- **Board-agnostic** — discover fields dynamically, never hardcode IDs
- **Lifecycle-aware** — same gap is informational in backlog, critical at release
- **No auto-writes** — proposals only, human decides
- **Trust the team** — surface questions, don't dictate answers
- **Aggregate over enumerate** — patterns matter more than individual findings
- **Questions over findings** — questions force decisions, findings allow deferral
