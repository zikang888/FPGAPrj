param(
    [ValidateSet('Prepare','OpenVivado','OpenSdk','BuildPl','BuildPs','ProgramRelease','PreflightRelease')]
    [string]$Action = 'Prepare'
)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$vivadoRoot = Join-Path $projectRoot 'build\vivado'
$sdkWorkspace = Join-Path $projectRoot 'build\sdk'
$logRoot = Join-Path $projectRoot 'build\logs'
$vivadoTool = 'D:\Vivado2018.3\Vivado\2018.3\bin\vivado.bat'
$xsctTool = 'D:\Vivado2018.3\SDK\2018.3\bin\xsct.bat'
$sdkTool = 'D:\Vivado2018.3\SDK\2018.3\bin\xsdk.bat'
$env:PROCESSOR_ARCHITECTURE = 'AMD64'
New-Item -ItemType Directory -Path $logRoot -Force | Out-Null
Set-Location -LiteralPath $projectRoot

function Invoke-CheckedTool($tool, $toolArgs, $marker, $logName) {
    if (!(Test-Path -LiteralPath $tool)) { throw "Tool not found: $tool" }
    $logFile = Join-Path $logRoot $logName
    & $tool @toolArgs 2>&1 | Tee-Object -FilePath $logFile | Tee-Object -Variable toolOutput
    if ($LASTEXITCODE -ne 0 -or ($toolOutput -join "`n") -notmatch [regex]::Escape($marker)) {
        throw "Required marker '$marker' missing or tool failed. See $logFile"
    }
}

function Build-PsWorkspace {
    $builtPlatform = Join-Path $vivadoRoot 'Multi_protocol.sdk\platform_hw'
    $releasePlatform = Join-Path $projectRoot 'Multi_protocol.sdk\platform_hw'
    $platform = $releasePlatform
    if ((Test-Path -LiteralPath "$builtPlatform\system.hdf") -and
        (Test-Path -LiteralPath "$builtPlatform\multi_protocol_bd_wrapper.bit")) {
        $platform = $builtPlatform
    }
    # Preserve SDK-generated application files before the existing builder
    # recreates its three projects. Business sources remain in software/src.
    $generatedSrc = Join-Path $sdkWorkspace 'platform_app\src'
    if (Test-Path -LiteralPath $generatedSrc) {
        $backup = Join-Path $projectRoot ("build\backups\sdk-src-" + (Get-Date -Format 'yyyyMMdd-HHmmss-fff'))
        New-Item -ItemType Directory -Path $backup -Force | Out-Null
        Copy-Item -LiteralPath $generatedSrc -Destination $backup -Recurse
    }
    $env:MULTI_PROTOCOL_HDF = Join-Path $platform 'system.hdf'
    $env:MULTI_PROTOCOL_BIT = Join-Path $platform 'multi_protocol_bd_wrapper.bit'
    $env:MULTI_PROTOCOL_SDK_WS = $sdkWorkspace
    Remove-Item Env:MULTI_PROTOCOL_PREFLIGHT_ONLY -ErrorAction SilentlyContinue
    Invoke-CheckedTool $xsctTool @('software/build_ps_app.tcl') 'PS_BUILD_DONE' 'build-ps.log'
}

function Prepare-Workspace {
    $wrapper = Join-Path $vivadoRoot 'Multi_protocol.srcs\sources_1\bd\multi_protocol_bd\hdl\multi_protocol_bd_wrapper.v'
    $project = Join-Path $vivadoRoot 'Multi_protocol.xpr'
    if (!(Test-Path -LiteralPath $project) -and !(Test-Path -LiteralPath $wrapper)) {
        $env:MULTI_PROTOCOL_BUILD_DIR = $vivadoRoot
        Invoke-CheckedTool $vivadoTool @('-mode','batch','-source','fpga/build/prepare_workspace.tcl') 'GUI_WORKSPACE_READY' 'prepare-vivado.log'
    } elseif (!(Test-Path -LiteralPath $project) -or !(Test-Path -LiteralPath $wrapper)) {
        throw "Incomplete workspace at $vivadoRoot. Inspect it before rebuilding; existing files were preserved."
    }
    if (!(Test-Path -LiteralPath (Join-Path $sdkWorkspace 'platform_app\.project'))) {
        Build-PsWorkspace
    }
    Write-Output "VIVADO_PROJECT $project"
    Write-Output "SDK_WORKSPACE $sdkWorkspace"
    Write-Output 'PROJECT_WORKSPACE_READY'
}

switch ($Action) {
    'Prepare' { Prepare-Workspace }
    'OpenVivado' {
        Prepare-Workspace
        & $vivadoTool (Join-Path $vivadoRoot 'Multi_protocol.xpr')
    }
    'OpenSdk' {
        Prepare-Workspace
        & $sdkTool -workspace $sdkWorkspace
    }
    'BuildPl' {
        Prepare-Workspace
        $env:MULTI_PROTOCOL_BUILD_DIR = $vivadoRoot
        Invoke-CheckedTool $vivadoTool @('-mode','batch','-source','fpga/build/build_bitstream.tcl') 'BUILD_DONE' 'build-pl.log'
        Write-Output 'PL rebuilt. Run BuildPs before using this hardware with a new application.'
    }
    'BuildPs' { Build-PsWorkspace }
    { $_ -in 'ProgramRelease','PreflightRelease' } {
        $release = Join-Path $projectRoot 'releases\uart-20261018'
        $platform = Join-Path $projectRoot 'Multi_protocol.sdk\platform_hw'
        $expected = @{
            (Join-Path $platform 'multi_protocol_bd_wrapper.bit') = '3F23632A40125750DC0D08CEB6165646BCE12B6DCDA5DEBE8219C317ACBF3066'
            (Join-Path $platform 'system.hdf') = '2871B20CA74E55A97B05189EFE9F503795ABEABFC552648544DE47C2AE55235F'
            (Join-Path $platform 'ps7_init.tcl') = '47D35117FE590757D5F887986AE68B1E64F5CDCFC7EEB480825AF9543BF91399'
            (Join-Path $release 'platform_app.elf') = 'C67FDC4F30716E4F69ADD31DCFDA1C787E5DC56DECC1464F0392FD6ED5EC010E'
        }
        foreach ($path in $expected.Keys) {
            if ((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -ne $expected[$path]) {
                throw "Release hash mismatch: $path. No download performed."
            }
        }
        $env:ZYNQ_TEST_BIT = Join-Path $platform 'multi_protocol_bd_wrapper.bit'
        $env:ZYNQ_TEST_INIT = Join-Path $platform 'ps7_init.tcl'
        $env:ZYNQ_TEST_ELF = Join-Path $release 'platform_app.elf'
        $env:ZYNQ_PREFLIGHT_ONLY = '1'
        Invoke-CheckedTool $xsctTool @('fpga/build/zynq_jtag_board_test.tcl') 'ZYNQ_JTAG_PREFLIGHT_DONE' 'release-preflight.log'
        if ($Action -eq 'ProgramRelease') {
            Remove-Item Env:ZYNQ_PREFLIGHT_ONLY
            Invoke-CheckedTool $xsctTool @('fpga/build/zynq_jtag_board_test.tcl') 'ZYNQ_JTAG_BOARD_TEST_DONE' 'release-download.log'
        }
    }
}
