# ASP.NET Core Incident API

This component is a lightweight C# ASP.NET Core Minimal API used to demonstrate foundational backend and REST API development within the enterprise support simulation.

## Features

- In-memory incident collection
- JSON request and response bodies
- Health-check endpoint
- Incident list and lookup endpoints
- Incident creation with HTTP 201 response
- HTTP 404 handling for unknown incident IDs
- Swagger/OpenAPI documentation

## Run the API

```powershell
cd api/IT.Operations.Api
dotnet restore
dotnet run
```

Use the local URL printed by `dotnet run`. Swagger is available at:

```text
/swagger
```

## Endpoints

| Method | Route | Result |
|---|---|---|
| `GET` | `/` | Service name and running status |
| `GET` | `/health` | Health state and UTC timestamp |
| `GET` | `/incidents` | All sample incidents |
| `GET` | `/incidents/{id}` | Matching incident or HTTP 404 |
| `POST` | `/incidents` | Newly created incident and HTTP 201 |

## Example POST body

```json
{
  "title": "Database backup failed",
  "priority": "High",
  "source": "ServiceNow"
}
```

## Design scope

The API intentionally avoids external infrastructure so it can be run and reviewed quickly. Records are stored only in memory and reset whenever the application restarts. A production implementation would add request validation, persistent storage, authentication, centralized logging, automated tests, and environment-specific security controls.
