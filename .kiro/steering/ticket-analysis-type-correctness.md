---
inclusion: manual
---

# Ticket Analysis: Type Correctness

You are reviewing whether a Jira ticket is correctly typed and whether the work is split appropriately across its linked tickets and hierarchy.

## What to do

1. **Fetch the ticket** and note its current type
2. **Find the parent Epic** — follow the "Finding the Parent Epic" procedure in the index (`#ticket-analysis-suite-index`)
3. **Fetch linked tickets** — child tickets, blockers, related issues, sibling stories under the same Epic
4. **Assess the type** against these definitions
5. **Assess the split** by reviewing the hierarchy

## Type Definitions

- **Story**: Delivers value to an end user (Customer, Client, Client Ops, Customer Service). Written from the user's perspective. "New Feature" types are Stories until they grow large enough to become an Epic.
- **Task**: Technical or operational work that doesn't directly deliver user value but is necessary for progress. The "user" is a developer or internal team member.
- **Bug**: Expected behaviour does not match actual behaviour. Defer to `#ticket-analysis-bugs` skill.
- **Sub-Task**: Breaks down a parent into actionable steps. Does not deliver value on its own.
- **Epic**: A grouping ticket only. No work or code changes should be attributed directly to it.
- **Spike**: Time-boxed investigation with a defined output. Defer to `#ticket-analysis-spikes` skill for quality assessment.

## Assessing the Split

Review linked tickets and ask:

- Is work that should be separate tickets bundled into one? (too large, multiple concerns)
- Is work that should be one ticket fragmented across many? (sub-tasks that don't make sense alone)
- Are there missing tickets in the hierarchy? (e.g. an Epic with Stories but a gap in the flow)
- Does the parent Epic make sense as a grouping? Is work attributed directly to it that shouldn't be?
- Are dependencies correctly represented? (blockers linked, not just mentioned in text)
- Do sub-tasks carry enough context to be understood without reading the parent?

## Flags to raise

- **Wrong type**: The ticket describes user-facing value but is typed as Task (should be Story), or describes a defect but is typed as Task (should be Bug)
- **Too large**: The ticket contains multiple distinct pieces of value that should be separate Stories. If a Story grows too large, recommend promoting to Epic with child Stories.

### Splitting Criteria

When assessing whether a ticket should be split, ask these questions:

**Keep as one ticket when ALL are true:**
- Serves a single user goal
- Within a single context (app, page, or endpoint)
- Shares a consistent business rule set
- Changes are tightly coupled and not independently meaningful
- Can be delivered and tested as one coherent unit

**Split when differences exist in:**
- **Different purpose** — each part serves a different user goal or outcome
- **Different rules or logic** — different validation, business logic, or edge cases even if the UI is similar
- **Different lifecycle or ownership** — different teams, delivery cadence, or risk profiles
- **Different testability** — one part can be tested independently, another depends on external systems
- **Different failure modes** — a defect in one area should not block or impact the other

**Rule of thumb**: If one part were removed, would the remaining work still be a complete and meaningful increment? If yes, split it.

**Anti-pattern**: Don't split purely on technical boundaries (frontend vs backend, different endpoints, different components). Split on product boundaries — can each part be understood, tested, and delivered independently without relying on the other to make sense?

- **Orphaned**: The ticket has no parent Epic but clearly belongs to a larger initiative
- **Misplaced work**: Code changes or implementation detail attributed to an Epic
- **Missing links**: Dependencies mentioned in description but not linked in Jira
- **Fragmented**: Sub-tasks that are meaningless without reading the parent — they should carry enough context to be understood alone
- **Duplicate scope**: Two linked tickets that cover the same ground — recommend merging, closing one, or clarifying the boundary between them

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. State what makes it pass, what's missing, or what question remains unanswered.

```
## Type Correctness Review

**Ticket**: [key]
**Current type**: [type]
**Recommended type**: [same / different + reason]
**Score**: ✅ / ⚠️ / ❌

## Hierarchy & Split

**Parent**: [Epic key + title, or "None (orphaned)"]
**Linked tickets reviewed**: [list of keys]

| Issue | Finding |
|-------|---------|
| ... | ... |

## Recommendations

[Specific actions: retype, split, link, merge, clarify boundaries]
```
