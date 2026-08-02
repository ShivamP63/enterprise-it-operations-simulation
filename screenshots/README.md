# Screenshot Evidence Index

The screenshots are ordered to tell the incident story from intake through technical verification. They contain only demo-platform data and simulated support content.

| # | File | Workflow stage | Evidence shown |
|---:|---|---|---|
| 01 | [`01-servicenow-incident-details.png`](01-servicenow-incident-details.png) | Incident intake | Saved ServiceNow record with incident number, priority, short description, comments, and activity notes. |
| 02 | [`02-servicenow-incident-list.png`](02-servicenow-incident-list.png) | Queue visibility | Incident list showing `INC0010002` in the ServiceNow support queue. |
| 03 | [`03-jira-bug-details.png`](03-jira-bug-details.png) | Engineering escalation | Jira bug `CRT-1` with linked incident, problem summary, observed behaviour, labels, and priority. |
| 04 | [`04-jira-kanban-board.png`](04-jira-kanban-board.png) | Work tracking | Jira board showing the escalated authentication defect in the team workflow. |
| 05 | [`05-confluence-kb-summary.png`](05-confluence-kb-summary.png) | Knowledge capture | Published Confluence article title and summary in the project knowledge space. |
| 06 | [`06-confluence-kb-full-page.png`](06-confluence-kb-full-page.png) | Reusable guidance | Full article covering symptoms, likely causes, resolution steps, and post-remediation verification. |
| 07 | [`07-postman-health-check.png`](07-postman-health-check.png) | Connectivity validation | Postman health-check request returning HTTP 200 with passing tests. |
| 08 | [`08-postman-401.png`](08-postman-401.png) | Symptom reproduction | Controlled Postman request returning HTTP 401 with the expected assertion passing. |
| 09 | [`09-postman-remediation.png`](09-postman-remediation.png) | Remediation verification | Controlled post-remediation request returning HTTP 200 with passing assertions. |
| 10 | [`10-powershell-diagnostics.png`](10-powershell-diagnostics.png) | Automated diagnostics | PowerShell execution showing successful DNS, TCP 443, and HTTP endpoint checks plus evidence-file generation. |

## Evidence mapping

| Operational claim | Supporting evidence |
|---|---|
| Incident was recorded and triaged | 01–02 |
| Engineering escalation was created and tracked | 03–04 |
| Resolution guidance was documented | 05–06 |
| Healthy and failing API paths were reproduced | 07–08 |
| Recovery path was verified | 09 |
| Network and endpoint diagnostics were automated | 10 |
