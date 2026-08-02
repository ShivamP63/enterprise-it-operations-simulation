# Incident Report

## Executive summary

A simulated group of employees received HTTP 401 responses from the Inventory Management application after resetting their corporate passwords. Identity-provider sign-in remained available, and infrastructure connectivity tests passed. Investigation isolated the failure to application-side authentication/session handling. The stale session state was invalidated, users obtained fresh tokens, and normal access was restored.

## Impact

- **Severity:** Medium
- **Users:** Multiple employees who recently reset passwords
- **Business process:** Inventory updates and order-processing support
- **Data loss:** None observed
- **Security impact:** None observed; invalid requests remained denied

## Detection

The incident was user-reported through ServiceNow rather than detected by monitoring. This exposed an observability gap: authentication failures should be tracked by route, client, and reason code without logging sensitive tokens.

## Timeline

| Relative time | Event |
|---|---|
| T+00 | Incident INC0010002 created. |
| T+10 | Support confirmed successful identity-provider authentication. |
| T+20 | DNS, TLS, and health endpoint checks passed. |
| T+30 | HTTP 401 reproduced on the application API. |
| T+40 | Jira bug CRT-1 opened and evidence attached. |
| T+70 | Stale session/token-cache behaviour identified. |
| T+90 | Cache invalidated and fresh-token access verified. |
| T+105 | User workflow validated and KB-001 published. |

## Resolution

Application session state associated with credentials issued before the password reset was invalidated. A new session was established using a freshly issued token. The authenticated API route returned HTTP 200 and the user completed an inventory update.

## Follow-up actions

- Add a metric for authentication failures by failure reason.
- Include a correlation ID in all authentication error responses.
- Add automated regression tests for post-password-reset access.
- Review distributed-cache invalidation across all application nodes.
- Link KB-001 from the service desk workflow.
