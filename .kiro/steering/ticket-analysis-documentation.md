---
inclusion: manual
---

# Ticket Analysis: Documentation

You are reviewing whether the ticket references relevant documentation and whether that documentation is adequate. Documentation means: a **Confluence page**, **user guide**, or **flow diagram**.

## What to check

### Documentation Referenced

- Does the ticket link to or mention any documentation?
- Types that count: Confluence pages, user guides, API docs, flow diagrams, design specs, PRDs
- Types that don't count: Jira ticket links (those are dependencies, not docs), code comments, PR descriptions

### Relevance of Linked Documentation

If documentation IS linked, assess:

- **Up to date**: Does the linked doc reflect the current state of the system, or is it stale?
- **Accurate**: Does the doc describe behaviour that matches what the ticket is building on or changing?
- **Complete**: Does the doc cover the area this ticket touches, or are there gaps?
- **Relevant**: Is the linked doc actually useful for understanding or testing this ticket?

### Audience Awareness

- Who is the documentation FOR? (Operations teams, developers, customers, support)
- Is the right audience served by the linked docs?
- Internal admin tools and operations platforms typically have user guides — if the ticket touches these areas, check whether documentation exists for the relevant audience.

### Documentation Impact

- Will this ticket's work require documentation updates?
- If it introduces new behaviour, is there a plan for how users/teams will learn about it?
- If it changes existing behaviour, will the existing docs become inaccurate once this ships?
- Is there an explicit statement of documentation impact? (Even "No docs impact" is acceptable)

### Missing Documentation

- Does this ticket change user-facing behaviour with no documentation referenced at all?
- Does this ticket modify internal processes with no runbook or guide linked?
- Is there documentation that SHOULD exist for this area but doesn't? (Flag as a gap, not a ticket failure — unless it's internal admin/process documentation which should typically exist)

## Flags to raise

- **No docs referenced**: Ticket changes behaviour but links to nothing
- **Stale docs linked**: Documentation is out of date and would mislead someone reading it
- **Docs will become inaccurate**: This ticket will make existing documentation wrong, but no update is planned
- **Missing docs acknowledged**: Ticket notes that docs don't exist yet (acceptable — it's at least acknowledged)
- **Docs exist but not linked**: You can see from the ticket context that relevant docs exist in Confluence but aren't linked from the ticket
- **Wrong audience**: Documentation exists but serves the wrong audience for this ticket's context

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. State what documentation exists, whether it's adequate for the ticket's needs, and what's missing or stale.

```
## Documentation Review

**Ticket**: [key]
**Score**: ✅ / ⚠️ / ❌

## Documentation Referenced
[What's linked? Is it relevant? Who is the audience?]

## Documentation Quality (if linked)
| Doc | Up to date | Accurate | Complete | Relevant |
|-----|-----------|----------|----------|----------|
| ... | ✅/❌ | ✅/❌ | ✅/❌ | ✅/❌ |

## Documentation Impact
[Will this work require doc updates? Is that acknowledged?]

## Issues Found
[Missing links, stale docs, unacknowledged impact]
```
