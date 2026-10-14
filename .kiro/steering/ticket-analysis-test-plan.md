---
inclusion: manual
---

# Ticket Analysis: Test Plan Generation

You are generating a test plan from a ticket's content. This is a generative skill — it produces output rather than scoring existing content. The goal is a plan that a QA engineer could pick up and execute without asking clarifying questions.

**Two modes:**

| Mode | When to use | Trigger phrases |
|------|-------------|-----------------|
| **Quick** | During refinement, early planning | "quick plan", "high level", "overview" |
| **Full** | Post-refinement, sprint-ready | Default, or "full plan", "detailed" |

Quick produces Assumptions/Questions + Test Plan (High priority rows only).
Full produces everything: Assumptions/Questions + Test Plan (all priorities) + Risks.

If no mode is specified, default to **Full**.

---

## Data Retrieval (do not skip)

- Always fetch with `fields=*all` and `comment_limit=0`
- Read the Acceptance Criteria field, User Story / Problem Statement field, description, and any QA/Test Notes fields
- Fetch the parent Epic for context on the broader initiative
- Fetch linked tickets and sub-tasks to understand scope boundaries
- Check for existing test data documentation, environment notes, or linked Confluence pages
- If the ticket references other tickets by key, fetch those for dependency context

---

## Assumptions & Questions

Surface everything that could block or misdirect testing. One consolidated section — no repetition.

For each item, state:
- What the assumption or unknown is
- Why it matters to testing
- Who can answer (if obvious)

Keep it succinct. If something is both an assumption AND a question, list it once as a question.

Testability blockers go here too — anything that prevents testing from starting. Only include a Blockers subsection if there ARE blockers.

---

## Test Plan

One table. All tests. Ordered by priority (High first, then Medium, then Low).

Start with a **Scope** paragraph: what this ticket changes, what it affects, and where the testing boundaries are. Include what is explicitly OUT of scope.

Then the table:

| # | Setup | Action | Expected Outcome | Verification | Purpose | Priority |
|---|-------|--------|-----------------|--------------|---------|----------|
| 1 | ... | ... | ... | ... | ... | High/Med/Low |

**Column guidance:**
- **Setup**: What state must exist before the test (preconditions, test data, config)
- **Action**: What the tester does — one clear action, not multi-step instructions
- **Expected Outcome**: The observable result
- **Verification**: How you confirm it worked (check response, inspect DB, observe UI, etc.)
- **Purpose**: Why this test exists. Short ("Regression", "AC1") or explanatory ("Race condition between lock and expiry")
- **Priority**: High (core AC, happy path, data integrity) / Medium (edge cases, error handling) / Low (exploratory, unlikely failures)

Regression is a row in this table, not a separate concern.

In Quick mode, only output High priority rows.

---

## Risks

**Full mode only.**

| Risk | Likelihood | Impact | Test action |
|------|-----------|--------|-------------|
| ... | High/Med/Low | High/Med/Low | ... |

Risks come from: complexity, data sensitivity, integration points, deployment concerns, timing, consumer readiness.

Don't repeat test scenarios. Reference the plan ("covered by #3") or flag something not in the plan.

---

## Jira Output Format

When writing to a Jira text field (via `jira_update_issue`), use Jira wiki markup. When presenting in chat, use standard Markdown. The content is the same — only the formatting syntax changes.

**Jira wiki markup rules:**
- `*text*` for bold (not `**text**`)
- `h3.` for headings (not `##`)
- `|| header ||` for table headers, `| cell |` for rows
- `#` for numbered lists
- `-` for bullet lists (flat, no nesting)
- `----` for horizontal rules
- No overall title (the field name IS the title)

**Chat/Markdown rules:**
- `**text**` for bold
- `###` for headings
- Standard Markdown tables
- Standard numbered and bullet lists
- `---` for horizontal rules
- No overall title

```
*Assumptions*
- [Assumption] — [risk if wrong]
- [Assumption] — [risk if wrong]

*Questions*
# [Question] — [who can answer]
# [Question] — [who can answer]

----

h3. Test Plan

*Scope*: [One paragraph]

|| # || Setup || Action || Expected Outcome || Verification || Purpose || Priority ||
| 1 | ... | ... | ... | ... | ... | High |
| 2 | ... | ... | ... | ... | ... | High |
| 3 | ... | ... | ... | ... | ... | Medium |

----

h3. Risks

|| Risk || Likelihood || Impact || Test action ||
| ... | ... | ... | ... |
```

---

## Principles

- **Generate from what exists.** Use the ticket content as the source of truth. Don't invent requirements — but DO surface implied behaviours the ticket doesn't address.
- **Actionable over academic.** Every section should help someone DO something — execute a test, ask a question, make a priority call.
- **No duplication.** Risks reference the plan, they don't repeat it. Questions don't reappear as assumptions.
- **Regression is part of the plan.** If existing behaviour must still work, it's a test row.
- **Honest about gaps.** If the ticket doesn't give enough to plan properly, say so in Questions.
- **Proportional depth.** A simple change gets a short table. A complex feature gets more rows. Match the plan's size to the ticket's complexity.
- **Don't question the obvious.** Apply domain knowledge where reasonable. Don't ask about things that are clear from context.
- **One test, multiple verifications.** If you're already in the state to check something, verify everything observable in that state. Don't create separate rows for "check the value exists" and "check the value is correct" — that's one test with thorough verification.
