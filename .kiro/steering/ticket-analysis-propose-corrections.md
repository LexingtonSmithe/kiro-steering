---
inclusion: manual
---

# Ticket Propose Corrections

You are generating proposed corrections for a Jira ticket based on information that ALREADY EXISTS in the ticket. You do not invent, assume, or infer new information. You restructure what's there.

**Critical rule**: NEVER write to Jira automatically. All output is a proposal for human review. The human decides whether to apply it.

---

## Data Retrieval (do not skip)

- Always fetch with `fields=*all` and `comment_limit=0`
- ACs, test plans, and "why" fields live in custom fields — they will NOT appear in default field fetches
- If the response looks thin (only summary/description/status), re-fetch before proceeding
- Never claim "no AC" without explicitly stating what the AC field contains

---

## Prerequisite: Prior analysis required

This skill depends on findings from the analysis skills. Before proposing corrections, check whether the ticket has been analysed in this conversation using at least Content Quality and Type Correctness.

**If prior analysis exists**: Proceed — use the findings to generate proposals.

**If no prior analysis exists**:

1. State: "This ticket hasn't been analysed yet in this conversation. Proposals may be incomplete without a structured review first."
2. Ask: "Would you like me to run Content Quality and Type Correctness first, or proceed with a lightweight pass?"
3. If the user says proceed anyway, run a minimum check (fetch all fields, assess AC presence/quality, check type correctness) and flag in the output: "⚠️ Limited analysis — full skill suite was not run."

---

## What you can propose

Only propose corrections where the information already exists somewhere in the ticket (description, comments, linked tickets, or dev notes) and just needs restructuring or surfacing.

### 1. Extract AC from description

If the description contains testable behaviours, rules, or scenarios that aren't stated as acceptance criteria, extract them.

**Safe when**: The description explicitly states a behaviour. You're lifting existing statements into AC format.

**Not safe when**: You'd need to infer or decide what the behaviour should be.

### 2. Synthesise description from User Story and AC

If the description is empty, contains only questions, or is out of sync with the User Story and AC fields, propose a description derived from those fields.

**Why this happens**: Descriptions are often the first field filled. As the ticket is refined, User Story and AC get updated but the description isn't revisited — leaving it stale or misleading.

**Safe when**: The User Story and AC fields contain the actual specification. You're summarising what's already decided.

**Not safe when**: The AC are themselves vague or incomplete. Don't synthesise a confident-sounding description from ambiguous AC.

**What a good synthesised description contains**:
- Who the user is (from User Story or Problem Statement)
- What problem this solves or what capability it adds
- A brief summary of scope (from AC — what's covered)
- Systems or areas involved (if inferable from AC content)
- What's NOT covered / out of scope (if sibling tickets exist)

**Confidence**: HIGH when summarising clear content. MEDIUM if inferring scope boundaries.

### 3. Link referenced tickets

If the description or comments mention ticket keys that aren't linked in Jira, propose adding the link.

**Safe when**: The ticket key is explicitly mentioned in text.

**Not safe when**: You're guessing a relationship based on similar topics.

### 4. Surface confirmed assumptions as AC

If comments contain confirmed decisions (marked "CONFIRMED" or clearly answered questions), propose adding these as AC or updating the description.

**Safe when**: The comment explicitly confirms a decision.

**Not safe when**: The discussion is ongoing, unresolved, or ambiguous.

### 5. Propose type correction

If the analysis skills identified a type mismatch, propose the retype with reasoning.

**Safe when**: The type correctness skill flagged it with clear reasoning.

**Not safe when**: The type is debatable or context-dependent.

### 6. Flag missing links to existing documentation

If the ticket's context suggests relevant documentation likely exists but isn't linked, flag it as a suggestion to verify.

**Safe when**: You're suggesting "check if a user guide exists for this area."

**Not safe when**: You're inventing a documentation link.

### 7. Cascade from parent/sibling tickets

If the parent Epic or Story contains confirmed decisions relevant to this ticket but not referenced here, propose surfacing them.

- **Epic → Story**: Confirmed outcomes or decisions the Story should reference
- **Story → Sub-task**: Parent AC that the sub-task contributes to but doesn't reference
- **Sibling awareness**: Confirmed assumptions on siblings that apply here

**Confidence**: Always MEDIUM — requires interpreting the relationship between tickets.

**Safe when**: The parent/sibling explicitly states something (CONFIRMED, decided, agreed) that directly applies.

**Not safe when**: You're inferring relevance based on topic similarity.

---

## What you CANNOT propose

- New acceptance criteria that don't exist anywhere in the ticket
- Success metrics (requires business decision)
- Implementation approaches (requires technical decision)
- Ticket splits (requires team discussion)
- Bug reproduction steps (requires someone to actually reproduce it)
- Answers to open questions (requires domain knowledge)
- Anything that requires judgement about what the product SHOULD do

---

## Confidence levels

For each proposal, state your confidence:

| Level | Meaning | Action |
|-------|---------|--------|
| **HIGH** | Explicitly stated in the ticket, just reformatting | Can be applied directly |
| **MEDIUM** | Strongly implied, requires minor interpretation | Requires human validation |
| **LOW** | Correct based on context but needs verification | Flag for review before applying |

---

## Structuring alternatives and dependencies

Proposals may conflict with or supersede each other. Structure them so the reader knows the order:

1. **Primary recommendation** — present first with full detail
2. **Fallback** — "If the team decides not to do X, then do Y instead"
3. **Apply regardless** — valid whether or not the primary is accepted

**Rule**: Before outputting, review all proposals and ask: "Does accepting proposal X make proposal Y unnecessary?" If yes, nest Y under X as a fallback.

**Why this matters**: If proposals are a flat list, someone may work through AC rewrites only to undo that work when a split is accepted. Wasted effort erodes trust in the analysis.

---

## Duplicate check before proposing splits

Before proposing a split, fetch sibling tickets under the same parent Epic and any linked tickets. For each proposed new ticket, check: does a sibling already cover this scope?

**If overlap exists**, do NOT propose a duplicate. Instead recommend:
- **Merge**: "Proposed scope overlaps with SN-XXXX. Consider merging."
- **Clarify boundary**: "The boundary between this and SN-XXXX needs clarifying."
- **Reference**: "This scope is already covered by SN-XXXX. Link it."

**How to check**: Search for child tickets under the parent Epic. Check issue links. Compare each proposed split's scope against what already exists.

---

## Formatting of proposed content

When proposing new or rewritten content, apply the formatting skill's rules:

- **AC numbering**: Consistent (AC1, AC2...). No mixed bullets/numbers/prose.
- **User Story format**: Each clause on its own line.
- **Description structure**: Use headings for readability.
- **Field placement**: Propose content for the correct field.
- **No duplication**: Don't propose content that restates another field.

The proposed corrections are what the ticket SHOULD look like. If the proposal itself has formatting problems, it undermines confidence in the analysis.

---

## Output

```
## Proposed Corrections for [ticket key]

### Extraction: AC from Description
**Confidence**: HIGH / MEDIUM / LOW
**Source**: [Quote the exact text]
**Proposed AC**:
- AC1: [extracted criterion]
- AC2: [extracted criterion]

### Synthesised Description
**Confidence**: HIGH / MEDIUM
**Source fields**: [Which fields the content is derived from]
**Proposed description**: [structured description]

### Link: Referenced Tickets
**Confidence**: HIGH
**Source**: [Quote where the ticket is mentioned]
**Proposed link**: [key] → [relationship type]

### Confirmed Assumption → AC
**Confidence**: MEDIUM
**Source**: [Quote the comment]
**Proposed AC**: [statement]

### Type Correction
**Confidence**: HIGH / MEDIUM
**Current**: [type]
**Proposed**: [type]
**Reason**: [why]

### Documentation to Verify
**Confidence**: LOW
**Suggestion**: [Check if X exists and link it]

### Cascade from Parent/Sibling
**Confidence**: MEDIUM
**Source ticket**: [key — quote the relevant text]
**Proposed addition**: [What should be added]
**Why**: [How it applies to this ticket's scope]

---

## Not Proposable (requires human decision)
[List anything that CANNOT be auto-corrected — needs team discussion]
```

---

## Usage

1. Run one or more analysis skills against the ticket first
2. Activate this skill to generate proposals based on the findings
3. Review the proposals — apply HIGH confidence ones, discuss MEDIUM/LOW
4. Never apply without reading the proposal first
