---
inclusion: manual
---

# Sprint Analysis: Retro

You are analysing all tickets within a completed (or ending) sprint to identify patterns in ticket quality. The output feeds into sprint retrospectives — helping the team see what they consistently do well, what they consistently get wrong, and what occasionally slips through.

This is NOT per-ticket feedback. It's pattern recognition across the sprint.

---

## What to Do

1. **Identify the sprint** — ask for the board and sprint name, or accept a sprint ID
2. **Fetch all tickets in the sprint** — use sprint issues endpoint or JQL (`sprint = "Sprint Name"`)
3. **Fetch each ticket with all fields** — apply the same field discovery as the index (AC, User Story, Problem Statement, Implementation Notes, Test Notes)
4. **Run a lightweight analysis per ticket** — not a full suite, but enough to score each dimension:
   - AC present and testable?
   - Why field present and clear?
   - Implementation notes present?
   - Test notes present?
   - Dependencies linked (not just mentioned)?
   - Weasel phrases in AC?
   - Adjacent features accounted for?
   - Error/negative states covered?
   - Implied rules addressed?
5. **Aggregate into patterns** — don't report per-ticket; report what the sprint reveals as a whole

---

## Analysis Dimensions (per ticket, scored silently)

For each ticket, assess these. Don't output individual scores — use them to build the pattern summary.

| Dimension | What you're checking |
|-----------|---------------------|
| AC Quality | Testable? Specific? Pass/fail clear? |
| AC Completeness | Error states? Boundary rejection? Implied rules? |
| Why Field | Present? Clear? Meaningful value statement? |
| Implementation Notes | Present? Actionable? |
| Test Notes | Present? Sufficient for QA? |
| Dependencies | Linked properly? Cross-team deps acknowledged? |
| Weasel Phrases | "Gracefully handled", "appropriate", "user-friendly" etc. |
| Adjacent Features | Companion work identified or missing? |
| Specification vs Expectation | AC proportional to what user story promises? |
| Type Correctness | Right type? Right hierarchy? |

---

## Pattern Categories

Group findings into three buckets:

### ✅ What we did well (consistent strengths)

Things that appeared in **most tickets** (>70%) and were done to a good standard. These are team habits worth reinforcing.

Examples: "AC were consistently in Given/When/Then", "Implementation notes were detailed on all dev tickets", "Dependencies were always linked"

### ❌ What we consistently got wrong (systemic gaps)

Things that were missing or weak in **most tickets** (>70%). These are patterns the team should address as a process change, not individual ticket fixes.

Examples: "No ticket had test notes populated", "Error states were never covered in AC", "Weasel phrases appeared in 8 of 10 tickets"

### ⚠️ What we occasionally got wrong (inconsistent)

Things that were sometimes good and sometimes bad (30-70% of tickets). These are awareness issues — the team knows how to do it but doesn't always remember.

Examples: "3 of 8 tickets had no problem statement", "Adjacent features were flagged on some tickets but missed on others"

---

## Metrics to Include

| Metric | How to calculate |
|--------|-----------------|
| AC coverage rate | % of tickets with testable AC |
| Test notes rate | % of tickets with populated test notes |
| Why field rate | % of tickets with User Story or Problem Statement |
| Impl notes rate | % of tickets with implementation guidance |
| Weasel phrase count | Total instances across the sprint |
| Dependency link rate | % of tickets with dependencies properly linked (not just mentioned) |
| Error state coverage | % of tickets where AC cover at least one failure scenario |
| Adjacent feature awareness | % of tickets where companion work is identified or explicitly out-of-scope |

---

## What NOT to Do

- **Don't name individuals** — this is about team patterns, not blame
- **Don't list every finding per ticket** — aggregate into patterns
- **Don't score the sprint** — no pass/fail. Just observations the team can act on
- **Don't recommend process changes** — state the pattern and let the team decide what to do about it
- **Don't include tickets that are Done/Closed with no issues** — they don't need airtime. Only mention completed tickets if they exemplify a good pattern worth reinforcing

---

## Output

```
## Sprint Retro: Ticket Quality Patterns

**Sprint**: [name]
**Board**: [project]
**Tickets analysed**: [count]
**Period**: [start] – [end]

---

### ✅ What we did well

- [Pattern 1 — what it is, how many tickets demonstrated it]
- [Pattern 2]
- [Pattern 3]

### ❌ What we consistently got wrong

- [Pattern 1 — what it is, how many tickets were affected, what the impact is]
- [Pattern 2]
- [Pattern 3]

### ⚠️ What we occasionally got wrong

- [Pattern 1 — what it is, which tickets had it vs didn't]
- [Pattern 2]
- [Pattern 3]

---

### By the Numbers

| Metric | This Sprint |
|--------|-------------|
| AC coverage | X/Y tickets (Z%) |
| Test notes populated | X/Y (Z%) |
| Why field present | X/Y (Z%) |
| Error states in AC | X/Y (Z%) |
| Dependencies linked | X/Y (Z%) |
| Weasel phrases found | N instances across M tickets |

---

### Worth Discussing in Retro

[2-3 specific questions for the team to consider, derived from the patterns above. Framed as "what should we change?" not "what did we do wrong?"]

---

### Sprint-over-Sprint (if previous retro provided)

| Finding from last retro | This sprint | Status |
|-------------------------|-------------|--------|
| [Issue flagged last time] | [Current state — metric or observation] | ✅ Improved / ⚠️ Persisting / ❌ Regressed |

**New this sprint**: [Issues appearing for the first time — not flagged in the previous retro]
```

---

## Rules

- **Aggregate, don't enumerate** — patterns over individual findings
- **Be specific about numbers** — "5 of 8 tickets" not "most tickets"
- **Strengths first** — always lead with what's working
- **No blame** — team patterns, not individual failures
- **Actionable framing** — "Worth Discussing" items should be things the team can actually change
- **One sprint = one retro output** — don't compare across sprints (yet)
- **Comparison with previous retro**: If the user provides a previous retro output (Confluence page, pasted text, or page ID), compare the current sprint's patterns against the last one. Surface:
  - **Improved**: Issues flagged last time that are no longer present or have measurably improved
  - **Persisting**: Issues flagged last time that remain at the same level — the team hasn't addressed them
  - **Regressed**: Things that were previously good but have gotten worse
  - **New**: Issues appearing for the first time this sprint

  Frame the comparison neutrally. Improvement is good. Persistence is an observation, not a failure — the team may have consciously deprioritised it. Regression needs attention.

  If no previous retro is available, skip the comparison section entirely. Never hardcode where to find previous retros — ask the user or accept a page ID/URL/pasted content.
