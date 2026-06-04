---
inclusion: manual
---

# Ticket Analysis: Quality Attributes

You are reviewing whether the ticket addresses non-functional quality attributes that are relevant to the work being done. Not every attribute applies to every ticket — flag only those that are relevant but unaddressed.

## What to check

### Performance

- Are there expected response times or load times for this feature?
- Do we have a baseline measurement of current performance in this area?
- Could this change degrade performance? (Additional API calls, larger payloads, new queries)
- Are there performance tests that need creating or updating?

### Security

- Are there input fields that require sanitisation or validation?
- What access control measures are in place? (Who can use this feature?)
- Are there new libraries being introduced? (Version, known vulnerabilities)
- Does this handle sensitive data? (PII, payment info, credentials)
- Could this be exploited? (Injection, enumeration, privilege escalation)

### Accessibility

- Does this introduce new UI elements? (Forms, modals, navigation)
- Is tab order considered?
- Are labels associated with inputs?
- Is alternative text provided for images or icons?
- Are error messages announced to screen readers?
- Does this work with different client styles/themes?

### Scalability

- Does this work with 10 users? What about during an on-sale with thousands?
- Are there rate limits or throttling considerations?
- Could this create a bottleneck under load?

### Localisation

- Do other languages affect how this feature is displayed?
- Are there currency calculations involved?
- Are date/time formats locale-aware?
- Are strings translatable?

### Resilience

- If an external service is unavailable, what happens?
- Are there retry mechanisms or circuit breakers needed?
- How does the user recover from error states?
- Is there a degraded mode? (Feature unavailable but app still works)

### Observability

(Note: This skill checks whether *observability is architecturally possible* — can the code be debugged, are there log points, is data structured for diagnosis. Release & Operations checks whether *operational tooling is configured* — dashboards linked, alerts set, smoke tests defined.)

- Can we debug this in production? Are there logs, traces, or metrics that would help diagnose issues?
- Different from monitoring (which tells you something's wrong) — observability helps you figure out WHY
- Are log levels appropriate? (Not logging sensitive data, not too verbose, not too silent)

### Data Integrity

- For features that write data, what happens if the write partially fails?
- Are there orphaned records possible?
- Is the operation idempotent? (Can it be safely retried?)
- Are there race conditions that could corrupt data?

## How to assess relevance

- **UI ticket**: Accessibility, localisation, performance (load times) are likely relevant
- **API/backend ticket**: Performance, security, scalability, resilience, observability are likely relevant
- **Integration ticket**: Resilience, security, observability are likely relevant
- **Data change ticket**: Security (access control), performance (query impact), data integrity are likely relevant
- **Migration ticket**: Backward compatibility, data integrity, rollback of data changes are likely relevant
- **Cosmetic/copy ticket**: Localisation may be the only relevant attribute

## Flags to raise

- **Relevant but unaddressed**: The attribute clearly applies but the ticket doesn't mention it
- **Assumed but not stated**: "It should be fast" without defining what fast means
- **New risk introduced**: The change introduces a quality concern that didn't exist before

Do NOT flag attributes that genuinely don't apply to the ticket.

## Output

When scoring, always explain WHY — don't just mark ✅/⚠️/❌. For each relevant attribute, state what makes it addressed, what's assumed but unstated, or what's missing entirely.

```
## Quality Attributes Review

**Ticket**: [key]
**Score**: ✅ / ⚠️ / ❌

## Relevant Attributes

| Attribute | Relevant? | Addressed? | Notes |
|-----------|-----------|------------|-------|
| Performance | Yes/No | ✅/⚠️/❌ | ... |
| Security | Yes/No | ✅/⚠️/❌ | ... |
| Accessibility | Yes/No | ✅/⚠️/❌ | ... |
| Scalability | Yes/No | ✅/⚠️/❌ | ... |
| Localisation | Yes/No | ✅/⚠️/❌ | ... |
| Resilience | Yes/No | ✅/⚠️/❌ | ... |
| Observability | Yes/No | ✅/⚠️/❌ | ... |
| Data Integrity | Yes/No | ✅/⚠️/❌ | ... |

## Issues Found
[Attributes that are relevant but unaddressed, with specific recommendations]
```
