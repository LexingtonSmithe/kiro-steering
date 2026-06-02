---
inclusion: manual
---

# Ticket Analysis: Content Quality

You are reviewing whether the feature description and acceptance criteria are human-readable, unambiguous, and testable.

**Data retrieval**: Always fetch tickets with all fields. Check the description AND dedicated custom fields (Acceptance Criteria, User Story, QA, etc.) — content may live in any of these. Never assume AC are only in the description.

## What to check

### Description Clarity

- Can someone unfamiliar with the codebase understand what this ticket is asking for?
- Is the problem or need stated in plain language?
- Is the desired outcome described in terms of what the user experiences (not what the code does)?
- Are there ambiguous terms that could be interpreted multiple ways?
- Is there unnecessary jargon or assumed context that isn't explained?

### "Why" Field (User Story or Problem Statement)

Different ticket types use different fields to state why the work is needed. Check the appropriate one:

**Stories — User Story field** (As a / I want / So that):
- Is the actor a recognised user type? (Customer, Client, Client Manager, Client Ops, Customer Service, Developer, System)
- If the actor is a ticket-specific role label (e.g. "Requester", "Approver", "Admin"), flag as ⚠️ unless the ticket or parent explicitly defines the mapping.
- Is the desire stated clearly?
- Is the value/outcome meaningful (not just restating the desire)?

**Tasks — Problem Statement field**:
- Does it describe an actual problem (not just restate the solution)?
- Who or what is affected? (System, team, users, process)
- What is the impact? (Performance, cost, risk, manual effort, data quality)
- Does it state or hint at a cause?
- Could someone unfamiliar with the codebase understand why this work matters?
- **Scoring**: ✅ = problem clear, impact stated, affected party identified. ⚠️ = problem implied but not explicit, or impact missing. ❌ = empty, or restates the solution rather than the problem.

**If no dedicated "why" field exists on the board**, check the description. The principle (is the "why" stated and clear?) applies regardless of where it lives.

**If the "why" exists in the wrong field** (e.g. problem statement in a comment, User Story in the description), flag as misplaced.

### Acceptance Criteria

- Does every criterion have a clear pass/fail condition?
- Could someone verify each criterion without asking clarifying questions?
- Are happy path, error states, and edge cases covered?
- Is the language specific enough to test but not so prescriptive it dictates implementation?
- **Contradictions**: Do any criteria conflict with each other?
- **Implicit ordering**: Do the AC imply a sequence that isn't stated? If order matters, it should be explicit.

**Format guidance:**

Simple declarative statements are fine when unambiguous:
> "The customer can only select dates in the future"

Use Given/When/Then when the criterion has conditional logic or multiple contexts:
> Given a basket contains a child ticket but no adult ticket,
> When the customer attempts to proceed to checkout,
> Then the error message is displayed and checkout is blocked

**The key test**: "Could two people independently verify this and agree on whether it passes?" If not, it's ambiguous.

**Scoring guidance — don't confuse brevity with clarity**:
- ✅ means: someone could write a test case from this criterion alone, with no questions
- ⚠️ means: the intent is clear but you'd need to ask at least one clarifying question before testing
- ❌ means: no criteria exist, or what's written is untestable ("it should work well")

**Description is not AC**: Information in the description provides context but does NOT count as acceptance criteria. If the description mentions 3 scenarios but the AC only covers 1, that's a gap.

### Assumptions

- Are there unstated assumptions about how the system currently works?
- Are there assumptions about user behaviour that aren't validated?
- Are there assumptions about data states that might not always be true?
- If assumptions are stated, are they marked as confirmed or unconfirmed?

### Completeness

- Are there obvious questions left unanswered?
- Are there open questions or TODOs still in the description that should have been resolved?
- If designs or wireframes are referenced, are they linked (not just mentioned)?
- Is the scope clear — what's included AND what's explicitly out of scope?
- **Negative testing gap**: What happens if the user does nothing? (timeouts, abandoned flows, session expiry)
- **Undo/reversibility**: Can the user undo what this feature lets them do? If not, is that intentional?
- **Notification fatigue**: If this sends emails/notifications, what's the volume? Is there throttling?
- **Temporal assumptions**: Does the ticket assume "now" means something specific? (Timezone? "Next available" from when?)
- **State transitions**: What states can the entity be in? Are all valid transitions covered? Are invalid transitions blocked?

### Sub-task Content

Sub-tasks are slices of a parent Story or Task. They should NOT duplicate the parent's goal or AC. Instead, a sub-task should define its own boundary:

- **Input**: What does this sub-task receive or depend on?
- **Output**: What does this sub-task produce?
- **Done conditions**: How do you know THIS slice is complete — independent of the parent's overall AC?
- **Out of scope**: What does this sub-task explicitly NOT cover?
- **Dependencies**: Which other sub-tasks or tickets must be complete first?

**Flags to raise for sub-tasks:**
- **Duplicates parent**: Restates the parent's description or AC rather than defining its own slice
- **No boundary**: Doesn't clarify where its responsibility starts and ends
- **Meaningless alone**: Cannot be understood without reading the parent
- **Contradictory User Story**: Sub-tasks don't need their own User Story — the "why" lives on the parent. A populated User Story field on a sub-task is neutral at best. If it contradicts the parent's stated user/value, flag as ⚠️.

## Flags to raise

- **Ambiguous language**: "improve", "better", "aligned with", "as expected" without definition
- **Implementation masquerading as requirement**: "Add a column to the database" instead of "The report shows commission values"
- **Missing error states**: Happy path only, no mention of what happens when things go wrong
- **Untestable criteria**: "It should work well" / "The UX should be good" / "It should be fast"
- **Assumed context**: References to systems, flows, or decisions without explanation or links
- **Stale content**: Open questions that should have been answered, TODO markers, placeholder text
- **Contradictory criteria**: Two AC that cannot both be true simultaneously
- **Unconfirmed assumptions**: Assumptions stated but not marked as validated
- **Missing undo consideration**: Irreversible action with no acknowledgement that it's intentional
- **Notification volume uncapped**: Feature sends communications with no throttling or volume consideration

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. State what makes it pass, what's missing, or what question remains unanswered.

```
## Content Quality Review

**Ticket**: [key]
**Fields checked**: Acceptance Criteria: [summary or "empty"]. Why field: [summary or "empty"].
**Score**: ✅ / ⚠️ / ❌

## Description Clarity
[Assessment — is it readable and unambiguous?]

## Why Field
[Assessment — User Story or Problem Statement, depending on type]

## Acceptance Criteria
[Assessment — are they testable with clear pass/fail?]

| # | Criterion | Testable? | Issue |
|---|-----------|-----------|-------|
| AC1 | ... | ✅/❌ | ... |
| AC2 | ... | ✅/❌ | ... |

## Assumptions
[What's assumed? Is it confirmed?]

## Gaps & Ambiguities
[Specific questions that remain unanswered or terms that need defining]

## Suggested Rewrites (if needed)
[Improved criteria — simple statements where unambiguous, Given/When/Then where conditional]
```
