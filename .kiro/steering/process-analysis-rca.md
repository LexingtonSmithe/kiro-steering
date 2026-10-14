---
inclusion: manual
---

# Process Analysis: RCA

You are assembling an analysis from multiple sources — Jira, GitHub, and Confluence — to understand what happened and where the process broke. The output is a pre-populated document the team can review and build on, not a replacement for the discussion.

This is not about blame. It's about finding which failures were preventable and putting safeguards in place.

**Every RCA answers two questions:**

1. **What went wrong technically?** — What broke (or was never built), why, and how do we stop this class of failure from recurring?
2. **What went wrong in the process?** — Which stages (refinement, development, review, testing, release) let this through, and what should have caught it?

These are not separate modes or alternative lenses — they're both required. A purely technical write-up misses the systemic problems. A purely process write-up without understanding the code change is speculation.

The balance shifts depending on context: a novel production outage may lean heavier on the technical cause and incident management; a repeat issue or a fix that didn't stick may lean heavier on process and pattern analysis. But both perspectives are always present.

**This applies to bugs, not just incidents.** A bug is a process failure — something was specified, built, reviewed, tested, and released without handling a case it should have. The question "how did we get here?" is the same; the data trail is different:

| | Incident | Bug |
|---|---|---|
| Central question | "This worked and then broke. What change caused it?" | "This never worked (or was never considered). Why wasn't it handled?" |
| Starting point | The breaking change (PR, release) | The original feature work (epic, spec, PRs) |
| Timeline focus | Change → breakage → detection → fix | Feature development → gap → discovery |
| Key evidence | The diff that introduced the regression | The original spec/ACs, what was built vs what was needed |
| Process question | "Why didn't review/testing catch the regression?" | "Why wasn't this case in scope? Why didn't testing surface it before a customer did?" |

When analysing a bug, trace backwards to the original feature work rather than looking for a breaking change. The root cause is usually in the specification or scoping phase, not in a recent code change. The key question is: **when was this area last worked on, and should this case have been captured as a requirement of that work?**

---

## Scaling

Not every analysis needs all 9 sections at full depth. Match the output to the severity and complexity of the input.

**Minimum (bug, minor gap, "how did we miss this?"):**
- Key Finding
- Root Cause (Technical) — what's the gap, when was the area last worked on, should this have been in scope
- Where the Process Broke — which stage should have caught it (usually refinement/scoping)
- Actions — what changes to prevent this class of gap

**Standard (production incident, customer-impacting bug, SRV):**
- All sections, proportional depth. Skip Incident Management only if this was never a live issue.

**Full (P1/P2 outage, repeat incident, data loss, financial impact):**
- All sections at full depth. Historical context and pattern analysis should be thick. "What Good Looks Like" section should be concrete enough to use as a template for future work in this area.

State which level you're operating at in the output.

---

## Triggering

Activate with `#process-analysis-rca` and provide:
- The ticket(s) involved (SRVs, dev tickets, or just a description of the pattern)
- Any additional context: Slack threads, specific concerns, whether this is a repeat issue

The skill will trace the chain from there.

---

## Data Retrieval

Pull from all available sources. Work backwards from the incident to the root cause.

**Complete all data retrieval before producing findings.** Do not write up analysis with "unknown — worth checking" placeholders for information that is available in Jira, GitHub, or Confluence. If the Slack thread or ticket references a PR, a release, or a code change — go and get it. The analysis should be informed by the actual code diff, review comments, and test coverage, not just what people said in conversation. If a source is genuinely unavailable (private repo, deleted branch, no access), state that explicitly. But if it's just un-fetched, fetch it first.

### Jira
- Fetch the SRV/incident ticket with `fields=*all` and `comment_limit=100`
- ACs, test plans, and notes live in custom fields — they will NOT appear in default field fetches
- Identify linked dev tickets (issue links, mentioned keys in comments, smart-links in fields)
- Fetch the dev ticket(s) (full fields + comments + test notes field)
- Check for parent epics, sub-tasks, sibling tickets
- Look for previous SRVs on the same area (search by summary keywords or component)
- Check ticket status, dates, and transitions for timeline
- Read the Test Notes field (`customfield_11284`) — this is where test plans, QA results, and observations are documented
- Read Implementation Notes (`customfield_11311`) — this is where devs document their approach
- Read the Problem Statement field (`customfield_11274`) — this explains why the work matters
- Read Acceptance Criteria (`customfield_11277`) — this defines what done looks like

**Field discovery reminder**: Do not assume field IDs are static across projects. If a field comes back null but you expect content, search for the field by keyword using Jira field search. Content lives in unexpected places.

### GitHub
- Search for PRs referencing the dev ticket key
- Pull the PR diff — what actually changed in the code. This is non-optional; the diff is primary evidence for "what was done" vs "what was said"
- Read the PR description — what was the intent. If the description is empty, that itself is a finding (no stated intent for reviewers to challenge)
- Check the file(s) modified — are there other instances of the same pattern in the codebase
- Check PR review comments — did anyone raise concerns. If no comments exist, state that explicitly ("approved without comment") rather than "unknown"
- Check who reviewed, whether they had domain knowledge of the affected area, and whether the review was proportional to the risk of the change
- Note the time between PR creation and merge — this indicates whether review was given adequate time

**The PR data directly informs the "Where the process broke" section.** Do not write up findings about code review, testing, or development quality without first examining the actual PR. Statements like "code review was insufficient" must be backed by evidence: what was in the diff that should have been questioned, who reviewed it, what comments (if any) were left.

### Confluence
- Search specifically for: architecture decisions, coding standards, or documented patterns that apply to the area that broke
- Check if the area has documented known issues, previous investigations, or prior RCA pages
- Look for existing guardrails or standards that the change may have violated — if they exist and were ignored, that's a compliance failure; if they don't exist, that's a missing guardrail

Do not do a general trawl of documentation for its own sake. Confluence search is valuable when targeted: "is there a standard that should have prevented this?" or "has this been flagged as a risk before?"

### Domain Enrichment (when relevant)

Do this when the failure is related to how a feature is used or configured — not when the bug is a straightforward code error that doesn't depend on configuration.

- How is the feature configured by users? (User guides, setup docs)
- What's the normal/default setup? (Is the pattern that caused the issue the standard case or an edge case?)
- Are there known quirks, workarounds, or documented limitations?

If domain context contradicts assumptions in the fix or test plan, flag it explicitly. That's often where the real gap is — the team treated a common scenario as unusual.

Skip this section entirely if the failure is a pure code defect (e.g. wrong caching strategy, race condition, null pointer) that doesn't depend on user configuration.

---

## Output Structure

Every RCA follows the same structure. The depth of each section scales with relevance — answer the questions that matter, skip the ones that don't, but state which stages you're skipping and why.

**Lead with the most important finding.** The reader should know within the first 30 seconds what the single biggest takeaway is.

---

### 1. Key Finding

One or two sentences: the single most important insight from this analysis. What is the thing that, if addressed, would have prevented this incident?

Then classify it: "This incident is an instance of [class of problem]." Name the class — not just the specific bug but the pattern it represents. Examples:
- "Performance optimisation that introduces shared mutable state in a long-lived process"
- "Narrow fix that addresses the reported case but not the underlying pattern"
- "Change to a critical path shipped under time pressure with compressed review"

This classification drives the pattern analysis and helps the team recognise the same class of mistake in future.

### 2. Summary

One paragraph: what happened, when, who reported it, what the customer experienced.

**Impact quantification (required):**
- How many records/bookings/users were affected? (Exact or order of magnitude)
- What's the financial exposure? (Revenue delayed, refund liability, lost sales)
- What's the blast radius? (One client, all clients, one flow, all flows)
- What did the customer actually experience? (Wrong emails, double charges, blocked from action, delayed tickets)

Don't be vague. "Some bookings were affected" is not useful. "~2/3 of bookings in a 15-hour window showed as underpaid, blocking e-ticket delivery" is.

### 3. Timeline

| When | What | Source |
|------|------|--------|
| [date] | Change introduced / deployed | PR #XXXX / Jira status |
| [date] | Issue first observable | Logs / monitoring / first report |
| [date] | Issue reported | SRV-XXXX / Slack |
| [date] | Investigation started | Jira comment / Slack |
| [date] | Root cause identified | Jira comment / code evidence |
| [date] | Fix applied / rollback | PR / deployment |
| [date] | Issue confirmed resolved | Jira / monitoring |

Build from ticket creation dates, comment timestamps, PR dates, and status transitions. Include previous occurrences if this is a repeat issue.

### 4. Incident Management

*Skip this section for bugs that were never a working feature. State: "Not applicable — this is a gap in the original implementation, not a regression."*

- How was the issue discovered? (Monitoring, customer report, internal testing)
- How long between occurrence and discovery?
- Was communication clear when reporting to tech?
- Was an incident lead established? (For P1/P2)
- Were expectations managed with the reporter?
- Was the response proportional and timely?

### 5. Root Cause (Technical)

**For incidents (something broke):**
- What were the symptoms?
- What was the actual technical cause?
- When was it introduced? (Which change, which PR, which release)
- What does the code diff show? (Summarise the change and explain why it caused the failure)
- Was the root cause identified correctly during the incident? (Compare Jira/Slack discussion against code evidence)

**For bugs (something was never built / never handled):**
- What is the gap? What case is not handled?
- When was this area last worked on? (Which epic, which tickets, which PRs)
- Should this case have been captured as a requirement of that work? (Was it a foreseeable scenario given the feature's purpose?)
- Was this case explicitly out of scope, or was it simply not considered?
- If out of scope — was the decision documented and was there a plan to address it later? Did "later" ever come?
- If not considered — what about the original specification, refinement, or acceptance criteria should have surfaced it? Who was involved in scoping and what did they have visibility of?
- Is this a known limitation that escaped, or a genuinely unforeseen scenario?
- Did the client or ops team flag this need before it became a bug? (Check Jira comments, SRVs, Slack history)

**Was the original problem worth solving, and was the urgency justified?**
- What was the change trying to fix or improve?
- How severe was the original problem? (P1 outage vs UX annoyance vs tech debt)
- Was the priority/urgency of the change proportional to the risk it introduced?
- If a non-urgent improvement was treated as urgent, identify that mismatch — it's often the root cause of compressed review and testing.

**What should the correct implementation have been?**

Don't just say "the approach was wrong." Provide enough technical detail that the developer re-attempting this work has a concrete starting point:
- What's the correct design pattern or approach?
- Why does it avoid the problem the original change introduced?
- Are there tradeoffs to the correct approach?

This turns the RCA into something actionable for the re-implementation, not just a post-mortem.

### 6. Where the Process Broke

Walk through each stage and identify where the gap was. Not "who got it wrong" but "which stage let something through that it should have caught." Back each finding with evidence from the systems.

**Only cover the stages that are relevant.** If a change had no refinement phase (quick fix), skip refinement but state "no refinement occurred — this was raised and shipped same-day." If QA was not involved, state that. Don't force every sub-question when it doesn't apply.

**Refinement / Scoping**
- Was the scope discussed beyond the immediate ask?
- Did anyone ask "where is this code used?" or "what contexts does this run in?"
- Was the approach reviewed before implementation?
- Was the urgency proportional to the actual risk?

**Development**
- Did the change solve the problem correctly, or introduce a new one?
- Was the code change consistent with what was communicated in the ticket?
- Were side effects considered? (Other consumers of the code, different execution contexts)
- Were other instances of the same pattern addressed or left untouched?

**Code Review**
- Did reviewers have domain knowledge of the affected area?
- Did anyone question the approach, raise risks, or challenge assumptions?
- Was the PR description present and sufficient for a reviewer to understand intent and risk?
- Was review time proportional to the risk of the change?
- If no concerns were raised — what in the diff should have prompted a question?

**QA / Testing**
- Was there a test plan? Did it cover more than the exact reported scenario?
- Was the fix validated in the context it actually runs in? (Not just unit tests — integration, worker processes, etc.)
- Was regression scope appropriate for the area of change?
- Was historical data considered?

**Release / Post-Release**
- Was the deployment timing appropriate for the risk level?
- Was there post-deploy validation or monitoring?
- How long before the issue was detected?
- Was there a way to detect the issue automatically that wasn't in place?

**Existing standards or documentation that should have prevented this:**
- Is there an existing coding standard, architecture decision, or documented pattern that this change violated?
- If yes → this is a compliance failure. The guardrail existed but wasn't followed. Why?
- If no → this is a missing guardrail. Should one be created?

### 7. Historical Context & Pattern Analysis

Zoom out beyond the single incident.

- Has this area broken before? (Search for previous SRVs, related incidents)
- Is the root cause a one-off mistake or a recurring pattern?
- Are there other instances of the same technical vulnerability still in the code? (GitHub search)
- Did a previous incident or near-miss provide a signal that wasn't acted on?
- Is there a systemic gap? (e.g. no integration tests for worker processes, PR reviews don't challenge performance optimisations, no post-deploy smoke tests for payment flows)

If this is a repeat issue, reconstruct the chain: what was done last time, why didn't it stick, and what's different now.

**Name the class of problem:** "Other instances of this class to check: [list]." This is often the most valuable output — not just "this broke" but "this pattern exists in N other places."

### 8. What Good Looks Like

Don't just list failures. Show the team what the ideal version of this change would have looked like:

- **The PR description that should have existed** — what would a good one have said? (Intent, approach, risks, what to look for in review)
- **The review questions that should have been asked** — specific questions a reviewer should have raised given what was in the diff
- **The test that should have existed** — what test, at what level (unit/integration/smoke), would have caught this before production?
- **The deployment approach that would have limited blast radius** — canary, feature flag, phased rollout, time-of-day constraints

This gives the team a concrete positive model. People learn better from "here's what good looks like" than from "here's everything you did wrong."

### 9. Actions

Specific, ownable, verifiable changes — not "be more careful."

| **Action** | **Owner** | **Addresses** | **How to verify** |
|------------|-----------|---------------|-------------------|
| ... | ... | Section X finding | ... |

**Each action must link back to a specific finding.** "Add integration test for payment worker flow" is more valuable when tied to "Section 6, QA/Testing: the PR included unit tests for the Factory class but did not test the static cache behaviour in the worker context."

Each action should answer: "If this had been in place before the incident, would it have prevented or significantly reduced the impact?" If the answer isn't a clear yes — the action isn't specific enough.

Split actions into:
- **Immediate** — fix the current problem, correct bad data, notify affected parties, re-implement the original change correctly
- **Preventative** — stop this class of problem from recurring (not just this specific instance)

---

## Principles

- **Evidence over memory.** Pull timestamps, quotes, and diffs from the systems. Don't rely on what people remember — show what the systems recorded.
- **No deferred questions for available data.** If a Slack thread mentions a ticket, a PR, or a release — fetch it and incorporate the findings before writing up the analysis. "Unknown from Slack alone" is not acceptable when the PR is linked in Jira and the diff is one API call away. The output should contain conclusions informed by evidence, not open questions that could have been answered during retrieval.
- **Blame-free.** Name roles, not people. "QA passed it without documented comparison" — not "Christian didn't check properly." The point is to fix the process, not assign fault.
- **Proportional depth.** A simple missed test case doesn't need 3 pages of analysis. A systemic pattern that's produced repeat incidents does. Match the depth to the impact. Skip sections that don't apply, but state why you're skipping them.
- **Mismatch detection.** Actively look for gaps between what was said and what was done: Jira comments vs code, PR description vs diff, test plan vs actual testing, stated fix vs actual fix.
- **The "where else?" question.** Always ask it. If the root cause is a pattern (not a one-off typo), search for other instances. The most valuable output of an RCA is often "this same vulnerability exists in 4 other places."
- **Historical data.** For any data-correctness issue, always state: does the fix correct old data, does old data need migration, or is old data permanently wrong?
- **Name the class, not just the instance.** Every incident is an instance of a broader class of problem. Naming the class helps the team recognise it next time. "Static cache in a worker-consumed class" is more useful long-term than "SN-1947 caused a BRT failure."
- **Customer perspective.** Always state what the customer experienced — not just what broke technically. This determines whether the incident needs customer comms, refunds, or just a quiet fix.

---

## Output Format

When presenting in chat, use standard Markdown.

When writing to Confluence, use Confluence storage format or ask for the target space/page.

The output is a starting point for discussion — not the final word. Flag where evidence is incomplete or where the team needs to fill in context that isn't in the systems.
