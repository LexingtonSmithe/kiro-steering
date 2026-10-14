Aymeric Obled  [11:08 AM]
Hey @dev-team-payxops (especially those working on Android) :wave:
Friendly reminder: all new Blenny V2 work needs tests ! They aren’t set as mandatory so we don’t block Blenny V1 fixes, but let’s do our future selves a favor :slightly_smiling_face:
Here’s Jacek’s guide on the setup: https://github.com/Weezevent/blenny/blob/develop/docs/testing-setup.md
Thanks ! :pray:
testing-setup.mdBlenny - Unit Testing Setup

A short guide to how unit testing works in the Blenny (WeezPay) Android app: the stack, how it's wired,  
how to run tests, and how to write one. Aimed at Android developers joining the codebase.

 Important assumption. The current test suite is written on the assumption that the current 
 behaviour of the code is the correct way the product is supposed to work. Tests capture and lock in  
 Weezevent/blenny | Added by GitHub2 repliesPavel Ratushny  [11:11 AM]
I actually doing it for most of the tasks atm, but we still need to understand what we need to test. Sometimes tests are useless for UI tasks like “If I click this button -> this happens” :melting_face:

For V2 we are not doing a lot of “under-the-hood” stuff to test, most of the logic we are getting from V1
Aymeric Obled  [11:13 AM]
Yep for now it was more to think about it in the table management dev where Jacek already added a comment regarding it, for now we decided to not test the UI so if your PR is only about UI changes, no need to test it :slightly_smiling_face: