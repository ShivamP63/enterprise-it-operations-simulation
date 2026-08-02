# KB-001 — HTTP 401 Unauthorized after Password Reset

## Purpose

Use this article when a user can complete Microsoft Entra ID sign-in but receives HTTP 401 from the Inventory Management application after changing or resetting a password.

## Symptoms

- Identity-provider login succeeds.
- The application dashboard does not load.
- API requests return HTTP 401 Unauthorized.
- The issue begins immediately after a password change.
- Other public application endpoints may remain reachable.

## First-line resolution

1. Confirm the user can sign in to the identity provider.
2. Ask the user to sign out of all application sessions.
3. Close all browser windows associated with the application.
4. Clear site data for the application domain or use a private window.
5. Sign in again to force issuance of a fresh token.
6. Retest the dashboard and one inventory update.

## Technical verification

- Resolve the application hostname.
- Confirm TCP 443 connectivity.
- Confirm the health endpoint responds.
- Reproduce the affected request in Postman without exposing the token.
- Record the HTTP status, correlation ID, UTC timestamp, and response time.
- Confirm token issuer, audience, and expiry without recording the full token.

## Escalation criteria

Escalate to Application Support when:

- multiple users are affected;
- a fresh login still returns HTTP 401;
- token claims appear valid;
- health checks pass but authenticated routes fail; or
- the issue recurs after local session data is cleared.

Attach the output from `Invoke-InventoryApiDiagnostics.ps1` and reference the ServiceNow incident.

## Verification after remediation

- The user signs in successfully.
- The dashboard loads.
- The authenticated API request returns HTTP 200.
- The user can read and update inventory.
- No new 401 errors appear for the tested user during the observation period.

## Related records

- ServiceNow: `INC0010002`
- Jira: `CRT-1`
