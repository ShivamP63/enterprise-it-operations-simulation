# Screenshot Evidence Index

The screenshots are ordered to tell the project story from incident intake through technical verification and the supporting ASP.NET Core API. They contain only demo-platform data and simulated support content.

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
| 11 | [`11-dotnet-api-run.png`](11-dotnet-api-run.png) | API execution | ASP.NET Core application starting successfully and listening on a localhost port. |
| 12 | [`12-dotnet-api-root-endpoint.png`](12-dotnet-api-root-endpoint.png) | Service verification | Root endpoint returning the API name and running status. |
| 13 | [`13-dotnet-api-health-endpoint.png`](13-dotnet-api-health-endpoint.png) | Health monitoring | Health endpoint returning a healthy state and UTC timestamp. |
| 14 | [`14-dotnet-api-incidents-endpoint.png`](14-dotnet-api-incidents-endpoint.png) | Incident retrieval | GET request returning the in-memory incident collection as JSON. |
| 15 | [`15-dotnet-api-swagger-ui.png`](15-dotnet-api-swagger-ui.png) | API documentation | Swagger/OpenAPI interface listing all available Minimal API routes. |
| 16 | [`16-dotnet-api-build-validation.png`](16-dotnet-api-build-validation.png) | Build validation | Successful `dotnet build` with zero warnings and zero errors. |
| 17 | [`17-dotnet-api-create-incident.png`](17-dotnet-api-create-incident.png) | Incident creation | Swagger POST request creating a new incident and returning HTTP 201. |
| 18 | [`18-dotnet-api-updated-incident-list.png`](18-dotnet-api-updated-incident-list.png) | State verification | Follow-up GET request showing the newly created incident in the collection. |

## Evidence mapping

| Operational or technical claim | Supporting evidence |
|---|---|
| Incident was recorded and triaged | 01–02 |
| Engineering escalation was created and tracked | 03–04 |
| Resolution guidance was documented | 05–06 |
| Healthy and failing API paths were reproduced | 07–08 |
| Recovery path was verified | 09 |
| Network and endpoint diagnostics were automated | 10 |
| ASP.NET Core API started and responded successfully | 11–14 |
| API routes were documented with Swagger/OpenAPI | 15 |
| C# project compiled successfully | 16 |
| POST and subsequent GET behavior were validated | 17–18 |
