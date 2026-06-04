---
inclusion: manual
---

# Ticket Analysis: Formatting

You are reviewing whether a Jira ticket is consistently structured and readable. This is not about whether the content is correct or complete — it's about whether it's presented in a way that's scannable, consistent, and in the right place.

## Critical Rules

1. **Read ALL fields before changing ANY field.** Fetch the ticket with `*all` fields. Check: description, User Story field, Acceptance Criteria field, and any other populated custom fields. Never overwrite a field without confirming its current content.

2. **Never move content between fields without explicit approval.** If AC content is in the description, flag it — don't move it. Propose the change, let the human apply it.

3. **Never reduce content.** If a field has 5 items and you're reformatting, the output must still have 5 items. Count before and after.

4. **Formatting changes only.** You are restructuring presentation, not changing meaning. The words stay the same — only line breaks, numbering, headings, and field placement change.

5. **Know the field types.** Different fields accept different formats depending on the project configuration:
   - `description`: Markdown (converted to Jira wiki markup by the API)
   - Acceptance Criteria: May be ADF (JSON structure), plain text, or wiki markup
   - User Story: May be plain text or ADF
   - Always test the format before writing. If unsure, propose the change instead of applying.

## What to check

### AC Numbering

- Are acceptance criteria numbered consistently? (AC1, AC2... or AC 1), AC 2)...)
- Or are they a mix of bullets, numbers, prose paragraphs, and inline text?
- Each criterion should be its own numbered item — not buried in a paragraph or combined with others.
- **Count the criteria before and after any reformat.**

**Good**:
```
AC1) The customer can only select future dates
AC2) The error message disappears when the input is corrected
```

**Bad**:
```
- dates should be in the future and also the error should go away when fixed
```

### User Story Format

- If the ticket uses "As a / I want / So that" format, is each clause on its own line?
- Or is it crammed into a single line that's hard to parse?
- Check the User Story field (identified by name), not just the description.

**Good**:
```
As a Client Manager,
I want to upload brand assets via the admin portal,
So that I don't need to raise a dev request for branding changes.
```

**Bad**:
```
As a Client Manager, I want to upload brand assets via the admin portal so that I don't need to raise a dev request for branding changes.
```

### Information in the Right Field

Check that content lives where it belongs:

| Content type | Correct field | Common wrong location |
|-------------|---------------|----------------------|
| User Story (As a/I want/So that) | User Story field | Description first line |
| Acceptance Criteria | Acceptance Criteria field | Description, comments |
| Problem Statement (Tasks) | Problem Statement field | Description, comments |
| Test notes / QA considerations | QA/Test Notes field | Description, comments |
| Dev approach / technical notes | Dev Notes or description "Implementation" section | Comments, AC field |

**Flag** when content is in the wrong place. **Do not move it** without approval. To generate move proposals for misplaced content, use `#ticket-analysis-propose-corrections` after this review.

### Duplication

- Is the same information repeated across multiple fields? (Description AND AC saying the same thing)
- Is the User Story restated verbatim in the description?
- Is context from the parent Epic copy-pasted into the child Story?

**Flag** duplication that will cause confusion when one copy is updated but the other isn't.

### Heading Structure

- Does the description use consistent headings? (## Summary, ## Scope, ## Notes)
- Or is it a wall of text with no visual structure?
- Are headings used but inconsistently?

### Links and References

- Are URLs rendered as clickable links, or pasted as raw text?
- Are ticket references (SN-1234) linked or just typed as plain text?
- Are Confluence page references linked or just named?

### Readability

- Are long descriptions broken into scannable sections?
- Are lists used where appropriate (not everything in prose)?
- Is there excessive formatting (bold everything, all caps) that reduces readability?
- Are code snippets in code blocks, not inline text?

## Flags to raise

- **Inconsistent AC format**: Mix of numbering styles, bullets, and prose
- **Cramped user story**: As/I want/So that on one line
- **Misplaced information**: Content in the wrong Jira field (flag only, don't move)
- **Duplication**: Same content in multiple places
- **No structure**: Wall of text with no headings or sections
- **Broken links**: URLs as plain text, ticket keys not linked
- **Formatting noise**: Excessive bold, caps, or decoration that doesn't aid comprehension

## Output

Always show current state and proposed change side-by-side. Always count items before and after.

```
## Formatting Review

**Ticket**: [key]
**Fields read**: [list all fields checked and their current state]
**Score**: ✅ / ⚠️ / ❌

## Issues Found

| Issue | Field | Current | Proposed | Item count check |
|-------|-------|---------|----------|-----------------|
| ... | ... | [quote current] | [show reformatted] | Before: X, After: X ✅ |

## Misplaced Information (flag only — do not move without approval)

| Content | Currently in | Should be in | Action needed |
|---------|-------------|-------------|---------------|
| ... | Description | AC field | Needs human approval to move |

## Proposed Changes (for approval)

[List each change with the exact field, current value, and proposed value. Human approves before any write.]
```
