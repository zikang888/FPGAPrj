param(
    [switch]$PreflightOnly,
    [string]$Bundle = '',
    [string]$ToolRoot = 'E:\AMDDesignTools\2026.1'
)
$ErrorActionPreference = 'Stop'
if ($Bundle) {
    $taskBundle = [IO.Path]::GetFullPath($Bundle)
} elseif (Test-Path -LiteralPath (Join-Path $PSScriptRoot 'manifest.json')) {
    $taskBundle = $PSScriptRoot
} else {
    $taskRepo = Split-Path -Parent $PSScriptRoot
    $taskRoot = Split-Path -Parent (Split-Path -Parent $taskRepo)
    $taskBundle = Join-Path $taskRoot 'migration_build\2026.1\candidate'
}
$taskManifest = Get-Content -Raw -LiteralPath (Join-Path $taskBundle 'manifest.json') | ConvertFrom-Json
foreach ($taskFile in $taskManifest.files) {
    $taskPath = Join-Path $taskBundle $taskFile.path
    $taskHash = (Get-FileHash -LiteralPath $taskPath -Algorithm SHA256).Hash
    if ($taskHash -ne $taskFile.sha256) { throw "Candidate hash mismatch: $($taskFile.path)" }
}
$taskArgs = @((Join-Path $PSScriptRoot 'program_2026_1.tcl'), $taskBundle)
if ($PreflightOnly) { $taskArgs += '--preflight' }
& (Join-Path $ToolRoot 'Vitis\bin\xsdb.bat') @taskArgs
if ($LASTEXITCODE -ne 0) { throw 'JTAG loader failed.' }
