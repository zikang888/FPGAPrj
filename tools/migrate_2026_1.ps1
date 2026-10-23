param(
    [ValidateSet('all','sim','pl','ps','host','open')][string]$Step = 'all',
    [string]$ToolRoot = 'E:\AMDDesignTools\2026.1',
    [string]$HostCompiler = 'D:\MinGW\MinGW\bin\gcc.exe'
)
$ErrorActionPreference = 'Stop'
$taskRepo = Split-Path -Parent $PSScriptRoot
$taskRoot = Split-Path -Parent (Split-Path -Parent $taskRepo)
$taskBuild = Join-Path $taskRoot 'migration_build\2026.1'
$taskVivado = Join-Path $ToolRoot 'Vivado\bin\vivado.bat'
$taskVitis = Join-Path $ToolRoot 'Vitis\bin\vitis.bat'
New-Item -ItemType Directory -Force (Join-Path $taskBuild 'logs') | Out-Null
function Invoke-MigrationVivado([string]$Script,[string]$LogName) {
    & $taskVivado -mode batch -notrace -source (Join-Path $taskRepo "fpga\build\$Script") -log "logs\$LogName.log" -journal "logs\$LogName.jou"
    if ($LASTEXITCODE -ne 0) { throw "Vivado failed; see logs\$LogName.log" }
}
Push-Location -LiteralPath $taskBuild
$taskOldBuild = $env:MULTI_PROTOCOL_BUILD_DIR
try {
    if ($Step -eq 'open') {
        $taskXpr = Join-Path $taskBuild 'pl\Multi_protocol.xpr'
        if (!(Test-Path -LiteralPath $taskXpr)) { throw 'Build the 2026.1 project first.' }
        & $taskVivado $taskXpr
        exit $LASTEXITCODE
    }
    if ($Step -in @('all','sim')) {
        $env:MULTI_PROTOCOL_BUILD_DIR = Join-Path $taskBuild 'sim'
        Invoke-MigrationVivado 'sim_2026_1.tcl' 'simulation'
    }
    if ($Step -in @('all','pl')) {
        $env:MULTI_PROTOCOL_BUILD_DIR = Join-Path $taskBuild 'pl'
        Invoke-MigrationVivado 'build_2026_1.tcl' 'build'
    }
    if ($Step -in @('all','ps')) {
        & $taskVitis -s (Join-Path $taskRepo 'software\build_vitis_2026_1.py') 2>&1 | Tee-Object -FilePath 'logs\vitis_app.log'
        if ($LASTEXITCODE -ne 0) { throw 'Vitis failed.' }
        if (!(Select-String -Quiet -Path 'logs\vitis_app.log' -Pattern 'MIGRATION_VITIS_APP_DONE:')) { throw 'Vitis did not complete.' }
    }
    if ($Step -in @('all','host')) {
        Push-Location -LiteralPath $taskRepo
        try {
            & (Join-Path $taskRepo 'software\tests\run_session_checks.ps1') -Compiler $HostCompiler 2>&1 | Tee-Object -FilePath (Join-Path $taskBuild 'logs\host_checks.log')
            if ($LASTEXITCODE -ne 0) { throw 'Host checks failed.' }
        } finally { Pop-Location }
    }
    Write-Output "MIGRATION_STEP_DONE: $Step"
} finally {
    $env:MULTI_PROTOCOL_BUILD_DIR = $taskOldBuild
    Pop-Location
}
