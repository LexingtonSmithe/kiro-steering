---
inclusion: manual
---

# Ticket Analysis: Pre-Refinement

You are preparing a ticket for refinement by identifying the key questions, gaps, and focus areas the team needs to address during the session. The goal is to make refinement productive — not to score the ticket, but to surface what needs discussing so the team doesn't leave with unanswered questions.

This skill is used BEFORE refinement. The output is a preparation brief for whoever is facilitating or attending the session.

## What to do

1. **Identify the ticket type** — if it's a sub-task, fetch the parent first
2. **If sub-task**: Analyse the parent Story/Task first (is it clear, does it have AC, is the goal understood?), then assess whether the sub-tasks are appropriate slices, then check the specific sub-task's content (input/output/done/scope/dependencies)
3. **If Story/Task/Epic**: Read the ticket description, AC (if any), and any linked tickets
4. **Find the parent Epic** — use multiple approaches since Epic links are stored inconsistently:
   - Check the ticket's `parent` field in the API response
   - Search for Epic Link custom fields
   - Search JQL: `issuetype = Epic AND project = [PROJECT] AND summary ~ "[relevant keywords]"`
   - Check labels for initiative hints
   - Search nearby key numbers (if ticket is SN-1751, check SN-1749, SN-1750 for Epics)
5. Identify what's clear and what's not
6. Generate the questions that MUST be answered during refinement
7. Highlight areas that need specific discipline input (dev, QA, design, ops)
8. Flag risks or assumptions that need validating

### Sub-task flow

When the target ticket is a sub-task, the output should cover three levels:

**Level 1 — Parent health**: Is the parent Story/Task clear enough to slice from? Does it have AC? Is the goal understood? If the parent is weak, flag that refinement needs to start there.

**Level 2 — Slice appropriateness**: Are the sub-tasks logical slices? Do they have clear boundaries? Is there overlap or gaps between them? Are dependencies between sub-tasks explicit?

**Level 3 — Sub-task content**: Does this specific sub-task define its own boundary (input, output, done conditions, out of scope, dependencies)? Or does it duplicate the parent / lack its own identity?

## What to surface

### Who is the user?

- Is it clear who benefits from this work?
- If the ticket says "user" — which user? Customer? Client Manager? Client Ops? Developer?
- If the user isn't named, this must be established in refinement.

### What does "done" look like?

- Are there acceptance criteria? If not, the team needs to write them in refinement.
- If AC exist, are they testable? Could QA write a test from them without asking questions?
- Are there scenarios mentioned in the description that aren't covered by AC? Flag these as "needs AC during refinement."

### What questions remain unanswered?

Generate specific questions the team should answer. Categorise them:

- **Behaviour questions**: What should happen when X? What does the user see if Y fails?
- **Scope questions**: Is Z included or out of scope? How far does this go?
- **Data questions**: What data states exist? What about edge cases (empty, maximum, null)?
- **Integration questions**: What other systems does this touch? Who owns them?
- **Timing questions**: Does this need to ship by a date? Is it blocked by anything?

### What assumptions need confirming?

- Are there statements that read as assumptions rather than confirmed facts?
- Are there "I think" or "probably" or "should be" phrases that need validating?
- Are there references to other teams' work that hasn't been confirmed?

### What does each discipline need to focus on?

**Product should clarify:**
- The user and their goal
- The scope boundary (in/out)
- Priority relative to other work
- Success criteria (how do we know this worked?)

**Development should consider:**
- Technical approach (high level — not dictating, but understanding complexity)
- Shared areas affected (regression risk)
- Dependencies on other systems or teams
- Data migration / backward compatibility concerns
- Concurrency — can multiple users trigger this simultaneously?

**QA should consider:**
- Can I test this from the AC alone?
- What test data do I need? Does it exist?
- What environments will this be tested in?
- What are the error states and edge cases?
- Are there existing tests that will need updating?

**Design should clarify (if UI work):**
- Is there a design reference? Is it linked?
- What are the responsive breakpoints?
- What are the error/empty/loading states?
- Accessibility considerations (tab order, screen readers, focus management)

### What risks should be discussed?

- Is there anything that could go wrong that hasn't been acknowledged?
- Are there implicit dependencies that aren't linked?
- Is there a rollback path if this causes problems?
- Does this change behaviour for existing users? Will they notice?

### Should this ticket be split?

Apply the splitting rule of thumb: **If one part were removed, would the remaining work still be a complete and meaningful increment?** If yes, it should likely be split.

Look for differences in:
- **Purpose** — does the ticket serve multiple user goals?
- **Rules/logic** — are there distinct business rule sets bundled together?
- **Lifecycle** — could parts be delivered at different times or by different people?
- **Testability** — can parts be tested independently?
- **Failure modes** — would a defect in one area block or impact another?

Don't split on technical boundaries (FE/BE, different endpoints). Split on product boundaries — can each part be understood, tested, and delivered independently?

When recommending a split, describe each proposed ticket in terms of: who the user is, what value it delivers, and why it's independently meaningful.

## Output

```
## Pre-Refinement Brief

**Ticket**: [key + title]
**Type**: [current type — flag if it looks wrong]
**Ready for refinement**: Yes / No (if No, state what's needed first)

## What's Clear
[Bullet points of what IS well-understood from the current description]

## Questions for Refinement

### Must Answer (blocking)
[Numbered questions that MUST be resolved before this can be estimated or developed]

### Should Discuss (important but not blocking)
[Questions that improve quality but won't prevent work starting]

### Assumptions to Confirm
[Statements in the ticket that read as assumptions — need explicit yes/no from the team]

## Focus Areas by Discipline

**Product/BA**: [What they need to clarify]
**Dev**: [What they need to consider]
**QA**: [What they need to know]
**Design**: [What they need to provide — if applicable]

## Risks to Discuss
[Anything that could go wrong, implicit dependencies, backward compatibility, user impact]

## Suggested AC (draft)
[If no AC exist, suggest draft criteria the team can refine together. These are starting points, not final — the team should own them.]
```
