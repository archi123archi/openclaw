param(
  [string]$Bind = "loopback",
  [int]$Port = 18789,
  [switch]$NoRun
)

$ErrorActionPreference = "Stop"

function Assert-Command {
  param([string]$Name)
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "Required command not found: $Name"
  }
}

Assert-Command -Name "openclaw"

Write-Host "Switching OpenClaw to LOCAL mode..."
openclaw config set gateway.mode local
openclaw config set gateway.bind $Bind

Write-Host "Configured:"
Write-Host "  gateway.mode = local"
Write-Host "  gateway.bind = $Bind"

if ($NoRun) {
  Write-Host "NoRun flag set. Local mode configured, gateway not started."
  exit 0
}

Write-Host "Starting local gateway on ${Bind}:${Port} ..."
openclaw gateway run --bind $Bind --port $Port --force
