param(
    [Parameter(Mandatory=$true)][string]$McuLog,
    [Parameter(Mandatory=$true)][uint32]$RunId,
    [string]$FpgaErrors,
    [string]$ConfirmedErrors
)
$ErrorActionPreference = 'Stop'
function Read-JsonLines([string]$Path) {
    foreach ($taskLine in (Get-Content -LiteralPath $Path)) {
        $taskStart = $taskLine.IndexOf('{')
        if ($taskStart -lt 0) { continue }
        try { $taskLine.Substring($taskStart) | ConvertFrom-Json -ErrorAction Stop }
        catch { throw "Malformed JSON line in $Path" }
    }
}
$taskRecords = @(Read-JsonLines $McuLog | Where-Object { $_.kind -eq 'mixed' -and $_.run -eq $RunId })
$taskBegins = @($taskRecords | Where-Object { $_.phase -eq 'begin' })
if ($taskBegins.Count -ne 1) { throw 'Expected exactly one begin for this run; do not combine MCU boots with reused run IDs.' }
$taskPlan = $taskBegins[0]
$taskExpected = @{}
$taskRng = [uint32]$taskPlan.seed
$taskRemaining = [uint32]$taskPlan.planned
for ($taskIndex=1; $taskIndex -le $taskPlan.total; $taskIndex++) {
    $taskFault = $false
    switch ([int]$taskPlan.mode) {
        0 { }
        1 { $taskFault = $taskIndex -eq $taskPlan.value }
        2 { $taskFault = ($taskIndex % $taskPlan.value) -eq 0 }
        3 {
            $taskRng = [uint32]($taskRng -bxor (([long]$taskRng -shl 13) -band 4294967295L))
            $taskRng = [uint32]($taskRng -bxor ($taskRng -shr 17))
            $taskRng = [uint32]($taskRng -bxor (([long]$taskRng -shl 5) -band 4294967295L))
            $taskFault = ($taskRng % ($taskPlan.total-$taskIndex+1)) -lt $taskRemaining
            if ($taskFault) { $taskRemaining-- }
        }
        default { throw 'Unknown mixed mode' }
    }
    if ($taskFault) { $taskExpected[$taskIndex] = [int]$taskPlan.fault_index }
}
if ($taskExpected.Count -ne $taskPlan.planned) { throw 'Plan count mismatch' }
$taskStarted = @{}
$taskFinished = @{}
$taskLocalFaultOK = @{}
foreach ($taskRecord in $taskRecords) {
    if ($taskRecord.phase -notin @('slot_begin','slot_end','slot_cancel')) { continue }
    $taskIndex = [int]$taskRecord.index
    if ($taskIndex -lt 1 -or $taskIndex -gt $taskPlan.total) { throw 'Slot out of range' }
    if ([bool]$taskRecord.fault_slot -ne $taskExpected.ContainsKey($taskIndex)) { throw "Injection position mismatch: $taskIndex" }
    if ($taskRecord.phase -eq 'slot_begin') {
        if ($taskStarted.ContainsKey($taskIndex)) { throw 'Duplicate slot begin' }
        $taskStarted[$taskIndex] = $true
    } else {
        if (-not $taskStarted.ContainsKey($taskIndex) -or $taskFinished.ContainsKey($taskIndex)) { throw 'Missing begin or duplicate completion' }
        $taskFinished[$taskIndex] = $taskRecord.phase
        if ($taskRecord.phase -eq 'slot_end' -and $taskRecord.fault_slot -and $taskRecord.result -eq 0) {
            $taskLocalFaultOK[$taskIndex] = [int]$taskRecord.fault_index
        }
    }
}
$taskEnds = @($taskRecords | Where-Object { $_.phase -eq 'end' })
$taskLast = if ($taskEnds.Count) { $taskEnds[-1] } else { $null }
$taskComplete = $null -ne $taskLast -and $taskLast.state -eq 2 -and -not $taskLast.held -and
    $taskLast.completed -eq $taskPlan.total -and $taskLast.failed -eq 0 -and $taskLast.result -eq 0 -and
    $taskFinished.Count -eq $taskPlan.total
function Error-Keys([string]$Path, [bool]$RequireScheduled) {
    foreach ($taskError in (Read-JsonLines $Path | Where-Object { $_.run -eq $RunId })) {
        if ($null -eq $taskError.index -or $null -eq $taskError.fault_index -or
            [int]$taskError.index -lt 1 -or [int]$taskError.index -gt $taskPlan.total) { throw 'Invalid normalized error record' }
        if ($RequireScheduled -and (-not $taskLocalFaultOK.ContainsKey([int]$taskError.index) -or
            [int]$taskError.fault_index -ne $taskLocalFaultOK[[int]$taskError.index])) {
            throw 'Confirmed injected error must reference a locally completed intended fault slot'
        }
        '{0}:{1}' -f [int]$taskError.index,[int]$taskError.fault_index
    }
}
$taskReport = [ordered]@{
    run = $RunId; total = $taskPlan.total; planned_fault_slots = @($taskExpected.Keys | Sort-Object)
    slots_started = $taskStarted.Count; slots_finished_or_cancelled = $taskFinished.Count
    locally_ok_fault_slots = @($taskLocalFaultOK.Keys | Sort-Object); local_run_complete = [bool]$taskComplete
    physical_verified_by_this_tool = $false; comparison = 'not_requested'
}
if ($FpgaErrors) {
    $taskObserved = @(Error-Keys $FpgaErrors $false)
    $taskUnique = @($taskObserved | Select-Object -Unique)
    $taskReference = if ($ConfirmedErrors) { @(Error-Keys $ConfirmedErrors $true | Select-Object -Unique) }
        else { @($taskLocalFaultOK.Keys | ForEach-Object { '{0}:{1}' -f $_,$taskLocalFaultOK[$_] }) }
    $taskMatched = @($taskReference | Where-Object { $_ -in $taskUnique })
    $taskMissing = @($taskReference | Where-Object { $_ -notin $taskUnique })
    $taskUnexpected = @($taskUnique | Where-Object { $_ -notin $taskReference })
    $taskReport.comparison = if ($ConfirmedErrors) { 'against_user_supplied_physical_confirmations' } else { 'intent_only_NOT_detection_accuracy' }
    $taskReport.matched = $taskMatched
    $taskReport.missing = $taskMissing
    $taskReport.unexpected = $taskUnexpected
    $taskReport.duplicate_reports = $taskObserved.Count-$taskUnique.Count
}
$taskReport | ConvertTo-Json -Depth 5
