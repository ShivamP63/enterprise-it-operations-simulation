[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$ApiBaseUrl = "https://postman-echo.com",

    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputDirectory = "./diagnostic-output",

    [Parameter(Mandatory = $false)]
    [ValidateRange(1, 120)]
    [int]$TimeoutSeconds = 20
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Add-CheckResult {
    param(
        [string]$Name,
        [bool]$Succeeded,
        [string]$Details,
        [long]$DurationMs = 0
    )

    [pscustomobject]@{
        Name       = $Name
        Succeeded  = $Succeeded
        Details    = $Details
        DurationMs = $DurationMs
        Timestamp  = (Get-Date).ToUniversalTime().ToString("o")
    }
}

try {
    $uri = [Uri]$ApiBaseUrl
    if ($uri.Scheme -notin @("http", "https")) {
        throw "ApiBaseUrl must use HTTP or HTTPS."
    }

    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
    $timestamp = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
    $results = [System.Collections.Generic.List[object]]::new()

    try {
        $dnsWatch = [System.Diagnostics.Stopwatch]::StartNew()
        $addresses = [System.Net.Dns]::GetHostAddresses($uri.DnsSafeHost)
        $dnsWatch.Stop()
        $results.Add((Add-CheckResult -Name "DNS resolution" -Succeeded $true -Details (($addresses.IPAddressToString) -join ", ") -DurationMs $dnsWatch.ElapsedMilliseconds))
    }
    catch {
        $results.Add((Add-CheckResult -Name "DNS resolution" -Succeeded $false -Details $_.Exception.Message))
    }

    $port = if ($uri.IsDefaultPort) { if ($uri.Scheme -eq "https") { 443 } else { 80 } } else { $uri.Port }
    try {
        $tcpWatch = [System.Diagnostics.Stopwatch]::StartNew()
        $tcpClient = [System.Net.Sockets.TcpClient]::new()
        $connectTask = $tcpClient.ConnectAsync($uri.DnsSafeHost, $port)
        if (-not $connectTask.Wait([TimeSpan]::FromSeconds($TimeoutSeconds))) {
            throw "TCP connection timed out after $TimeoutSeconds seconds."
        }
        $tcpWatch.Stop()
        $tcpClient.Dispose()
        $results.Add((Add-CheckResult -Name "TCP connectivity" -Succeeded $true -Details "$($uri.DnsSafeHost):$port reachable" -DurationMs $tcpWatch.ElapsedMilliseconds))
    }
    catch {
        $results.Add((Add-CheckResult -Name "TCP connectivity" -Succeeded $false -Details $_.Exception.Message))
    }

    try {
        $requestWatch = [System.Diagnostics.Stopwatch]::StartNew()
        $response = Invoke-WebRequest -Uri "$($uri.Scheme)://$($uri.Authority)/get?source=enterprise-support-simulation" -Method Get -TimeoutSec $TimeoutSeconds -UseBasicParsing
        $requestWatch.Stop()
        $results.Add((Add-CheckResult -Name "HTTP endpoint" -Succeeded ($response.StatusCode -eq 200) -Details "HTTP $($response.StatusCode)" -DurationMs $requestWatch.ElapsedMilliseconds))
    }
    catch {
        $status = if ($_.Exception.Response -and $_.Exception.Response.StatusCode) { [int]$_.Exception.Response.StatusCode } else { "Unavailable" }
        $results.Add((Add-CheckResult -Name "HTTP endpoint" -Succeeded $false -Details "Status: $status; $($_.Exception.Message)"))
    }

    $report = [pscustomobject]@{
        Incident       = "INC0010002"
        ApiBaseUrl     = $ApiBaseUrl
        ComputerName   = $env:COMPUTERNAME
        PowerShell     = $PSVersionTable.PSVersion.ToString()
        GeneratedAtUtc = (Get-Date).ToUniversalTime().ToString("o")
        Checks         = $results
        Note           = "No authentication token or secret is collected by this script."
    }

    $jsonPath = Join-Path $OutputDirectory "inventory-api-diagnostics-$timestamp.json"
    $textPath = Join-Path $OutputDirectory "inventory-api-diagnostics-$timestamp.txt"

    $report | ConvertTo-Json -Depth 6 | Set-Content -Path $jsonPath -Encoding UTF8
    $results | Format-Table -AutoSize | Out-String | Set-Content -Path $textPath -Encoding UTF8

    $results | Format-Table -AutoSize
    Write-Host "Diagnostic evidence written to:"
    Write-Host "  $jsonPath"
    Write-Host "  $textPath"

    if ($results.Where({ -not $_.Succeeded }).Count -gt 0) {
        exit 2
    }
}
catch {
    Write-Error "Diagnostics failed: $($_.Exception.Message)"
    exit 1
}
