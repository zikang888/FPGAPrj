param([switch]$PreflightOnly)
$ErrorActionPreference='Stop'
$projectRoot=Split-Path -Parent $PSScriptRoot
$releaseRoot=Join-Path $projectRoot 'releases\session-candidate-20261020'
$manifest=Get-Content -LiteralPath (Join-Path $releaseRoot 'manifest.json') -Raw | ConvertFrom-Json
foreach($entry in $manifest.files) {
    $path=Join-Path $releaseRoot $entry.name
    if((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -ne $entry.sha256) {
        throw "Candidate file hash mismatch: $path"
    }
}
Write-Output "CANDIDATE_STATUS $($manifest.validation)"
$env:PROCESSOR_ARCHITECTURE='AMD64'
$env:ZYNQ_TEST_BIT=Join-Path $releaseRoot 'multi_protocol_bd_wrapper.bit'
$env:ZYNQ_TEST_INIT=Join-Path $releaseRoot 'ps7_init.tcl'
$env:ZYNQ_TEST_ELF=Join-Path $releaseRoot 'platform_app.elf'
$env:ZYNQ_PREFLIGHT_ONLY='1'
if(!$PreflightOnly) { Remove-Item Env:ZYNQ_PREFLIGHT_ONLY }
$logRoot=Join-Path $projectRoot 'build\logs'
New-Item -ItemType Directory -Path $logRoot -Force | Out-Null
$log=Join-Path $logRoot 'session-candidate-download.log'
Set-Location -LiteralPath $projectRoot
& 'D:\Vivado2018.3\SDK\2018.3\bin\xsct.bat' 'fpga/build/zynq_jtag_board_test.tcl' 2>&1 |
    Tee-Object -FilePath $log | Tee-Object -Variable result
$marker=if($PreflightOnly){'ZYNQ_JTAG_PREFLIGHT_DONE'}else{'ZYNQ_JTAG_BOARD_TEST_DONE'}
if($LASTEXITCODE -ne 0 -or ($result -join "`n") -notmatch [regex]::Escape($marker)) {
    throw "Required marker $marker missing; see $log"
}
