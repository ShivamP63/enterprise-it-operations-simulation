# Root-Cause Analysis

## Problem

Validly authenticated users received HTTP 401 from the Inventory Management API immediately after resetting their passwords.

## Root cause

The simulated application maintained session metadata in a distributed cache. After a password reset, a fresh identity-provider token was issued, but the application retrieved stale pre-reset session state and rejected the request before completing normal token validation.

## Contributing factors

- Session invalidation was not triggered by credential-change metadata.
- Cache behaviour was not covered by the password-reset regression suite.
- Support monitoring grouped all HTTP 401 responses together and did not expose a safe failure-reason dimension.
- The original user-facing error did not include a correlation ID.

## Five whys

1. **Why did users receive HTTP 401?** The application rejected their authenticated requests.
2. **Why were apparently valid requests rejected?** The middleware used stale cached session metadata.
3. **Why was stale metadata present?** Password-reset events did not invalidate application sessions.
4. **Why was this not detected before release?** Integration tests validated ordinary login and token expiry but not login immediately after a password reset.
5. **Why did triage take longer than necessary?** Authentication telemetry lacked a safe, actionable failure-reason field and correlation identifier.

## Corrective actions

| Action | Type | Status |
|---|---|---|
| Invalidate prior sessions after credential changes | Preventive | Simulated complete |
| Add post-password-reset integration tests | Preventive | Simulated complete |
| Add correlation IDs to 401 responses | Detective | Planned |
| Track 401 reason-code metrics | Detective | Planned |
| Publish KB-001 and diagnostic runbook | Operational | Complete |

## Verification

The remediation is considered successful when a recently password-reset user receives HTTP 200 with a valid fresh token, invalid tokens still receive HTTP 401, and the behaviour remains consistent across application nodes.
