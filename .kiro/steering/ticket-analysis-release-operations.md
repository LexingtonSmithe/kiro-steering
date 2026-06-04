---
inclusion: manual
---

# Ticket Analysis: Release & Operations

You are reviewing whether the ticket addresses what happens when this work goes live — dependencies, rollout, monitoring, and operational readiness.

## What to check

### Dependencies & Hierarchy

- Are blockers and related tickets linked in Jira (not just mentioned in text)?
- Is the ticket correctly placed in the hierarchy? (parent Epic, sub-tasks where appropriate)
- Does it need to be released with another ticket? If so, is that dependency explicit?
- Are there cross-team dependencies? (e.g. Team A needs to deploy before Team B can consume the endpoint)

### Feature Toggles & Rollout

- Does this need a feature toggle? If so, is the toggle name/mechanism specified?
- Is there a rollout strategy? (All users immediately, subset of clients, phased rollout)
- If phased, what determines progression? (Time, metrics, manual decision)
- **Timing constraints**: Does this need to go live at a specific time? (Before an event, after another team deploys, during a maintenance window)

### Monitoring & Alerting

(Note: This skill checks whether *operational tooling is configured* — dashboards linked, alerts set, smoke tests defined. Quality Attributes checks whether *observability is architecturally possible* — log points exist, traces are structured, debugging is feasible.)

- Are relevant monitoring dashboards **linked** (not just named)?
- Will new alerts or health checks be needed for this feature?
- Does this introduce behaviour that would be unmonitored if no action is taken?
- How will we confirm the feature is working correctly post-release? (Smoke test, dashboard check, log review)

### Operational Readiness

- Will Client Ops or Customer Service need to know about this change?
- Is training or communication to internal teams mentioned?
- Is there a workaround procedure if the feature fails post-release?
- Can support teams diagnose issues without developer involvement?
- Who needs to be notified when it's live?
- **Data seeding**: Does the release require configuration or data to be set up in production before the feature works? (e.g. "Operations team needs to enable this per-client in the admin platform")

### Rollback

- If this causes a regression, what's the path back?
- **Distinguish between**: "Toggle off" (instant, safe) vs "revert deploy" (risky, may affect other changes in the release) vs "hotfix" (new code needed)
- Is the rollback path documented or obvious from the implementation?

## Flags to raise

- **Unlinked dependencies**: Blockers mentioned in text but not linked in Jira
- **No toggle for risky work**: User-facing change with no way to turn it off
- **No monitoring**: Backend/integration work with no dashboard linked
- **Dashboard named but not linked**: "We'll check Grafana" without a URL
- **Ops blind spot**: User-facing change with no mention of support team awareness
- **No rollback path**: Irreversible change with no contingency
- **Cross-team dependency unacknowledged**: Relies on another team's work without explicit coordination
- **Timing constraint unstated**: Work that must ship at a specific time but doesn't say so
- **Data seeding required but not documented**: Feature won't work without production config that nobody has planned

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. State what makes it pass, what's missing, or what question remains unanswered.

```
## Release & Operations Review

**Ticket**: [key]
**Score**: ✅ / ⚠️ / ❌

## Dependencies
[Linked? Cross-team? Release order? Timing constraints?]

## Rollout Strategy
[Toggle? Phased? All at once? Data seeding needed?]

## Monitoring
[Dashboards linked? Alerts needed? Unmonitored behaviour?]

## Operational Readiness
[Support teams aware? Workaround exists? Training needed?]

## Rollback
[Path back? Toggle-off vs revert vs hotfix?]

## Issues Found
[Specific gaps and recommendations]
```
