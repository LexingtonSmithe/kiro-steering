# Ticket Analysis Suite — Kiro Steering Skills

A modular set of Jira ticket analysis skills for [Kiro](https://kiro.dev), designed to bring structured quality review to backlog items, sprint work, and epics — without replacing the team's own thinking.

These skills are agent-agnostic markdown prompts — they work in any AI tool that can read instructions and call the Jira API (Claude Desktop, Cursor, Windsurf, etc.).

## What This Is

A collection of steering files that teach Kiro how to analyse Jira tickets across multiple quality dimensions. Skills are board-agnostic — they discover custom fields dynamically and adapt to whatever Jira configuration they encounter.

---

## Skills by Purpose

### Workflow Tools (use regularly, built into process)

| Skill | File | When to use |
|-------|------|-------------|
| **Spark** | `ticket-analysis-spark.md` | After PO write-up or after refinement. ~30 lines — surfaces questions and gaps to discuss. No scoring, no explanations |
| **Sprint Retro** | `sprint-analysis-retro.md` | End of sprint. Patterns across all tickets — what improved, persisted, regressed. Compares against previous sprint if provided |

### Deep Dive (use on-demand, when something needs investigation)

| Skill | File | When to use |
|-------|------|-------------|
| **Full Suite** | `ticket-analysis-suite-index.md` | Epic reviews, pre-release audits, new initiative scoping. Runs all relevant skills |
| Content Quality | `ticket-analysis-content-quality.md` | Specific concern about AC clarity, implied rules, adjacent features, or spec vs expectation |
| Type Correctness | `ticket-analysis-type-correctness.md` | Validate issue type and hierarchy/split |
| INVEST | `ticket-analysis-invest.md` | Sprint readiness check |
| Value & Measurement | `ticket-analysis-value-measurement.md` | Epic hypothesis, ticket contribution, success criteria |
| Implementation & Test | `ticket-analysis-implementation-test.md` | Dev/test approach alignment with AC |
| Release & Operations | `ticket-analysis-release-operations.md` | Dependencies, toggles, monitoring, rollback |
| Quality Attributes | `ticket-analysis-quality-attributes.md` | Non-functional requirements (performance, security, a11y) |
| Documentation | `ticket-analysis-documentation.md` | Doc links and quality of referenced docs |
| Bugs | `ticket-analysis-bugs.md` | Dedicated bug assessment framework |
| Spikes | `ticket-analysis-spikes.md` | Time-box, output, scope, success criteria |

### Housekeeping (use for cleanup and admin)

| Skill | File | When to use |
|-------|------|-------------|
| **Propose Corrections** | `ticket-analysis-propose-corrections.md` | After analysis identifies issues. Generates safe corrections from existing content — never auto-applies |
| **Formatting** | `ticket-analysis-formatting.md` | Structural consistency — AC numbering, field placement, duplication |

---

## Report Modes (Deep Dive)

When running a deep dive (full suite or individual skill), specify which report mode you want:

| Mode | What you get | When to use |
|------|-------------|-------------|
| **Full report** | Everything — what's good, what's bad, and why. Scores each dimension with explanation | When you need the complete picture (onboarding, audits, documentation) |
| **Gaps only** | Just the issues — no commentary on what passes. Only ⚠️ and ❌ findings | When you want action items without noise (quick reviews, busy sprints) |

If not specified, the default is **full report**. Request gaps-only with: "analyse [ticket] — gaps only" or "full suite, gaps only."

---

## How to Use

### Setup

1. Copy the `.kiro/steering/` directory into your workspace
2. All skills use `inclusion: manual` — activate them via `#skill-name` in Kiro chat

### Everyday (Spark)

```
#ticket-analysis-spark

Spark SG-1234
```

### Deep Dive (Full)

```
#ticket-analysis-suite-index

Full suite analysis on PROJ-567
```

### Deep Dive (Gaps Only)

```
#ticket-analysis-suite-index

Analyse PROJ-567 — gaps only
```

### Sprint Retro

```
#sprint-analysis-retro

Run retro against Sprint [name] for [board]
```

---

## Requirements

- **Kiro** with Jira MCP integration configured
- **Jira access** to the boards you want to analyse
- Optionally, **Confluence** access if you want results posted to wiki pages

### MCP Configuration

Add the Atlassian MCP server to your `.kiro/settings/mcp.json` (workspace) or `~/.kiro/settings/mcp.json` (user-level):

```json
{
  "mcpServers": {
    "atlassian": {
      "command": "uvx",
      "args": ["atlassian-mcp-server"],
      "env": {
        "CONFLUENCE_URL": "https://your-domain.atlassian.net/wiki",
        "CONFLUENCE_USERNAME": "YOUR_EMAIL",
        "CONFLUENCE_API_TOKEN": "YOUR_API_KEY",
        "JIRA_URL": "https://your-domain.atlassian.net",
        "JIRA_USERNAME": "YOUR_EMAIL",
        "JIRA_API_TOKEN": "YOUR_API_KEY"
      },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

Generate an API token at [https://id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens).

---

## Design Principles

- **Quality over presence** — never "is this field populated?" always "is this good enough to act on?"
- **Board-agnostic** — discovers fields dynamically rather than hardcoding IDs
- **Lifecycle-aware** — same gap is informational in backlog, concerning in sprint, critical at release
- **Questions over findings** — questions force decisions, findings allow deferral
- **Trust the team** — surface what might be missed, don't dictate answers
- **No auto-writes** — proposals only, human decides

---

## Customisation

- **Add role-specific actors** to the content quality skill's user story validation
- **Add known documentation gaps** to suppress in the documentation skill
- **Adjust severity framing** if your workflow statuses differ from the defaults
- **Add weasel phrases** to the index as you discover them in your team's tickets

---

## History

See [LESSONS.md](./LESSONS.md) for the iterative journey from first draft to current state — each phase represents a calibration or design decision made through real-world use.

---

## License

MIT — use it, fork it, adapt it.
