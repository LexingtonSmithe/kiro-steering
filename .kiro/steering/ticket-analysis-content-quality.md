---
inclusion: manual
---

# Ticket Analysis: Content Quality

You are reviewing whether the feature description and acceptance criteria are human-readable, unambiguous, and testable — and whether the ticket accounts for the full scope of what it implies.

**Data retrieval**: Always fetch tickets with all fields. Check the description AND dedicated custom fields (Acceptance Criteria, User Story, QA, etc.) — content may live in any of these.

---

## 1. Description Clarity

- Can someone unfamiliar with the codebase understand what this ticket is asking for?
- Is the problem or need stated in plain language?
- Is the desired outcome described in terms of what the user experiences (not what the code does)?
- Are there ambiguous terms that could be interpreted multiple ways?
- Is there unnecessary jargon or assumed context that isn't explained?

---

## 2. Why Field (User Story or Problem Statement)

Different ticket types use different fields to explain why the work matters.

**Stories — User Story field** (As a / I want / So that):
- Is the actor a recognised user type? (Customer, Client, Client Manager, Client Ops, Customer Service, Developer, System)
- If the actor is a ticket-specific role label (e.g. "Requester", "Approver"), flag as ⚠️ unless the ticket or parent explicitly defines the mapping.
- Is the desire stated clearly?
- Is the value/outcome meaningful (not just restating the desire)?

**Tasks — Problem Statement field**:
- Does it describe an actual problem (not just restate the solution)?
- Who or what is affected?
- What is the impact? (Performance, cost, risk, manual effort, data quality)
- Could someone unfamiliar with the codebase understand why this work matters?
- **Scoring**: ✅ = problem clear, impact stated, affected party identified. ⚠️ = problem implied but not explicit. ❌ = empty, or restates the solution.

**If no dedicated field exists**, check the description. The principle applies regardless of where the "why" lives. If it exists in the wrong field, flag as misplaced.

---

## 3. Acceptance Criteria — Quality

- Does every criterion have a clear pass/fail condition?
- Could someone verify each criterion without asking clarifying questions?
- Is the language specific enough to test but not so prescriptive it dictates implementation?
- Do any criteria conflict with each other?
- Do the AC imply a sequence that isn't stated? If order matters, it should be explicit.

**The key test**: "Could two people independently verify this and agree on whether it passes?" If not, it's ambiguous.

**Format guidance**: Simple declarative statements are fine when unambiguous. Use Given/When/Then when the criterion has conditional logic or multiple contexts.

**Description is not AC**: Information in the description provides context but does NOT count as acceptance criteria. If the description mentions 3 scenarios but the AC only covers 1, that's a gap.

---

## 4. Acceptance Criteria — Completeness (Implied Rules)

The AC may be well-written for what they cover but still leave critical behaviours unspecified. Probe for gaps:

| Lens | Question to ask |
|------|----------------|
| **State preconditions** | What states can the entity be in BEFORE this action? Does each valid starting state have coverage? |
| **Boundary rejection** | Every "when X, do Y" implies "when NOT X, reject." Are invalid states/inputs addressed? |
| **Concurrent actors** | Could another user or process modify the same entity simultaneously? (Note: Implementation & Test checks whether the *proposed approach* handles this. This skill checks whether the *AC specify* the expected behaviour.) |
| **Downstream effects** | Does the action trigger side effects not mentioned? (Notifications, recalculations, status changes on related entities) |
| **Partial success** | If the operation has multiple steps, what happens if step 2 fails after step 1 succeeded? |
| **Repeat/replay** | What if the same action is triggered twice? Is it idempotent? Does it duplicate? |
| **Temporal rules** | Are there time-based constraints? (Deadlines, cooldown periods, expiry) |
| **Data lifecycle** | What happens to the data over time? Cleanup, archival, retention? |

When you identify an implied rule with no AC coverage, surface it as a question:

> "The AC covers updating a plan, but doesn't address what happens when the plan is already completed. Should updates be rejected? Silently ignored? This needs a decision."

---

## 5. Adjacent Feature Detection

Beyond missing AC *within* the ticket, check whether the ticket implies companion features that should exist somewhere in the backlog — features a user would reasonably expect alongside this one.

| Lens | Examples |
|------|----------|
| **Inverse operations** | Create → delete. Subscribe → unsubscribe. Sign in → sign up, sign out, forgot password |
| **Lifecycle companions** | Start → cancel, complete, expire. Setup recurring → edit, stop |
| **Access paths** | Detail view → list/search that navigates to it. Create data → view that displays it |
| **Recovery flows** | Payment → refund. Submit → amend/correct. Lock → unlock |
| **Notification pairs** | Confirmation → reminder for non-completion. Failure alert → resolution notification |
| **Admin/support counterpart** | Customer action → can support see it, intervene, undo it? |

**How to check**: Fetch sibling tickets under the same epic. Check linked tickets. If the adjacent feature exists and is linked — no finding. If it exists but isn't linked — flag the missing link. If it doesn't appear to exist anywhere — flag as a backlog gap:

> "This ticket implements sign-in, but no ticket exists under the same epic for sign-up, forgot password, or sign-out. Are these out of scope, handled elsewhere, or missing from the backlog?"

**Important**: This is an observation, not a demand. Adjacent features might be intentionally deferred, owned by another team, or out of scope. The point is to surface it so the team can confirm.

---

## 6. Specification vs Expectation

The AC may be individually clear and testable, but still specify *less* than what the ticket's own context promises. This section checks whether the specification is proportional to the stated goal.

**Three sources of expectation to compare against:**

| Source | How to check |
|--------|-------------|
| **User Story / Problem Statement** | Does the stated value ("so that I can manage my bookings") require more than what the AC deliver? If the user needs to "make decisions" but the page only shows a reference number and a date, the AC don't fulfil the promise |
| **Parent Epic context** | What does the epic say this feature should achieve? If the epic describes a "comprehensive booking overview" but the ticket specifies 3 fields, there's a gap between initiative intent and ticket delivery |
| **Product patterns** | Does the product already have similar pages or features? If existing dashboards in the same product display status, dates, actions, financial summary, and participant info — and this new dashboard only specifies a title and a date — that's a signal. Not necessarily wrong, but worth questioning |

**How to assess:**

1. Read the User Story's "so that" clause. List what the user would need to see/do to achieve that stated outcome.
2. Read the parent Epic's outcomes or objectives. List what this ticket should contribute.
3. If available, check sibling tickets or existing product areas for convention.
4. Compare those expectations against what the AC actually specify.

**Findings are questions, not demands:**

> "The user story states 'so that I can track my booking status and upcoming payments.' The AC specify a booking reference and event date, but don't mention payment status, next payment date, or booking state. Are these intentionally deferred, or should they be included?"

> "The parent epic describes 'a granular report showing completion status per customer.' This ticket's AC cover displaying a form, but no ticket under this epic appears to cover reporting. Is reporting out of scope for this release?"

**Scoring:**
- ✅ = The AC deliver what the user story and context promise. No expectation gap.
- ⚠️ = The AC cover part of what's promised. The gap might be intentional (phased delivery) but isn't acknowledged.
- ❌ = The AC are clearly insufficient for the stated goal. The user story promises X but the ticket delivers a fraction of X with no explanation.

**Important**: A narrow ticket with a narrow user story is fine. The problem is a *broad* user story paired with *narrow* AC — the promise exceeds the delivery with no acknowledgement of the gap.

---

## 7. Assumptions

- Are there unstated assumptions about how the system currently works?
- Are there assumptions about user behaviour that aren't validated?
- Are there assumptions about data states that might not always be true?
- If assumptions are stated, are they marked as confirmed or unconfirmed?

---

## 8. Sub-task Content

Sub-tasks are slices of a parent Story or Task. They should define their own boundary, not duplicate the parent:

- **Input**: What does this sub-task receive or depend on?
- **Output**: What does this sub-task produce?
- **Done conditions**: How do you know THIS slice is complete — independent of the parent?
- **Out of scope**: What does this sub-task explicitly NOT cover?
- **Dependencies**: Which other sub-tasks or tickets must complete first?

**Flags**: Duplicates parent. No boundary defined. Meaningless without reading parent. Contradicts parent's user story.

---

## Flags to Raise

- **Ambiguous language**: "improve", "better", "aligned with", "as expected" without definition
- **Implementation masquerading as requirement**: "Add a column to the database" instead of "The report shows commission values"
- **Missing error states**: Happy path only, no mention of what happens when things go wrong
- **Untestable criteria**: "It should work well" / "The UX should be good"
- **Assumed context**: References to systems, flows, or decisions without explanation or links
- **Stale content**: Open questions that should have been answered, TODO markers, placeholder text
- **Contradictory criteria**: Two AC that cannot both be true simultaneously
- **Missing undo consideration**: Irreversible action with no acknowledgement that it's intentional
- **Notification volume uncapped**: Feature sends communications with no throttling consideration
- **Missing adjacent features**: Logical companions not present in backlog or linked tickets

---

## Scoring

| Score | Meaning |
|-------|---------|
| ✅ Pass | Someone could write test cases from this alone, with no questions |
| ⚠️ Needs Work | Intent is clear but at least one clarifying question is needed before testing |
| ❌ Missing | No criteria exist, or what's written is untestable |

Always explain WHY — don't just mark the score. State what makes it pass, what's missing, or what question remains.

---

## Output

```
## Content Quality Review

**Ticket**: [key]
**Fields checked**: Acceptance Criteria: [summary or "empty"]. Why field: [summary or "empty"].
**Score**: ✅ / ⚠️ / ❌

## Description Clarity
[Assessment]

## Why Field
[Assessment — User Story or Problem Statement, depending on type]

## Acceptance Criteria — Quality
| # | Criterion | Testable? | Issue |
|---|-----------|-----------|-------|
| AC1 | ... | ✅/⚠️/❌ | ... |

## Acceptance Criteria — Implied Rules
[Missing behaviours that need AC or explicit "out of scope" statement]

## Adjacent Features
[Companion features that should exist somewhere — present or missing?]

## Specification vs Expectation
[Does the AC deliver what the user story and parent context promise? Or is the promise broader than the specification?]

## Assumptions
[What's assumed? Confirmed or not?]

## Gaps & Ambiguities
[Specific unanswered questions]

## Suggested Rewrites (if needed)
[Improved criteria]
```
