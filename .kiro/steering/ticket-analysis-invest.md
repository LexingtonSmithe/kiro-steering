---
inclusion: manual
---

# Ticket Analysis: INVEST

You are performing a post-refinement check to validate that a ticket meets INVEST criteria before it enters a sprint. This skill should NOT be used for work already in sprint — negotiations and estimates should already be provided by that point.

## When to use

- After refinement, before sprint planning
- When reviewing a backlog for sprint readiness
- NOT for tickets already committed to a sprint

## What to check

### Independent

- Can this ticket be delivered without waiting for other incomplete work?
- If there are dependencies, are they already done or can they be worked around?
- Could this be released on its own without breaking anything?
- Can this be **tested** independently? (Different from delivery — can QA verify this without other tickets being complete?)

Both delivery independence and test independence should be true.

### Negotiable

- Is the ticket specifying WHAT and WHY without dictating HOW?
- Is there room for the team to discuss implementation approach?
- Or is it over-specified with implementation detail that constrains the solution?

**Exception**: Some tickets SHOULD be prescriptive — security fixes, compliance requirements, exact copy changes, specific API contracts agreed with consumers. Flag over-specification only when the constraint isn't justified.

### Valuable

- Does this deliver clear value to a user or the business?
- Could you explain to a stakeholder why this matters in one sentence?
- If removed from the sprint, would anyone notice or care?

### Estimable

- Have reasonable steps been taken to remove unknowns?
- Is the work moderately well understood by the team?
- Are there remaining unknowns that would make estimation unreliable? (If so, it needs a Spike first)
- Has the team acknowledged the scope? (Doesn't need to be formally pointed — but the team should have discussed it)

Note: Teams use story points but relative size guides differ between teams. The check here is not "does it have points" but "has the team understood the work well enough to commit to it."

### Small

- Is this completable within a single sprint?
- If it spans multiple sprints, should it be split?
- Could a single developer pick this up and finish it without needing to hand off?

### Testable

- Are there clear conditions that allow pass/fail verification?
- Could QA write test cases from the acceptance criteria alone?
- Is "done" unambiguous — would two people agree on whether it's complete?

## Flags to raise

- **Blocked**: Depends on incomplete work with no workaround
- **Over-specified**: Implementation dictated without justification, no room for team discussion
- **No clear value**: Technical work with no connection to user or business outcome
- **Unestimable**: Too many unknowns — needs a Spike
- **Too large**: Multiple sprints of work — needs splitting
- **Untestable**: No clear done state — "improve X" with no definition of improved
- **Test-dependent**: Can be delivered independently but cannot be tested without other work

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. State what makes it pass, what's missing, or what question remains unanswered.

```
## INVEST Review

**Ticket**: [key]
**Score**: ✅ / ⚠️ / ❌
**Sprint ready**: Yes / No

| Criterion | Pass | Notes |
|-----------|------|-------|
| Independent | ✅/❌ | ... |
| Negotiable | ✅/❌ | ... |
| Valuable | ✅/❌ | ... |
| Estimable | ✅/❌ | ... |
| Small | ✅/❌ | ... |
| Testable | ✅/❌ | ... |

## Blockers to Sprint Entry
[What needs resolving before this can be committed to]
```
