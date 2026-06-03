---
inclusion: manual
---

# Ticket Analysis: Spark

A lightweight checkpoint tool used at two points in the ticket lifecycle to surface gaps, prompt discussion, and verify readiness. Same output format at both stages — what changes is what you're checking for.

---

## When to Use

### Stage 1: Post-PO Write-up (before refinement)

The PO has fleshed out the ticket from an idea. Run the spark to check: is this ready for the team to discuss, or are there gaps that will derail the session?

**What matters at this stage:**
- Is the scope clear enough to have a productive conversation?
- Are there obvious missing pieces that will block discussion?
- Should this be split or promoted before the team sees it?
- Are there adjacent features nobody has accounted for?

### Stage 2: Post-Refinement (before dev begins)

The team has refined, estimated, and agreed on the work. Run the spark as a Definition of Ready check: did the session cover everything, or are there gaps that will surface during development?

**What matters at this stage:**
- Did the team resolve the key questions, or are unknowns still open?
- Are the AC complete enough to build and test against?
- Are dependencies identified and unblocked?
- Is there anything that will force the developer to stop and ask questions mid-sprint?

---

## What to Do

1. Fetch the ticket with all fields
2. If sub-task, fetch the parent
3. Find the parent Epic for context
4. Identify the 3-5 most important gaps or decisions needed
5. Output a tight, scannable brief

---

## What to Surface

Focus on **decisions needed and gaps that will cause problems**. Every item should be something actionable.

**Prioritise:**
- Unanswered questions that block estimation or development
- Scope ambiguity (what's in, what's out)
- Missing AC for critical behaviours
- Adjacent features that nobody has accounted for
- Whether the ticket should be split or promoted

**Skip:**
- Formatting issues
- Things that are fine
- Detailed implementation suggestions
- Exhaustive edge case lists

---

## Splitting & Promotion

If the ticket should be split: say so in one line with the proposed pieces.

If the split produces 3+ independent Stories: recommend promoting to Epic in one line.

Don't elaborate — the team will discuss it.

---

## Output

Keep it tight. No tables unless they genuinely aid scanning. No headers deeper than H3. No section should exceed 4-5 bullets. Maximum ~30 lines total.

```
---

> **How to use this**: Compare against your own discussion. Did you cover these points? Did you raise things it didn't? The goal is to spot patterns in what gets consistently caught or missed — not to agree with the tool.

---

## Spark: [key]

**One-liner**: [What this ticket is trying to do, in plain language]
**Type check**: [Correct / Should be X]
**Ready**: Yes / No — [one-sentence reason if No]

### Key Questions

1. [Most important unanswered question or unresolved decision]
2. [Second]
3. [Third]
4. [Fourth — only if genuinely important]
5. [Fifth — only if genuinely important]

### Missing (needs AC or explicit "out of scope")

- [Behaviour that must exist but isn't specified]
- [Another]
- [Max 3-4 items]

### Adjacent Work

- [Companion feature that should exist — does it?]
- [Only genuinely missing companions]

### Split?

[One of: "No — appropriate scope" / "Yes — split into: X, Y, Z" / "Promote to Epic — this is N independent Stories"]

### Watch Out

- [One or two risks worth knowing going in]
```

---

## Rules

- **Maximum ~30 lines**. If you're writing more, you're too detailed.
- **No explanations**: State the gap, don't justify why it matters. The team knows their domain.
- **No scoring**: This isn't a quality assessment — it's a readiness check.
- **No suggested rewrites**: That's for the full analysis suite.
- **One ticket = one spark**.
- **Trust the team**: They'll figure out the answers. Your job is to make sure they don't forget to ask.
- **Same format at both stages**: The output doesn't change based on when it's run. What the team does with it changes.
