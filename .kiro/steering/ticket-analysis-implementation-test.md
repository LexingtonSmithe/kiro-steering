---
inclusion: manual
---

# Ticket Analysis: Implementation & Test Readiness

You are reviewing whether the proposed development approach and test plan (provided in advance via notes, proposals, or pull request descriptions) indicate they will satisfy the acceptance criteria and business value. This checks that the planned HOW aligns with the WHAT.

**Important**: This skill reviews proposals and plans, not completed work. It assesses whether the intended approach will deliver the right thing, before work begins or during refinement.

## Data Retrieval (do not skip)

- Always fetch with `fields=*all` and `comment_limit=0`
- ACs, test plans, and "why" fields live in custom fields — they will NOT appear in default field fetches
- If the response looks thin (only summary/description/status), re-fetch before proceeding
- Never claim "no AC" without explicitly stating what the AC field contains

---

## What to check

### Development Proposal

- Is there a proposed technical approach, implementation plan, or architecture note?
- Does the proposed approach align with the acceptance criteria? (Would it actually deliver what the AC describes?)
- Does it align with the business value? (Not over-engineered or under-scoped relative to the goal)
- Are reusable components or existing code referenced?
- Are shared areas that may be modified identified? (regression risk)
- Are database changes documented? (table, column, migration)
- Are external integrations identified? (APIs, message queues, shared data sources)
- Is backward compatibility addressed? (Will existing data/records still work?)
- **Concurrency**: What if two users/processes do this simultaneously? Is that considered? (Note: Content Quality checks whether AC *specify* concurrency handling. This skill checks whether the *proposed implementation* handles it.)
- **State transitions**: Does the proposal account for all valid states the entity can be in? Are invalid transitions prevented? (Note: Content Quality checks whether AC *cover* state preconditions. This skill checks whether the *proposed approach* accounts for them.)
- **Notification fatigue**: If the implementation sends communications, is volume/throttling considered?

### Domain Language

- Are there domain-specific terms or acronyms used without explanation?
- **Warning (not failure)**: Flag unexplained jargon for clarification but don't score it as ❌. It may be well-understood within the team but opaque to others.

### Test Planning

- Can tests be derived from the acceptance criteria without asking questions?
- Is the test environment specified? (Where will this be tested?)
- Is test data identified? (Specific clients, bookings, configurations, user accounts)
- Are hardware/device considerations noted? (Mobile, desktop, specific browsers)
- Are automation candidates identified? (data-test-ids for new components, existing tests to update)
- Is regression scope indicated? (What else might break?)
- **Test isolation**: Can this be tested independently, or does it require other tickets to be complete first?

### Alignment Check

- Does the proposed dev approach describe work that would satisfy the AC? (Not more, not less)
- Do the test notes cover the AC? (Every criterion has a path to verification)
- Is there work described in the proposal that isn't covered by any AC? (Scope creep or missing AC — flag as "untested dev work")
- Is there AC that has no obvious implementation path in the proposal? (Gap in planning)
- **Dependency on external knowledge**: Does the approach assume knowledge that isn't documented or linked? ("Use the same pattern as X" — but X isn't referenced)

## Flags to raise

- **Dev/AC mismatch**: Proposed approach wouldn't deliver what the AC describes
- **Over-engineering**: Proposal describes work beyond what the AC requires
- **Under-scoped**: AC requires behaviour that the proposal doesn't address
- **No test path**: AC exists but there's no way to verify it with the information provided
- **Missing regression scope**: Shared areas modified but no regression consideration
- **No environment**: Nobody has said where or how this will be tested
- **No data**: Test scenarios require specific data states that aren't identified
- **Backward compatibility gap**: Changes to existing data/APIs without migration consideration
- **Untested dev work**: Proposal includes work (e.g. "also refactor Y") that has no AC and no test coverage
- **Concurrency unconsidered**: Multiple actors could trigger this simultaneously with no handling
- **State gap**: Not all valid entity states are accounted for in the proposal
- **Domain jargon** ⚠️: Unexplained terms that may need clarification (warning, not failure)

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. State what makes it pass, what's missing, or what question remains unanswered.

```
## Implementation & Test Readiness Review

**Ticket**: [key]
**Score**: ✅ / ⚠️ / ❌

## Development Proposal
[What's proposed? Does it align with AC and value?]

## Test Planning
[Is there enough to test without asking questions?]

## Alignment
| AC | Dev coverage | Test coverage | Gap |
|----|-------------|---------------|-----|
| AC1 | ✅/❌ | ✅/❌ | ... |
| AC2 | ✅/❌ | ✅/❌ | ... |

## Warnings
[Domain jargon, external knowledge dependencies — not failures but worth clarifying]

## Issues Found
[Mismatches, gaps, missing information]
```
