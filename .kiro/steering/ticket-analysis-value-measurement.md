---
inclusion: manual
---

# Ticket Analysis: Value & Measurement

You are reviewing whether the work has a clear value hypothesis and whether each ticket contributes to a measurable goal. This requires fetching and reviewing linked tickets to understand the full picture.

## What to do

1. **Fetch the ticket** and identify its parent Epic (if any)
2. **Find the parent Epic** — follow the "Finding the Parent Epic" procedure in the index (`#ticket-analysis-suite-index`)
3. **Fetch the parent Epic** and any sibling tickets under it
4. **If the ticket has sub-tasks**, fetch those too — check they all contribute
5. **Assess the value chain** — from Epic hypothesis down to individual ticket contribution

## What to check

### Overall Value Hypothesis (Epic level or orphan Story)

- Is there a clear "why" — what business goal, customer pain point, or opportunity does this address?
- Is there evidence this is worth doing? (data, support volume, revenue impact, customer feedback, stakeholder request)
- Who requested this and who validates the outcome? (named person or team)
- Is there a hypothesis that can be proven or disproven? ("We believe [action] will result in [outcome] for [audience]")

### Individual Ticket Contribution

- Does this ticket clearly contribute to the Epic's goal?
- Could you explain how completing this ticket moves the needle on the overall hypothesis?
- If this ticket were removed, would the Epic's goal still be achievable? (If yes, is it necessary?)
- Is the ticket's scope proportional to its contribution? (Not over-engineered for marginal value)

### Sub-task Contribution (if applicable)

- Do all sub-tasks contribute to the parent's goal?
- Are any sub-tasks gold-plating? (Nice-to-have work that doesn't serve the stated value)
- Are sub-tasks proportional to the parent's scope?

### Success Criteria

- How will we know this worked post-release?
- What metric changes? By how much? Over what timeframe?
- Do we have a baseline measurement of current behaviour?
- Is the tracking in place, or does it need to be built first?
- Who is responsible for reviewing the success criteria after release?
- **Vanity metrics check**: Does the metric actually connect to the hypothesis? ("Page views" isn't a success criterion if the goal is conversion)
- **Kill criteria**: What if the feature makes things worse? Is there a threshold where we'd revert?

### Cascading Issues

- If the parent Epic has no value justification, flag this as a cascading gap
- If sibling tickets overlap in scope, flag potential duplication
- If the Epic's goal has changed but child tickets haven't been updated, flag drift

### Coverage Check (Epics only)

When analysing an Epic, map each stated outcome to the child tickets that deliver it:

- List each outcome/objective from the Epic description
- For each outcome, identify which child ticket(s) deliver it
- Flag any outcome with **no child ticket coverage** — the Epic promises something that nobody is building
- Flag any child ticket that **doesn't map to any stated outcome** — work is happening that the Epic doesn't account for (scope creep or missing outcome)
- Check for **partial coverage** — an outcome that's only partially addressed (e.g. "reporting in Pacman or Looker" but only Looker tickets exist)

## Flags to raise

- **No hypothesis**: Work exists without a stated reason or expected outcome
- **No stakeholder**: Nobody named who requested or will validate this
- **No measurement**: Success is undefined — how do we know it worked?
- **Vanity metric**: Metric doesn't connect to the stated goal
- **No kill criteria**: No threshold for reverting if the feature causes harm
- **Disconnected**: Ticket doesn't clearly contribute to its parent Epic's goal
- **Cascading gap**: Parent Epic lacks justification, which means all children inherit no "why"
- **Scope drift**: Epic goal has evolved but child tickets still reflect the old goal
- **Over-investment**: Ticket scope is disproportionate to its contribution to the goal
- **Gold-plating sub-tasks**: Sub-tasks that don't serve the stated value

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. State what makes it pass, what's missing, or what question remains unanswered.

```
## Value & Measurement Review

**Ticket**: [key]
**Parent Epic**: [key + title, or "None (orphan)"]
**Score**: ✅ / ⚠️ / ❌

## Value Hypothesis
[What's the stated goal? Is it evidenced?]

## This Ticket's Contribution
[How does this specific ticket move the needle?]

## Success Criteria
[How will we know it worked? What's measured? Is there a kill threshold?]

## Linked Ticket Assessment
| Ticket | Relationship | Contribution to goal |
|--------|-------------|---------------------|
| ... | Parent Epic | ... |
| ... | Sibling | ... |
| ... | Sub-task | ... |

## Issues Found
[Cascading gaps, disconnections, missing measurement, vanity metrics]

## Epic Coverage (if analysing an Epic)
| Outcome | Covered by | Gap |
|---------|-----------|-----|
| ... | [ticket keys] | ... |
```
