# PowerShell API Diagnostics

`Invoke-InventoryApiDiagnostics.ps1` collects non-sensitive connectivity evidence for incident `INC0010002`.

## Checks performed

1. DNS resolution for the API hostname.
2. TCP connectivity to the resolved HTTP or HTTPS port.
3. HTTP GET request to a safe diagnostic endpoint.

## Usage

From the repository root:

```powershell
./powershell/Invoke-InventoryApiDiagnostics.ps1 `
  -ApiBaseUrl "https://postman-echo.com" `
  -OutputDirectory "./diagnostic-output" `
  -TimeoutSeconds 20
```

## Parameters

| Parameter | Default | Description |
|---|---|---|
| `ApiBaseUrl` | `https://postman-echo.com` | Base HTTP/HTTPS URL to test |
| `OutputDirectory` | `./diagnostic-output` | Destination for timestamped JSON and text reports |
| `TimeoutSeconds` | `20` | TCP and HTTP timeout from 1 to 120 seconds |

## Exit codes

| Code | Meaning |
|---:|---|
| 0 | All diagnostic checks passed |
| 1 | Script setup or execution failed |
| 2 | Script completed but one or more checks failed |

## Output and privacy

A sanitized sample report is committed under `powershell/diagnostic-output/`. New local output folders are ignored by Git through `.gitignore`. The script does not accept or collect authentication tokens, secrets, or passwords.
