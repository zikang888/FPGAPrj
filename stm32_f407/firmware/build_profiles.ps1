param(
    [ValidateSet('default', 'can_fault', 'all')][string]$Profile = 'all',
    [string]$Keil = 'D:\Keil_v5\UV4\UV4.exe',
    [switch]$Release
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $Keil)) { throw "Keil not found: $Keil" }
$taskRoot = Split-Path -Parent $PSScriptRoot
$taskMdk = Join-Path $PSScriptRoot 'Projects\MDK-ARM'
$taskSource = Join-Path $taskMdk 'sky_star_protocol_node.uvprojx'
$taskRevision = (git -C $taskRoot rev-parse HEAD).Trim()
if ($LASTEXITCODE -ne 0) { throw 'Cannot resolve source revision' }
$taskCodeChanges = git -C $taskRoot status --porcelain -- app common hal firmware/Core firmware/Drivers firmware/build_profiles.ps1 firmware/Projects/MDK-ARM/sky_star_protocol_node.uvprojx
if ($taskCodeChanges) {
    if ($Release) { throw 'Release build requires committed firmware sources and build script.' }
    Write-Warning 'Uncommitted source changes: BUILD revision is not a clean-source release identity.'
}
$taskProfiles = if ($Profile -eq 'all') { @('default', 'can_fault') } else { @($Profile) }
foreach ($taskProfile in $taskProfiles) {
    # Generated project stays beside the canonical project to preserve relative source paths.
    [xml]$taskXml = Get-Content -LiteralPath $taskSource -Raw
    $taskTarget = $taskXml.Project.Targets.Target
    $taskName = 'sky_star_' + $taskProfile
    $taskTarget.TargetName = $taskName
    $taskCommon = $taskTarget.TargetOption.TargetCommonOption
    $taskCommon.OutputDirectory = 'profile_' + $taskProfile + '\'
    $taskCommon.ListingPath = './profile_' + $taskProfile + '/'
    $taskCommon.OutputName = $taskName
    $taskBaseDefines = @($taskTarget.TargetOption.TargetArmAds.Cads.VariousControls.Define.Split(',') |
        Where-Object { $_ -notmatch '^MC_BUILD_REV=' -and $_ -ne 'MC_ENABLE_CAN_FAULTS' -and $_ -ne 'MC_ENABLE_CAN_RAW_GPIO' })
    $taskDefines = ($taskBaseDefines -join ',') + ',MC_BUILD_REV=0x' + $taskRevision.Substring(0, 7)
    if ($taskProfile -eq 'can_fault') { $taskDefines += ',MC_ENABLE_CAN_FAULTS,MC_ENABLE_CAN_RAW_GPIO' }
    $taskTarget.TargetOption.TargetArmAds.Cads.VariousControls.Define = $taskDefines
    $taskGenerated = Join-Path $taskMdk ('sky_star_' + $taskProfile + '_generated.uvprojx')
    $taskLog = Join-Path $taskMdk ('profile_' + $taskProfile + '.log')
    $taskSettings = [System.Xml.XmlWriterSettings]::new()
    $taskSettings.Encoding = [System.Text.UTF8Encoding]::new($false)
    $taskSettings.Indent = $true
    $taskWriter = [System.Xml.XmlWriter]::Create($taskGenerated, $taskSettings)
    try { $taskXml.Save($taskWriter) } finally { $taskWriter.Dispose() }
    $taskArguments = '-b "{0}" -j0 -o "{1}"' -f $taskGenerated, $taskLog
    $taskProcess = Start-Process -FilePath $Keil -ArgumentList $taskArguments -WorkingDirectory $taskMdk -WindowStyle Hidden -PassThru -Wait
    $taskText = if (Test-Path -LiteralPath $taskLog) { Get-Content -LiteralPath $taskLog -Raw } else { '' }
    $taskHex = Join-Path $taskMdk ('profile_' + $taskProfile + '\' + $taskName + '.hex')
    if ($taskProcess.ExitCode -ne 0 -or $taskText -notmatch '0 Error\(s\), 0 Warning\(s\)' -or -not (Test-Path -LiteralPath $taskHex)) {
        Write-Output $taskText
        throw "Profile failed: $taskProfile (exit $($taskProcess.ExitCode))"
    }
    $taskSize = [regex]::Match($taskText, 'Program Size:[^\r\n]+').Value
    Write-Output "$taskProfile PASS: $taskSize"
    Get-FileHash -LiteralPath $taskHex -Algorithm SHA256 | Select-Object Path, Hash
}
