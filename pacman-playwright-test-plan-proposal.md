# Pacman Playwright Test Plan — Proposal (SN-2347)

**Status:** Draft for human review (plan.md step 4)
**Scope:** Proposed Playwright coverage for the three Pacman user journeys under epic SN-2347 — U1 Booking Creation (SN-2348), U2 Create Package (SN-2349), U3 User Admin (SN-2350).
**Sources used:** SN-2347 + child tasks (Jira); Pacman User Guides (Confluence UG space); Qase KQA audit page (QA space); Squad Valve Process RCA Apr–Jul 2026 (QA space). The linked Google Sheet could not be read (auth); journey steps below are reconstructed from the SN-2348 description and plan.md and should be reconciled with the sheet during review.

---

## 1. Summary and recommendation

The three journeys as written in plan.md are **operational workflows**, not single features. U1 in particular bundles ~12 distinct capabilities (manual booking creation, transport, accom, extras, payment, apportionment, refund, email resend, pax cancellation) into one "journey". Treating that as one linear Playwright test would produce a long, brittle spec that fails for unrelated reasons and tells you little when it goes red.

**Recommendation: keep the three journeys as the delivery/reporting unit (one Jira task each, as already structured), but implement each as a small suite of focused specs plus one thin end-to-end "golden path" per journey.** This matches the `playwright-test-building` convention in this repo: feature/engine specs stop at their purpose; only the e2e regression spec runs the full flow. It also lets a red test point at a specific capability instead of "the booking journey broke somewhere."

A re-categorisation by capability (section 4) is proposed over the flat journey list, because several capabilities recur across journeys (e.g. allocations appear in U1 and U2) and the highest-risk areas (payments, refunds, cancellation) deserve to be their own named specs rather than being buried mid-journey.

---

## 2. Assumptions and questions (resolve before build)

**Questions (blocking or near-blocking):**

1. **Environment + test data** — AC2/AC4 say local or Staging. Staging Pacman is `https://staging-pacman.kaboodle.co.uk/`. Which is the target for CI, and is there a seeded client we are allowed to mutate repeatedly? *Who: QA lead / Matthew.*
2. **Login** — the Qase audit confirms Pacman moved to Weez SSO (Log in with Weez → Sign in with Weezevent staff → Select Kaboodle). Can we get a non-interactive/service login for CI, or do we need a stored auth state? SSO + MFA is the single biggest automation blocker. *Who: Dev / Platform.*
3. **Payments in a test env** — U1 includes make payment, apportion, refund. Does Staging use a Lyria/Stripe sandbox that lets a test complete and then refund a payment without real money movement? If not, payment/refund steps can only be asserted up to "link generated / request sent", not "paid". *Who: Payments dev.*
4. **Which client per journey** — the Qase risk-based client map (section 6) assigns clients to capabilities. Confirm which client each spec should target on Staging. *Who: QA lead.*
5. **Email/e-ticket resend verification** — can we assert the resend actually happened (outbound mail capture / API), or only that the UI reported success? *Who: Dev.*
6. **Qase linkage** — there is no `PACMAN` Qase project; the relevant project is **KQA**, and the Pacman suite was recently rewritten (audit page). Should these Playwright specs map 1:1 to existing KQA cases (e.g. 76 login, 80 uploader, 81 extras, 82 transport, 83 accom), and should runs be reported back to Qase via CI? *Who: QA lead.*

**Assumptions (flag if wrong):**

- Manual Booking Creator (not the CSV uploader) is the U1 entry point — the SN-2348 description says "Manual Booking Creator Tool." Confluence documents both on the same Guestlist page; the Creator is the interactive form, which is the better automation target.
- "More than one pax" means one booking containing multiple customers (same Group Booking Ref), per the uploader column rules.
- Apportion payment = splitting a payment across pax/items on the booking (Outstanding Pax Balance exists in the payments UI). Confirm exact meaning against the sheet.
- There is little to no unit-test coverage underneath Pacman (per team meeting notes + RCA), so these e2e tests are compensating for a thin pyramid base. See section 7.

---

## 3. Test-level strategy (test pyramid)

The QA strategy wants the usual pyramid — lots of unit, fewer integration, few e2e. Pacman's reality (from the RCA and team notes) is an **inverted pyramid**: almost no unit tests, feature flags/system config instead of guard clauses, and 48 bugs in 6 weeks with 77% clustering in 5 areas. Playwright here is being asked to "make up" for that.

Guidance for this work:

- **Use Playwright for journeys and cross-engine behaviour** — the things only an e2e can catch (booking total after adding transport + accom + extra; refund restoring balance; cancellation adjusting charges). This is where Pacman actually breaks.
- **Do not use Playwright to brute-force every field validation.** Max-char limits, dropdown contents, and single-field rules are cheap at a lower level and slow/brittle at the UI level. Note them as candidates for API/component tests and keep the Playwright set lean (the repo convention: stop at purpose, don't gold-plate).
- **Explicitly accept the compensating role but cap it.** Where there is genuinely no lower-level option, a Playwright assertion is justified — but each one added "because there's nothing underneath" should be tagged so the debt is visible and can migrate down later.
- **Golden-path e2e per journey + focused specs around it.** One buy-and-verify e2e per journey proves the flow; the focused specs prove each capability and stop at purpose.

---

## 4. Proposed categorisation (capability-based)

Instead of three flat journeys, group specs by capability. Journeys U1/U2/U3 remain the Jira tasks and the e2e names; the specs below sit under them.

### Group A — Access & Session (shared foundation, blocks everything)
- `A1` Login via Weez SSO (reused as setup by every spec; stored auth state)
- `A2` Client/context selection (navigate to a client, e.g. Kaboodle Labs / Snowbombing)

### Group B — Booking Creation (U1 / SN-2348)
- `B1` Create a manual booking with >1 pax (Manual Booking Creator)
- `B2` Add transport to a booking → basket/total updates
- `B3` Add accommodation to a booking → basket/total updates
- `B4` Add an extra to a booking → basket/total updates
- `B5` **Make a payment** (high risk)
- `B6` **Apportion a payment** across pax/items (high risk)
- `B7` **Refund a payment** → balance restored (high risk)
- `B8` Resend confirmation email + e-ticket email
- `B9` **Cancel a pax** against the booking → charges/balance correct (high risk)
- `B-e2e` Golden path: create → add 3 engines → pay → verify summary & prices

### Group C — Package & Operations (U2 / SN-2349)
- `C1` Create a package
- `C2` Add/edit transport on a package
- `C3` Add/edit accommodation on a package
- `C4` Add/edit extras on a package
- `C5` Add allocations to tickets/extras/accom/transport in Operations
- `C6` Remove allocations in Operations
- `C7` Attach ticket/extra/accom/transport allocations to packages
- `C8` Add/remove existing allocations on packages
- `C9` Create rules (discount scheme / package rules)
- `C-e2e` Golden path: create package → attach one of each engine → verify it is bookable

### Group D — User Admin (U3 / SN-2350)
- `D1` Create a new user
- `D2` Give/remove user permissions
- `D3` Give/remove user roles (note: you can only assign roles you hold; external client-group restrictions apply)
- `D4` Reset a user password
- `D5` Run a report
- `D6` Assign clients to a user → validate those clients appear for that user
- `D-e2e` Golden path: create user → assign role + client → confirm access scope

**Why this is better than the flat list:** allocations (C5–C8) are one capability expressed four ways — grouping them stops four near-duplicate specs drifting apart. The three highest-risk items (B5–B7, B9) become first-class named specs instead of steps 7–11 of a long journey, so a failure names the capability. Access (Group A) is factored out because it is a precondition for all 30+ specs and should be solved once.

---

## 5. Test plan tables

Priority: **High** = core AC / happy path / data integrity; **Med** = edge/error handling; **Low** = exploratory/unlikely. Per the repo convention, feature specs stop at purpose; only the `*-e2e` rows run the full buy/verify flow.

### U1 — Booking Creation (SN-2348)

| # | Spec | Setup | Action | Expected outcome | Verification | Priority |
|---|------|-------|--------|------------------|--------------|----------|
| 1 | B1 | Logged in (A1), client selected, package with ticket types exists | Create a manual booking with 2+ pax via Manual Booking Creator; use Check then Create Booking | Booking created with both pax; booking ref shown | Booking appears; pax count = 2; header totals present | High |
| 2 | B2 | Booking from B1 open | Add a transport route (outbound+return) | Transport line added; basket total increases by transport price | Await basket update, then assert line + new total | High |
| 3 | B3 | Booking open | Add accommodation (room/tier) | Accom line added; total updates | Await basket update; assert line + total | High |
| 4 | B4 | Booking open | Add an extra | Extra line added; total updates | Await basket update; assert line + total | High |
| 5 | B5 | Booking with outstanding balance | Make a payment (Send To Customer → generate link, or test-sandbox pay) | Payment recorded / link generated; outstanding balance reduced on confirm | Payments tab shows entry; Outstanding Balance drops; header status updates | High |
| 6 | B6 | Booking with >1 pax and a payment | Apportion the payment across pax/items | Payment split reflected per pax; per-pax outstanding balances correct | Assert Outstanding Pax Balance figures sum correctly | High |
| 7 | B7 | Booking with a confirmed payment | Refund that payment | Refund recorded; booking balance restored by refunded amount | Payments tab shows refund; Outstanding Balance back up; status correct | High |
| 8 | B8 | Booking with confirmation sent | Resend confirmation email and e-ticket email | UI confirms resend; (ideally) outbound mail captured | Assert success toast; if possible assert mail/API event | Med |
| 9 | B9 | Booking with ≥2 pax, part-paid | Cancel one pax | Pax cancelled; cancellation charge (type 742, not Misc/Other) applied; totals adjust | Assert pax state, charge type, booking balance end-to-end | High |
| 10 | B-e2e | Clean state | Create → transport → accom → extra → pay → open summary | Booking summary correct; prices correct at each stage | Running basket total validated after each add; final summary asserted | High |
| 11 | B5–B7 | Fully-paid vs part-paid booking | Attempt payment on fully-paid; refund more than paid | Blocked / sensible error | Assert guard/error, no negative balance | Med |

### U2 — Create Package (SN-2349)

| # | Spec | Setup | Action | Expected outcome | Verification | Priority |
|---|------|-------|--------|------------------|--------------|----------|
| 1 | C1 | Logged in, client selected (e.g. Printworks for ticket-only) | Create a package; set Booking Start Date = today; enable bookings | Package created and bookable | Package visible; booking status = Bookings Enabled | High |
| 2 | C2 | Package exists | Add then edit a transport route (e.g. Manchester → Mayrhofen) | Route attached; edit persists | Route shows on package with updated values | High |
| 3 | C3 | Package exists | Add then edit accommodation (room + tier) | Accom attached; edit persists | Accom shows with price tier | High |
| 4 | C4 | Package exists | Add then edit an extra (Operations → Extras → attach) | Extra attached; edit persists | Extra shows on package | High |
| 5 | C5 | Package with engines | Add allocations to ticket/extra/accom/transport in Operations | Allocation counts increase; reflected on package | Operations figures match package | High |
| 6 | C6 | Allocations exist | Remove allocations in Operations | Counts decrease correctly | Figures update; no stuck stock | Med |
| 7 | C7/C8 | Existing allocations | Attach / add-remove existing allocations on the package | Package reflects attached allocations | Package engine lists correct | Med |
| 8 | C9 | Package exists | Create a discount scheme/rule and attach it (e.g. BGC, QATEST10 10%) | Rule attached and applies | Discount applies in a test booking | Med |
| 9 | C-e2e | Clean state | Create package → attach one of each engine → make a test booking against it | Package is fully bookable end to end | Test booking succeeds with all engines | High |

### U3 — User Admin (SN-2350)

| # | Spec | Setup | Action | Expected outcome | Verification | Priority |
|---|------|-------|--------|------------------|--------------|----------|
| 1 | D1 | Logged in as System Admin | Create a new user (System Administration → Users) | User created | User appears in Users search | High |
| 2 | D3 | User exists | Give then remove a role (Users → Roles) | Role toggles on/off; save persists | Roles reflect selection; respects "can only assign roles you hold" | High |
| 3 | D2 | User exists | Give then remove a permission | Permission toggles; save persists | Permission state correct | High |
| 4 | D4 | User exists | Reset the user's password | Reset triggered | UI confirms; (ideally) reset event captured | Med |
| 5 | D6 | User exists | Assign clients to the user, then log in / impersonate as that user | Assigned clients appear for the user; unassigned do not | Validate client list scope for that user | High |
| 6 | D5 | Logged in | Run a report | Report generates and downloads | File produced; (optional) content sanity | Med |
| 7 | D3 | External client-group user | Attempt to assign a Self Service role | Blocked per rule (external client-group restriction) | Assert the restriction is enforced | Med |
| 8 | D-e2e | Clean state | Create user → assign role + client → confirm access scope | User can see only assigned clients/areas | Scope asserted end to end | High |

---

## 6. Risk-based client selection (from Qase KQA audit)

Use the appropriate client per capability rather than defaulting to one:

| Client | Best for |
|--------|----------|
| Printworks | Ticket-only packages, ticket types, resale |
| Boomtown | Pay-in-full only, simple ticket packages |
| Victorious | Pay-in-full + payment plan choice, simple accom |
| Lost Village | Payment-plan-only packages |
| Snowbombing / Hideout | Complex accom (extended nights), transport, extras, dynamic allocations |
| Standon Calling | Simple accom (fixed core nights, Simple Mode) |
| BGC | Discount schemes |
| Ynot | Payment plan config, communication events |

For U1 a client with transport + accom + extras (Snowbombing/Hideout) exercises the most engines in one booking. For U2 pick per the engine under test. For U3 client choice is mostly irrelevant except D6 (client assignment).

---

## 7. Risks

| Risk | Likelihood | Impact | Test action |
|------|-----------|--------|-------------|
| Weez SSO + MFA blocks headless CI login | High | High | Resolve Q2 before build; use stored auth state / service account; covered by A1 |
| Payment/refund can't complete in test env (no sandbox) | Med | High | Resolve Q3; if blocked, assert up to "request sent" and flag refund (B7) as not fully covered |
| Payments/Lyria domain is the most defect-prone area (17 bugs/6 wks) | High | High | B5–B7 are High priority and e2e; cover full lifecycle create→pay→refund in one spec, not in isolation (RCA Pattern "QA tests the ticket, not the system") |
| Cancellation logic fragile across entry points (wizard vs uploader vs approval) | Med | High | B9 asserts charge *type* (742) and end-to-end balance, not just "pax cancelled" |
| Shared/mutable test data drifts between runs | High | Med | AC4 requires documented setup; each spec must create its own state and clean up; needs Q1 answered |
| Long linear journey spec fails for unrelated reasons | High | Med | Mitigated by capability split (section 4); e2e stays thin |
| Playwright over-compensates for missing unit tests → slow, brittle suite | Med | Med | Section 3 caps UI-level field validation; tag compensating assertions as debt |
| Google Sheet is the real source of journey steps and differs from reconstruction | Med | Med | Reconcile sections 4–5 against the sheet in review (step 4) |

---

## 8. Gap analysis — high-risk things this does NOT cover

Scoped to high-risk only, per plan.md.

1. **Report accuracy (Boutique Accommodation Summary / remittance).** The single most repeated failure in the RCA — 4 tickets over 2+ months, still open, name-vs-ID lookup collision. U1–U3 touch "run a report" (D5) only at "a file is produced." They do **not** validate report *figures* against an independent source. This is high risk and explicitly out of scope here; it needs its own data-comparison test (compare Pacman output vs SQL/Looker), which is a different test type.
2. **Payment lifecycle edge cases beyond the golden path.** Partial payments, payment plans (deposit vs full balance vs additional), overcharge on final payment (SN-1835), and webhook payload gaps (SN-1885) are the real payment risks. The plan covers one pay + one refund; it does not cover payment-plan math or webhook integrity.
3. **Cross-entry-point cancellation.** B9 covers the booking UI cancellation wizard. Cancellation via Booking Uploader and via the approval/Gandalf flow have had their own separate bugs (SN-1926, SN-1909) and are not covered.
4. **Null/incomplete-data states.** The RCA's "silent theme" — missing package_id, booking with no complete data capture, allocation with no booking ID. These are valid states that crash happy-path code. E2e golden-path tests will not exercise them; they need negative/defensive tests (better placed below the UI).
5. **Discount/pricing interactions.** DMCCA compliant pricing, global vs package discounts, "do not allow global discounts" option. C9 creates one rule; it does not cover discount interaction with booking fees or compliance display.
6. **Concurrency / stock integrity.** "Stock stuck" and dynamic allocation bugs are concurrency-sensitive; a single-user Playwright run cannot reproduce race conditions on allocations.
7. **Email/e-ticket content.** B8 verifies a resend was triggered, not that the email renders correctly or contains the right tickets.
8. **Non-functional:** performance under realistic data volume (team notes: local test data isn't representative of a full event), accessibility, and security/authorization depth beyond the role-restriction check in D3/D7.

---

## 9. Suggested next steps

1. Review this proposal (plan.md step 4) and answer the Q1–Q6 blockers in section 2.
2. On sign-off, I draft the SN-2348 / SN-2349 / SN-2350 story content (ACs, journey steps, QA/test notes, environment + test-data notes) using the test-plan + content-quality + formatting skills — presented for approval before any Jira write (plan.md steps 5–6).
3. Decide Qase linkage (map specs to KQA cases; report CI runs back to Qase — the audit notes zero runs have ever been executed).
4. Then build with the `playwright-test-building` pipeline, stage by stage, starting with Group A (login/session) since it blocks everything.
