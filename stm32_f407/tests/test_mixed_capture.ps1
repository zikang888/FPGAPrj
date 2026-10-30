param([Parameter(Mandatory=$true)][string]$Tool)
$ErrorActionPreference = 'Stop'
$taskTemp = Join-Path ([IO.Path]::GetTempPath()) ('mc-mixed-test-' + [guid]::NewGuid().ToString('N'))
[void](New-Item -ItemType Directory -Path $taskTemp)
try {
    $taskMcu = Join-Path $taskTemp 'mcu.jsonl'
    $taskFpga = Join-Path $taskTemp 'fpga.jsonl'
    $taskPhysical = Join-Path $taskTemp 'confirmed.jsonl'
    $taskLines = @('{"kind":"mixed","phase":"begin","run":1,"total":3,"mode":1,"value":2,"seed":1,"planned":1,"fault_index":0}')
    for ($taskI=1; $taskI -le 3; $taskI++) {
        $taskSlot = if ($taskI -eq 2) { 1 } else { 0 }
        $taskLines += '{"kind":"mixed","phase":"slot_begin","run":1,"index":'+$taskI+',"fault_slot":'+$taskSlot+'}'
        $taskLines += '{"kind":"mixed","phase":"slot_end","run":1,"index":'+$taskI+',"fault_slot":'+$taskSlot+',"fault_index":0,"result":0}'
    }
    $taskLines += '{"kind":"mixed","phase":"end","run":1,"state":2,"held":0,"completed":3,"failed":0,"result":0}'
    [IO.File]::WriteAllLines($taskMcu, $taskLines)
    [IO.File]::WriteAllLines($taskFpga, @('{"run":1,"index":2,"fault_index":0}','{"run":1,"index":2,"fault_index":0}','{"run":1,"index":3,"fault_index":0}'))
    [IO.File]::WriteAllText($taskPhysical, '{"run":1,"index":2,"fault_index":0}')
    $taskReport = (& $Tool -McuLog $taskMcu -RunId 1 -FpgaErrors $taskFpga | ConvertFrom-Json)
    if (-not $taskReport.local_run_complete -or $taskReport.comparison -ne 'intent_only_NOT_detection_accuracy' -or
        $taskReport.matched.Count -ne 1 -or $taskReport.unexpected.Count -ne 1 -or $taskReport.duplicate_reports -ne 1) { throw 'Intent comparison failed' }
    $taskReport = (& $Tool -McuLog $taskMcu -RunId 1 -FpgaErrors $taskFpga -ConfirmedErrors $taskPhysical | ConvertFrom-Json)
    if ($taskReport.comparison -ne 'against_user_supplied_physical_confirmations' -or $taskReport.physical_verified_by_this_tool) { throw 'Evidence boundary failed' }
    $taskLines[3] = $taskLines[3].Replace('"fault_slot":1','"fault_slot":0')
    [IO.File]::WriteAllLines($taskMcu, $taskLines)
    $taskRejected = $false
    try { & $Tool -McuLog $taskMcu -RunId 1 | Out-Null } catch { $taskRejected = $true }
    if (-not $taskRejected) { throw 'Corrupt injection position accepted' }
    $taskLines = @('{"kind":"mixed","phase":"begin","run":2,"total":5,"mode":3,"value":2,"seed":1,"planned":2,"fault_index":0}')
    for ($taskI=1; $taskI -le 5; $taskI++) {
        $taskSlot = if ($taskI -in @(2,3)) { 1 } else { 0 }
        $taskLines += '{"kind":"mixed","phase":"slot_begin","run":2,"index":'+$taskI+',"fault_slot":'+$taskSlot+'}'
        $taskLines += '{"kind":"mixed","phase":"slot_end","run":2,"index":'+$taskI+',"fault_slot":'+$taskSlot+',"fault_index":0,"result":0}'
    }
    [IO.File]::WriteAllLines($taskMcu, $taskLines)
    $taskReport = (& $Tool -McuLog $taskMcu -RunId 2 | ConvertFrom-Json)
    if (($taskReport.planned_fault_slots -join ',') -ne '2,3') { throw 'Random generator replay mismatch' }
    Write-Output 'Mixed capture: intent vs physical evidence, matches/missing/unexpected/duplicates and corrupt log rejection PASS'
} finally {
    # Delete only the exact temporary files made above, never a recursive target.
    foreach ($taskFile in @($taskMcu,$taskFpga,$taskPhysical)) { if (Test-Path -LiteralPath $taskFile) { Remove-Item -LiteralPath $taskFile } }
    Remove-Item -LiteralPath $taskTemp
}
