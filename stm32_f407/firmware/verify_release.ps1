param([Parameter(Mandatory=$true)][string]$Directory)
$ErrorActionPreference = 'Stop'
$taskDirectory = (Resolve-Path -LiteralPath $Directory).Path
$taskManifest = Get-Content -LiteralPath (Join-Path $taskDirectory 'manifest.json') -Raw | ConvertFrom-Json
if ($taskManifest.schema_version -ne 2 -or $taskManifest.target -ne 'STM32F407VGT6') {
    throw 'Expected schema v2 STM32F407VGT6 manifest'
}
foreach ($taskProfile in $taskManifest.profiles) {
    if ([IO.Path]::GetFileName($taskProfile.hex) -ne $taskProfile.hex) { throw 'Expected leaf HEX filename' }
    $taskHex = Join-Path $taskDirectory $taskProfile.hex
    if ((Get-Item -LiteralPath $taskHex).Length -ne $taskProfile.file_size_bytes -or
        (Get-FileHash -LiteralPath $taskHex -Algorithm SHA256).Hash -ne $taskProfile.sha256) { throw 'HEX hash/size mismatch' }
    $taskMemory = [System.Collections.Generic.Dictionary[uint32,byte]]::new()
    $taskBase = [uint32]0; $taskEof = $false; $taskRecords = 0
    foreach ($taskLine in (Get-Content -LiteralPath $taskHex)) {
        if ($taskEof) { throw 'Record after EOF' }
        if ($taskLine -notmatch '^:([0-9A-Fa-f]{2})+$') { throw 'Invalid HEX syntax' }
        $taskBytes = @()
        for ($taskI=1; $taskI -lt $taskLine.Length; $taskI+=2) { $taskBytes += [Convert]::ToInt32($taskLine.Substring($taskI,2),16) }
        $taskLength = $taskBytes[0]
        if ($taskBytes.Count -ne $taskLength+5 -or (($taskBytes | Measure-Object -Sum).Sum % 256) -ne 0) { throw 'HEX record length/checksum' }
        $taskAddress = $taskBytes[1]*256+$taskBytes[2]
        switch ($taskBytes[3]) {
            0 {
                for ($taskI=0; $taskI -lt $taskLength; $taskI++) {
                    $taskAbsolute = [uint32]($taskBase+$taskAddress+$taskI)
                    if ($taskAbsolute -lt 0x08000000 -or $taskAbsolute -ge 0x08100000 -or $taskMemory.ContainsKey($taskAbsolute)) { throw 'HEX address range/overlap' }
                    $taskMemory.Add($taskAbsolute,[byte]$taskBytes[4+$taskI])
                }
            }
            1 { if ($taskLength -ne 0 -or $taskAddress -ne 0) { throw 'Invalid EOF' }; $taskEof = $true }
            4 {
                if ($taskLength -ne 2 -or $taskAddress -ne 0) { throw 'Invalid extended address' }
                $taskBase = [uint32](($taskBytes[4]*256+$taskBytes[5])*65536)
            }
            5 { if ($taskLength -ne 4 -or $taskAddress -ne 0) { throw 'Invalid entry record' } }
            default { throw 'Unexpected HEX record type' }
        }
        $taskRecords++
    }
    if (-not $taskEof) { throw 'Missing EOF' }
    $taskVector = [byte[]](0..7 | ForEach-Object { $taskMemory[[uint32](0x08000000+$_)] })
    $taskSp = [BitConverter]::ToUInt32($taskVector,0)
    $taskReset = [BitConverter]::ToUInt32($taskVector,4)
    if ($taskSp -lt 0x20000000 -or $taskSp -gt 0x20020000 -or ($taskReset -band 1) -ne 1 -or
        -not $taskMemory.ContainsKey([uint32]($taskReset -band 0xfffffffe))) { throw 'Invalid vector table' }
    Write-Output "$($taskProfile.name) PASS: records=$taskRecords FlashBytes=$($taskMemory.Count) SP=$('{0:X8}' -f $taskSp) RESET=$('{0:X8}' -f $taskReset) SHA256=$($taskProfile.sha256)"
}
