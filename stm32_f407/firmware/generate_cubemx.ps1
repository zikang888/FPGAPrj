param(
    [string]$CubeMxRoot = 'D:\STM32CubeMX',
    [string]$FirmwarePackage = ''
)

$ErrorActionPreference = 'Stop'
$firmwareRoot = [IO.Path]::GetFullPath($PSScriptRoot)
$iocPath = Join-Path $firmwareRoot 'sky_star_protocol_node.ioc'
$javaPath = Join-Path $CubeMxRoot 'jre\bin\java.exe'
$cubeMxJar = Join-Path $CubeMxRoot 'STM32CubeMX.exe'
$commandFile = Join-Path $env:TEMP 'sky_star_protocol_node_cubemx.txt'

if (!(Test-Path -LiteralPath $iocPath)) {
    throw "IOC not found: $iocPath"
}
if (!(Test-Path -LiteralPath $javaPath) -or !(Test-Path -LiteralPath $cubeMxJar)) {
    throw "STM32CubeMX not found under: $CubeMxRoot"
}

$iocForMx = $iocPath.Replace('\', '/')
$commands = @("config load `"$iocForMx`"")
if ($FirmwarePackage) {
    $packagePath = [IO.Path]::GetFullPath($FirmwarePackage).Replace('\', '/')
    $commands += "project setCustomFWPath `"$packagePath`""
}
$commands += 'project toolchain MDK-ARM'
$commands += 'project generate'
$commands += 'exit'

[IO.File]::WriteAllLines($commandFile, $commands, [Text.UTF8Encoding]::new($false))
try {
    & $javaPath -jar $cubeMxJar -q $commandFile
    if ($LASTEXITCODE -ne 0) {
        throw "STM32CubeMX failed with exit code $LASTEXITCODE"
    }
} finally {
    Remove-Item -LiteralPath $commandFile -Force -ErrorAction SilentlyContinue
}

