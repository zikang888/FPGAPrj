param([string]$Compiler='D:\Vivado2018.3\Vivado\2018.3\tps\mingw\6.2.0\win64.o\nt\bin\gcc.exe')
$ErrorActionPreference='Stop'
$projectRoot=Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$outputRoot=Join-Path $projectRoot 'build\session20261020'
New-Item -ItemType Directory -Path (Join-Path $outputRoot 'preview') -Force | Out-Null
if(!(Test-Path -LiteralPath $Compiler)){throw "Set -Compiler to a working host gcc executable."}
Push-Location -LiteralPath $projectRoot
try {
    foreach($name in @('test_history','session_lifecycle','manual_capture','ui_protocol_select',
                       'spi_trace','protocol_trace','waveform_view','event_audit','error_model','event_view','pixel_scroll','ui_counter_semantics','ui_workflow','history_gesture','home_trace_hold')) {
        $exe=Join-Path $outputRoot "$name.exe"
        & $Compiler -std=c99 -Wall -Wextra -Wpedantic -Werror -I software/tests/stubs "software/tests/${name}_test.c" -o $exe
        if($LASTEXITCODE -ne 0){throw "Compile failed: $name"}
        & $exe
        if($LASTEXITCODE -ne 0){throw "Test failed: $name"}
        Write-Output "PASS $name"
    }
    $previewExe=Join-Path $outputRoot 'ui_session_preview.exe'
    & $Compiler -std=c99 -Wall -Wextra -Wpedantic -Werror -I software/tests/stubs software/tests/ui_session_preview.c -o $previewExe
    if($LASTEXITCODE -ne 0){throw 'UI preview compile failed'}
    & $previewExe (Join-Path $outputRoot 'preview')
    if($LASTEXITCODE -ne 0){throw 'UI preview/touch test failed'}
    Write-Output 'SESSION_CHECKS_PASS'
} finally { Pop-Location }
