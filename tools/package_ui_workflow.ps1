$ErrorActionPreference='Stop'
$projectRoot=Split-Path -Parent $PSScriptRoot
$releaseRoot=Join-Path $projectRoot 'releases\ui-workflow-20261024'
$elf=Join-Path $projectRoot 'build\ui-workflow-20261023\sdk\platform_app\Debug\platform_app.elf'
$platform=Join-Path $projectRoot 'Multi_protocol.sdk\platform_hw'
if(Test-Path -LiteralPath $releaseRoot){throw "Release already exists; inspect it before replacing: $releaseRoot"}
$inputs=@(
    $elf,
    (Join-Path $platform 'multi_protocol_bd_wrapper.bit'),
    (Join-Path $platform 'system.hdf'),
    (Join-Path $platform 'ps7_init.tcl')
)
foreach($file in $inputs){if(!(Test-Path -LiteralPath $file)){throw "Missing $file"}}
$elfTime=(Get-Item -LiteralPath $elf).LastWriteTimeUtc
$sources=Get-ChildItem -LiteralPath (Join-Path $projectRoot 'software\src') -File |
    Where-Object {$_.Extension -in '.c','.h'}
foreach($source in $sources){if($source.LastWriteTimeUtc -gt $elfTime){throw "ELF predates source: $($source.Name)"}}
New-Item -ItemType Directory -Path $releaseRoot | Out-Null
foreach($file in $inputs){Copy-Item -LiteralPath $file -Destination $releaseRoot}
$preview=Join-Path $releaseRoot 'preview'
New-Item -ItemType Directory -Path $preview | Out-Null
foreach($name in @('spi_data','uart_frames','i2c_data','can_data','recording',
                   'i2c_not_tested','i2c_busy_info','can_errors','history_can_errors','history_i2c_info')){
    $png=Join-Path $projectRoot "build\session20261020\preview\$name.png"
    if(!(Test-Path -LiteralPath $png)){throw "Missing preview: $png"}
    Copy-Item -LiteralPath $png -Destination $preview
}
$files=@(Get-ChildItem -LiteralPath $releaseRoot -File | ForEach-Object {
    @{name=$_.Name;bytes=$_.Length;sha256=(Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash}
})
$sourceHashes=@($sources | ForEach-Object {
    @{name=('software/src/'+$_.Name);sha256=(Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash}
})
$manifest=@{
    validation='OFFLINE_ONLY_NOT_BOARD_TESTED'
    branch='codex/ui-four-protocol-20261023'
    fpga_baseline='0d9fde5'
    stm32_reference='d17568e (read only; not imported)'
    created=(Get-Date -Format 'yyyy-MM-ddTHH:mm:sszzz')
    files=$files
    source_files=$sourceHashes
    checks='12 host tests + production renderer/touch tests; repeated regression passed'
}
$manifest | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $releaseRoot 'manifest.json') -Encoding UTF8
Write-Output 'UI_WORKFLOW_PACKAGE_DONE'
Write-Output $releaseRoot
