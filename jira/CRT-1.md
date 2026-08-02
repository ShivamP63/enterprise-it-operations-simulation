# Jira Bug — CRT-1

## Summary

**HTTP 401 Unauthorized after Azure AD password reset**

## Classification

| Field | Value |
|---|---|
| Issue type | Bug |
| Priority | Medium |
| Labels | `authentication`, `http401` |
| Related incident | INC0010002 |
| Component | Authentication middleware |

## Problem statement

Users successfully complete identity-provider authentication after resetting their password, but subsequent requests to the Inventory Management API return HTTP 401 Unauthorized.

## Observed behaviour

- Sign-in succeeds.
- A new access token can be issued.
- The application API rejects authenticated requests.
- Multiple recently password-reset users are affected.
- Network connectivity and the public health endpoint remain healthy.

## Engineering hypothesis

Application nodes retain stale session/token-cache entries created before the password change. The middleware checks cached session metadata before validating the newly issued token and rejects the request.

## Acceptance criteria

- A password-reset user can obtain a fresh token and access the API.
- The affected API route returns HTTP 200 for a valid token.
- Invalid or expired tokens continue to return HTTP 401.
- Session invalidation is consistent across application nodes.
- Support documentation includes verification and escalation steps.

## Simulated resolution

Authentication middleware was updated to invalidate prior session state when credential-change metadata indicates that a token was issued after a password reset. Distributed cache entries were cleared, and regression tests covered valid, expired, and invalid-token paths.
