param(
  [string]$Url,

  [string]$Token = $env:OPENCLAW_REMOTE_TOKEN
)

$ErrorActionPreference = "Stop"

function Assert-Command {
  param([string]$Name)
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "Required command not found: $Name"
  }
}

Assert-Command -Name "openclaw"

if ([string]::IsNullOrWhiteSpace($Url)) {
  $Url = Read-Host "Gateway URL (example: wss://server.example.com:18789)"
}

if ([string]::IsNullOrWhiteSpace($Token)) {
  $Token = Read-Host "Gateway token"
}

if ([string]::IsNullOrWhiteSpace($Url)) {
  throw "Missing URL. Pass -Url '<wss://...>' or provide it when prompted."
}

if ([string]::IsNullOrWhiteSpace($Token)) {
  throw "Missing token. Pass -Token '<value>', set OPENCLAW_REMOTE_TOKEN, or provide it when prompted."
}

Write-Host "Switching OpenClaw to REMOTE mode..."
openclaw config set gateway.mode remote
openclaw config set gateway.remote.url $Url
openclaw config set gateway.remote.token $Token

Write-Host "Configured:"
Write-Host "  gateway.mode = remote"
Write-Host "  gateway.remote.url = $Url"
Write-Host "  gateway.remote.token = [set]"
