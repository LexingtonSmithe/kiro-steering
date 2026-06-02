---
inclusion: manual
---

# Ticket Analysis Suite — Index

This is the orchestration guide for the ticket analysis skill suite.

## Available Skills

| Skill | Activation | Purpose |
|-------|-----------|---------|
| Type Correctness | `#ticket-analysis-type-correctness` | Reviews type AND hierarchy/split across linked tickets |
| Content Quality | `#ticket-analysis-content-quality` | Validates description + AC are readable, unambiguous, testable |
| INVEST | `#ticket-analysis-invest` | Sprint readiness check (not for work already in sprint) |
| Value & Measurement | `#ticket-analysis-value-measurement` | Reviews Epic hypothesis + ticket contribution + success criteria |
| Implementation & Test | `#ticket-analysis-implementation-test` | Checks proposed dev/test approach aligns with AC and value |
| Release & Operations | `#ticket-analysis-release-operations` | Dependencies, toggles, monitoring, ops readiness, rollback |
| Quality Attributes | `#ticket-analysis-quality-attributes` | Flags relevant non-functional attributes that are unaddressed |
| Documentation | `#ticket-analysis-documentation` | Checks for doc links and assesses quality of linked docs |
| Bugs | `#ticket-analysis-bugs` | Dedicated bug assessment (repro, impact, expected/actual, evidence) |
| Spikes | `#ticket-analysis-spikes` | Validates time-box, output definition, scope, success criteria |
| Pre-Refinement | `#ticket-analysis-prerefinement` | Surfaces questions, gaps, and focus areas before a refinement session |
| Propose Corrections | `#ticket-propose-corrections` | Generates safe corrections from existing ticket content — propose only, never auto-apply |
| Formatting | `#ticket-analysis-formatting` | Checks structural consistency — AC numbering, field placement, duplication, readability |

---

## Data Retrieval

**Fetch all fields**: Always fetch tickets with `*all` fields. Never assume content only lives in the description — check ALL populated fields.

**Field discovery, not hardcoding**: Do not assume specific custom field IDs. Different projects use different field configurations. Identify fields by their purpose:

| Purpose | Look for fields named | Contains |
|---------|----------------------|----------|
| Acceptance Criteria | "Acceptance Criteria", "AC", "Definition of Done" | Testable pass/fail criteria |
| Why (Stories) | "User Story" | As a / I want / So that |
| Why (Tasks) | "Problem Statement", "What is the problem as a statement?", "Business Need" | Plain-language problem statement |
| Test/QA | "QA Notes", "Test Notes", "Test Plan" | Environment, test data, verification approach |
| Dev notes | "Implementation Notes", "Dev Notes", "Technical Approach" | Technical approach, considerations |

**First time on a new board**: Use Jira field search to identify relevant fields by keyword. Note which fields are populated and what they contain — this informs all subsequent analysis on that project.

**"Why" field varies by type**: Stories typically use a User Story field. Tasks typically use a problem statement field. Both explain why the work matters but require different validation. If neither exists, check the description — not every board has dedicated fields.

---

## Verification Before Scoring ❌

Before scoring ANY ticket as ❌ for "no AC", "title only", or "no content":

1. Explicitly state what the Acceptance Criteria field (or equivalent) contains
2. Explicitly state what the "why" field (or equivalent) contains
3. If either is "empty", say so. If they contain content, assess quality — do not score ❌.

Output must include:

> **Fields checked**: Acceptance Criteria: [content summary or "empty"]. Why field: [content summary or "empty"].

On batch analysis with large responses, re-fetch individual tickets to confirm field content before scoring ❌. Do not infer "empty" from a truncated or skimmed response.

---

## Assignment

**Do not factor in ticket assignment.** Tickets in "To Do" or pre-development statuses are typically unassigned or assigned to the author (which will change). Assignment happens when work begins. Never flag unassigned tickets as a risk, and never include assignment status in analysis summaries, risk registers, or recommendations.

---

## Scoring Philosophy

Every skill must assess **quality**, not just **presence**. The question is never "is this here?" — it's "is this good enough to act on without asking questions?"

| Score | Meaning | Requirement |
|-------|---------|-------------|
| ✅ Pass | Present AND sufficient to act on independently | State WHY it passes — what makes it actionable |
| ⚠️ Needs Work | Present but incomplete, ambiguous, or needs clarification | State WHAT is missing or unclear |
| ❌ Missing | Absent or so thin it provides no value | State WHAT should be there |

**The false positive test**: Before scoring ✅, ask: "Could someone unfamiliar with this ticket act on this information without asking a single clarifying question?" If no, it's ⚠️ at best.

**Concise ≠ unambiguous**: A short description that leaves questions unanswered is not "clear" — it's brief. Clarity means the reader knows exactly what to do, what to test, or what to expect.

**Weasel phrase detection**: The following phrases FEEL specific but are NOT. They describe intent without defining observable behaviour. Always score ⚠️ and explain what's missing:
- "gracefully handled" → What does the user see? Where? What state is preserved?
- "appropriate error message" → What message? Where displayed? What triggers it?
- "user-friendly" → By whose standard? What specifically makes it friendly?
- "properly validated" → What rules? What happens on failure?
- "handled correctly" → What does "correctly" look like to a tester?
- "seamless experience" → What specific interactions make it seamless?
- "intuitive UI" → What layout/flow/feedback makes it intuitive?

If an AC uses one of these phrases, it fails the false positive test regardless of how confident the surrounding context makes it feel.

**Examples**:
- "Stop users seeing old bookings" → ⚠️ (What does "stop seeing" mean? Error? Filter? Redirect? What's "old"?)
- "Errors are gracefully handled" → ⚠️ (What does the user see? Toast? Modal? Inline? Does form state persist? Is there a retry mechanism?)
- "Bookings created before 2023-01-01 are excluded from search results and return 404 on direct URL access" → ✅ (Specific behaviour, testable, no questions)
- "If submission fails, an error banner appears above the form, the form retains entered data, and the submit button remains enabled for retry" → ✅ (Observable, testable, no ambiguity)

---

## Ticket Type Routing

- **Bugs**: Use `#ticket-analysis-bugs`
- **Spikes**: Use `#ticket-analysis-spikes`
- **Stories / Tasks / Epics / Sub-tasks**: Use any combination of the general skills

---

## Severity Framing

When interpreting results, weight failures by lifecycle stage:

| Lifecycle stage | How to frame failures |
|----------------|----------------------|
| Backlog / newly created | Informational — "should be addressed before refinement" |
| Refined / ready for sprint | Concerning — "should have been caught during refinement" |
| In sprint / in progress | Serious — "actively creating risk right now" |
| Ready for release | Critical — "may cause issues in production" |

A missing documentation link on a backlog ticket is a note. The same gap on a ticket about to be released is a problem.

---

## Full Review

For a comprehensive review of a single ticket, start with Type Correctness (it determines which other skills are relevant) then run whichever combination makes sense for the context. There's no required order beyond that.
