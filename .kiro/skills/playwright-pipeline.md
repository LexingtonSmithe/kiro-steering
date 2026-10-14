---
name: playwright-test-building
description: >-
  Build Playwright tests using progressive elaboration: work top-down from
  feature groupings to headers to pseudocode to dirty-green to clean-green to
  abstracted, advancing ONE stage per prompt and verifying at each gate. Use
  this when writing new Playwright specs, filling in pseudocode test stubs, or
  turning a test plan / step list into runnable tests. Anchored to the
  kaboodle-solutions/booking-portal test conventions.
---

# Playwright Test Building

## What this is

A staged method for turning intent (a feature area, a test plan, a list of
steps) into maintainable Playwright tests without producing the bloated,
over-abstracted output that LLMs generate when asked to do everything at once.

The core principle: **advance one stage at a time and verify before moving on.**
Each early stage is a cheap review gate — coverage and intent get signed off
while restructuring is still free, before selectors and waits make churn
expensive. Never jump stages. If asked to "just write the tests," still work the
pipeline; the stages are fast.

## The pipeline

Work top-down. Each stage has a definition of done (the "gate"). Do not start a
stage until the previous gate is met.

1. **Functionality grouping**
   Carve the feature area into logical groups. Output is section-header comment
   blocks only (e.g. `// ─── R1: Date & Timeslot Selection ───`).
   **Gate:** groups cover the feature area, reviewer agrees on the carve-up. No
   test shells yet.

2. **Headers only**
   One empty `test('name', { tag })` shell per intended test, under its group.
   Bodies are empty.
   **Gate:** every intended test has a named shell and *no body*. If a body
   appeared, reject and redo — this stage exists to review coverage, not code.

3. **Pseudocode test steps**
   Fill each shell with comment-only steps — the test *plan*, in plain English.
   This is the cheapest artifact to get wrong and fix.
   **Gate:** each test reads as an ordered list of user actions and expected
   outcomes. No Playwright calls yet.

4. **Dirty green**
   Convert each comment into the 1–3 lines that implement it, leaving the
   comment above its code as an anchor. Literal and duplicated is CORRECT here —
   do not extract shared helpers. Get it passing.
   **Gate:** tests pass. Duplication across tests is expected and fine.

5. **Clean green**
   Tidy *within* each test: naming, ordering, dead code, obvious readability.
   Still no cross-test abstraction. Tests stay green.
   **Gate:** each test reads cleanly on its own; still passing.

6. **Abstract**
   Lift helpers from *observed* duplication (never speculative), following the
   booking-portal conventions in `conventions.md`: page-object classes that take
   `page`, `test.step` with human-readable sentences, shared journeys in
   `helpers/`. Then cross-pollinate verification (e.g. apply an assertion type
   that one test proved valuable to sibling tests) — do this as an explicit,
   one-assertion-type-at-a-time diff, because it changes what each test proves.
   **Gate:** helpers back real repetition; tests still green; no behaviour lost.

## Guardrails (apply at every stage)

- **One stage per prompt.** This is the single most important rule. It is what
  prevents the meltdown where the model tries to group, implement, abstract, and
  clean simultaneously and produces tangled output.
- **Duplication is correct until stage 6.** Refactor from real, visible
  repetition — never guess at abstractions in stages 4–5.
- **Keep pseudocode comments as anchors through stage 4.** They keep the test
  auditable against the plan and stop invented steps.
- **Match the closest existing spec.** New tests imitate the nearest gold-standard
  file's structure, not a new dialect. See `conventions.md`.
- **The step list / pseudocode is the oracle.** If totals or arithmetic in the
  pseudocode don't line up once green, the plan had a bug — flag it, don't paper
  over it.
- **Stop at purpose; buy only in e2e.** An engine/feature test ends once its
  purpose is met (e.g. accommodation validated → `clickContinue`). Full
  purchase (login → payment → success) belongs in the regression e2e, not in
  every test. See `conventions.md`.

## Per-stage prompt templates

All prompts share this spine: *match the closest existing spec, one stage only,
do not jump ahead*. Fill the `[BRACKETED]` placeholders. Always paste the
closest existing gold-standard spec as the style exemplar.

### Stage 1 — Functionality grouping

> Carve `[FEATURE AREA]` into logical test groups for a Playwright spec. Output
> ONLY section-header comment blocks (like `// ─── <group> ───`), no test
> shells, no code. Base the grouping on `[TEST PLAN / TICKET / DOCS]`. Keep it to
> the natural seams of the feature. Stop after the headers.

### Stage 2 — Headers only

> Here are the group headers: `[PASTE STAGE 1 OUTPUT]`. Under each, add one
> empty `test('<human-readable name>', { tag: '@Px' }, async ({ page }) => {})`
> shell per intended test. Bodies MUST be empty. Do not write any steps or
> Playwright calls. This is a coverage review — output only the named shells.

### Stage 3 — Pseudocode steps

> Here are the empty test shells: `[PASTE STAGE 2 OUTPUT]`. Fill each body with
> comment-only steps describing the user actions and expected outcomes in plain
> English, in order. No Playwright calls, no locators. One comment per discrete
> step. Base the steps on `[TEST PLAN]`.

### Stage 4 — Dirty green (the main one)

> You are filling in pseudocode test stubs in an existing Playwright spec. Convert
> the comment-only bodies into real, runnable tests that match the exemplar
> EXACTLY. Match the style; do not invent one.
>
> Hard constraints:
> 1. Do NOT create new files or add page objects/fixtures/shared modules.
> 2. Any helper must be defined INSIDE the test that uses it, like the exemplar's
>    inline helpers.
> 3. Use the file's locator style (see exemplar).
> 4. Keep every pseudocode comment as an anchor; write 1–3 lines under each. Add
>    no steps that aren't in the comments.
> 5. Before asserting after a cart/basket mutation, await the basket response the
>    same way the exemplar does.
> 6. Duplication across tests is fine — do NOT extract shared helpers.
> 7. Top-level bodies read as a linear sequence of actions and assertions.
> 8. If a control name is genuinely unknown, use a clearly-labelled guess and add
>    `// TODO: confirm control name` rather than inventing an abstraction.
> 9. Output only the rewritten tests, ready to paste.
>
> Exemplar (match this style): `[PASTE CLOSEST PASSING TEST]`
> Stubs to implement: `[PASTE STUB TESTS]`

If it drifts, the most effective correction is:
> Regenerate. `<exemplar helper>` in the exemplar is ~40 lines and lives inside
> its test — that's the maximum abstraction level allowed. Inline anything
> simpler.

### Stage 5 — Clean green

> These tests pass: `[PASTE TESTS]`. Tidy WITHIN each test only: naming, step
> ordering, dead code, readability. Do NOT extract shared helpers or change what
> any test asserts. Keep them green. Output the tidied tests.

### Stage 6 — Abstract + cross-pollinate

> These tests pass and are individually clean: `[PASTE TESTS]`. Now extract
> helpers from the ACTUAL duplication you can see across them, following the
> conventions in `conventions.md` (page-object classes taking `page`,
> `test.step` sentences, shared journeys under `helpers/`). Only abstract
> repetition that genuinely recurs. Then, separately, identify one assertion type
> that one test proved valuable and propose applying it to sibling tests as an
> explicit diff. Do the extraction first, keep tests green, then propose the
> cross-pollination for review.

## Handoff note

When pairing or handing this to a colleague driving another agent, give them:
(1) the stage they're on, stated in one line ("Stage 4 only: dirty green,
duplication fine, no shared helpers"), (2) the stage's prompt template, and
(3) the closest gold-standard spec as exemplar. Self-contained per-stage prompts
are the guardrail that keeps their agent from running ahead.

See `conventions.md` for the concrete gold-standard patterns this skill assumes.
