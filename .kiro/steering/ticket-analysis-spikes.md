---
inclusion: manual
---

# Ticket Analysis: Spikes

You are reviewing whether a Spike ticket is well-formed and ready to be worked on. Spikes have unique quality criteria that differ from Stories and Tasks — they are time-boxed investigations with defined outputs, not open-ended research.

## Data Retrieval (do not skip)

- Always fetch with `fields=*all` and `comment_limit=0`
- ACs, test plans, and "why" fields live in custom fields — they will NOT appear in default field fetches
- If the response looks thin (only summary/description/status), re-fetch before proceeding
- Never claim "no AC" without explicitly stating what the AC field contains

---

## What to check

### 1. Time-box

- Is there a stated time limit? (e.g. "1 day", "2 days", "half a sprint")
- Is the time-box proportional to the question being asked?
- Is it clear what happens when the time-box expires? (Deliver what you have, not "extend until done")

### 2. Output Definition

- Is the expected deliverable explicitly stated?
- Valid outputs: decision document, set of tickets, prototype, recommendation, architecture diagram, proof of concept
- Invalid outputs: "investigate X" with no stated deliverable — what does "investigated" look like?

### 3. Scope Boundary

- Is it clear what IS being investigated?
- Is it clear what is NOT being investigated? (Out of scope)
- Are there specific questions the spike should answer?
- Could two people independently agree on whether the spike is "done"?

### 4. Success Criteria for the Investigation

- What does a successful spike look like? (Not the feature — the investigation itself)
- Is there a decision to be made? If so, what are the options?
- What information would change the team's approach?
- Is there a "we learned enough to proceed" threshold?

### 5. Context & Motivation

- Why is this investigation needed? What's blocked without it?
- What do we already know? (Avoid re-investigating known ground)
- Are there prior spikes or related investigations linked?
- Is there a hypothesis to validate or disprove?

### 6. Collaboration

- Who needs to be involved? (Cross-team, specific expertise)
- Is the output for a specific audience? (PO decision, team refinement, architecture review)
- Does the spike need input from external parties? (Third-party docs, vendor confirmation)

## Flags to raise

- **No time-box**: Open-ended investigation with no limit
- **No output defined**: "Investigate X" without stating what the deliverable is
- **No questions**: No specific questions to answer — just a vague area to look at
- **No success criteria**: No way to know when the investigation is "enough"
- **Duplicate investigation**: A prior spike already covered this ground (check linked tickets)
- **Too broad**: The scope is so wide it can't be meaningfully addressed in the time-box
- **No motivation**: It's unclear why this investigation is needed or what it unblocks

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. State what makes the spike actionable, what's unclear, or what's missing entirely.

```
## Spike Review

**Ticket**: [key]
**Score**: ✅ / ⚠️ / ❌

| Criterion | Pass | Notes |
|-----------|------|-------|
| Time-box | ✅/❌ | ... |
| Output defined | ✅/❌ | ... |
| Scope bounded | ✅/❌ | ... |
| Success criteria | ✅/❌ | ... |
| Context & motivation | ✅/❌ | ... |
| Collaboration | ✅/⚠️/❌ | ... |

## Key Questions the Spike Should Answer
[Extracted or suggested questions based on the description]

## Issues Found
[What's missing or unclear]

## Recommendations
[Specific actions to make this spike actionable]
```
