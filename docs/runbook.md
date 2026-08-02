# Runbook — Investigate HTTP 401 After Password Reset

## Trigger

Use this runbook when identity-provider authentication succeeds but the Inventory Management application or API returns HTTP 401 following a password change.

## Required access

- ServiceNow incident record
- Jira access for escalation
- Postman or equivalent REST client
- PowerShell 5.1+ or PowerShell 7+
- Read-only access to relevant application logs when available

## Safety rules

- Never paste complete access tokens into tickets, chat, screenshots, or Git.
- Record only non-sensitive claims such as issuer, audience, and expiry.
- Use UTC timestamps and correlation IDs when sharing evidence.
- Do not disable authentication or bypass authorization to test a fix.

## Procedure

### 1. Confirm scope

- Identify the first observed time and number of affected users.
- Confirm whether all affected users recently changed passwords.
- Record business impact and any workaround.

### 2. Separate identity from application failure

- Confirm identity-provider sign-in succeeds.
- Confirm the application hostname resolves.
- Confirm TCP 443 and TLS negotiation succeed.
- Check the public health endpoint.

### 3. Reproduce safely

- Run the Postman collection.
- Record status code, response time, UTC timestamp, and correlation ID.
- Confirm the unauthorized path returns 401 and the remediated path returns 200.

### 4. Collect diagnostics

```powershell
./powershell/Invoke-InventoryApiDiagnostics.ps1 \
  -ApiBaseUrl "https://postman-echo.com" \
  -OutputDirectory "./diagnostic-output"
```

Attach the generated report to the incident after reviewing it for sensitive information.

### 5. Attempt first-line remediation

- Sign the user out of all application sessions.
- Clear application site data or use a private browser session.
- Obtain a fresh token through normal sign-in.
- Retest the affected workflow.

### 6. Escalate

Open or update a Jira bug when a fresh session still fails, multiple users are affected, or token metadata appears valid. Include:

- ServiceNow incident number;
- sanitized request and response metadata;
- correlation ID and UTC timestamp;
- diagnostic report;
- expected versus actual behaviour.

### 7. Validate and close

- Confirm the API returns HTTP 200 for a valid fresh token.
- Confirm invalid tokens still receive HTTP 401.
- Complete one representative inventory update.
- Monitor for recurrence during the agreed observation period.
- Add resolution notes, link the Jira issue and KB article, then resolve the incident.
