$ErrorActionPreference='Stop'
$candidate=Split-Path -Parent $PSScriptRoot
$baseline='D:\fpga_class\FPGAPrj\ab_new_board_test_20261017'
$gccRoot='D:\Vivado2018.3\SDK\2018.3\gnu\aarch32\nt\gcc-arm-none-eabi\bin'
$bsp=Join-Path $baseline 'build\ui-workflow-20261023\sdk\platform_bsp\ps7_cortexa9_0'
$linker=Join-Path $baseline 'build\ui-workflow-20261023\sdk\platform_app\src\lscript.ld'
$out=Join-Path $candidate 'build\ui-workbench-a-20261030\arm'
New-Item -ItemType Directory -Path $out -Force | Out-Null
$objects=@()
foreach($name in @('capture_demo','main','platform_ui','ps_gpio','ps_iic','touch')){
    $source=Join-Path $candidate "software\src\$name.c"
    $object=Join-Path $out "$name.o"
    & "$gccRoot\arm-none-eabi-gcc.exe" -Wall -Wextra -O3 -g3 -c -fmessage-length=0 -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard "-I$bsp\include" $source -o $object
    if($LASTEXITCODE -ne 0){throw "ARM compile failed: $name"}
    $objects+=$object
}
& "$gccRoot\arm-none-eabi-gcc.exe" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard '-Wl,-build-id=none' "-specs=$baseline\build\ui-workflow-20261023\sdk\platform_app\src\Xilinx.spec" '-Wl,-T' "-Wl,$linker" "-L$bsp\lib" -o "$out\platform_app.elf" @objects '-Wl,--start-group,-lxil,-lgcc,-lc,--end-group'
if($LASTEXITCODE -ne 0){throw 'ARM link failed'}
& "$gccRoot\arm-none-eabi-size.exe" "$out\platform_app.elf"
if($LASTEXITCODE -ne 0){throw 'ELF inspection failed'}
Get-FileHash -LiteralPath "$out\platform_app.elf" -Algorithm SHA256
Write-Output 'UI_A_ARM_BUILD_PASS'
