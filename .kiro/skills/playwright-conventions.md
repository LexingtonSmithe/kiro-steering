# Gold-standard conventions (kaboodle-solutions/booking-portal)

Concrete patterns the `playwright-test-building` skill assumes, taken from the
`booking-portal` `tests/` suite (branch `dev`). When abstracting in Stage 6,
match these. When picking a Stage 4 exemplar, pick the closest spec here.

Reference files (in the repo, under `tests/`):
- `helpers/basePage.ts` — the base page object all pages extend from.
- `helpers/accommodationPage.ts`, `ticketPage.ts`, `extrasPage.ts`, etc. — domain page objects.
- `helpers/newCustomerBookingJourney.ts` — a reusable multi-step journey.
- `testConfig.ts` — the custom `test` fixture (imported instead of `@playwright/test`).
- `accommodation.spec.ts` — engine test that stops once its purpose is met.
- `regression.spec.ts` — the full e2e that actually buys.

## 1. Page objects extend a base page; specs stay thin

Helpers are classes that take `page` in the constructor. Actions AND assertions
live on the page object; the spec orchestrates them. Do not put raw locators or
`expect` chains in the spec once you reach Stage 6.

```ts
export class BasePage {
  constructor(protected page: Page) {}

  async clickContinue(maxRetries = 3, timeout = 10000) { /* ... */ }
  async validateBasketTotal(basket: Basket) { /* expect(...) lives here */ }
  async assertItemNamesInBasket(names: string[]) { /* ... */ }
}
```

Domain pages are instantiated per-test and compose the base page's behaviour:

```ts
const basePage = new BasePage(page);
const ticketPage = new TicketPage(page);
const accommodationPage = new AccommodationPage(page);
const basket = new Basket();
```

`Basket` is a plain state object the test mutates as it adds items, then asserts
the running total against the UI (`basePage.validateBasketTotal(basket)`).

## 2. `test.step` with human-readable sentences

Every meaningful phase is wrapped in a `test.step` whose name is a full,
readable sentence. Steps nest.

```ts
await test.step('Accommodation Engine', async () => {
  await accommodationPage.hasLoaded();

  await test.step('Add Room without extras', async () => {
    // ...
    await test.step('Check `MAX_ROOMS_PER_BOOKING` Package Option Enforcement', async () => {
      // Increment to 5 to hit the limit
      await accommodationPage.incrementDecrementRoomSpinner(room, 'increment', 4);
      await accommodationPage.assertRoomSpinnerDisabledState(room, true, 'increment');
    });
  });
});
```

Inline `//` comments inside a step describe individual actions — this is exactly
what Stage 3 pseudocode becomes.

## 3. Stop at purpose; buy only in the e2e

This is a load-bearing convention. A feature/engine test validates its own
concern and then stops — it navigates forward with `clickContinue()` but does
NOT proceed through login, payment, and success.

`accommodation.spec.ts` ends like this (no purchase):

```ts
  await basePage.validateBasketTotal(basket);
  await accommodationPage.clickContinue();
}); // test ends here — accommodation purpose met
```

The full purchase lives only in `regression.spec.ts`:

```ts
await test.step('Payment', async () => {
  await customerDetailsPage.validateCustomerDataCaptureInBasket();
  await paymentPage.fillInStripeCardDetails();
  await paymentPage.clickPayNow();
});

await test.step('Booking Success', async () => {
  await successPage.validatePaymentSuccess();
  await successPage.validateBookingSuccess(customer.email);
});
```

When writing a new engine/feature test, do NOT add the buy flow. When writing
the e2e, reuse the shared journey rather than re-implementing steps:

```ts
for (const step of buildNewCustomerBookingJourney(page)) {
  await test.step(step.name, step.run);
}
```

## 4. Wait for the basket before asserting

Cart/basket mutations are async. Never assert a total straight after a click —
wait for the basket network response first. The base page wraps this:

```ts
async waitForBasketToUpdate() {
  return this.page.waitForResponse(
    async (resp) =>
      resp.url().includes('/v2/basket') &&
      (resp.request().method() === 'PATCH' || resp.request().method() === 'PUT'),
    { timeout: 10000 }
  );
}

async clickAddToBasket() {
  const addToBasketBtn = this.page.getByRole('button', { name: 'Add to basket' });
  await expect(addToBasketBtn).toBeEnabled({ timeout: 10000 });
  const waitForBasket = this.waitForBasketToUpdate();
  await addToBasketBtn.click();
  await waitForBasket;
}
```

In earlier, spec-local stages the same idea appears inline as
`page.waitForResponse('**/basket')` before the click's assertion. That inline
form is the Stage 4 anchor; the `waitForBasketToUpdate` method is its Stage 6
home.

## 5. Custom `test` fixture and clean state

Import `test` from the local `testConfig`, NOT from `@playwright/test`. It
extends the base with a `cleanContext` / `cleanPage` that start from empty
storage state and set auth + origin headers. Every describe clears state first.

```ts
import { clearBrowserState, test } from './testConfig';

test.describe('Accommodation Testing', () => {
  test.beforeEach(async ({ cleanContext }) => {
    await clearBrowserState(cleanContext);
  });
  // ...
});
```

`expect` still comes from `@playwright/test`.

## 6. Locators and selection

- Prefer role/label/testid: `getByRole('button', { name: 'Add to basket' })`,
  `getByTestId('basketCart-contents')`, `getByLabel('Increase ticket quantity')`.
- Combine testid with role for precision when a testid repeats:
  `page.getByTestId('calendar-day').and(page.getByRole('button', { name: '...' }))`.
- Accessibility-first assertions are idiomatic: `toHaveAccessibleName`,
  `aria-pressed`, `aria-disabled`, `toBeEnabled` / `not.toBeEnabled`.
- CSS/class locators exist in the base page for legacy DOM, but new spec-level
  code should reach for role/label/testid first.

## Stage-4 exemplar picker (quick guide)

- Add/remove-to-cart, quota/limit enforcement → `accommodation.spec.ts`
  (`MAX_ROOMS_PER_BOOKING` step) or a widget cart-total test.
- Tab/filter behaviour → `regression.spec.ts` `validateTabFilteringResults`.
- Full purchase / new-customer journey → `regression.spec.ts` +
  `newCustomerBookingJourney.ts`.
- Data-capture extras in basket → `regression.spec.ts` `[Legacy]` test +
  `assertDataCaptureInBasket`.
