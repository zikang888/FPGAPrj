set script_dir [file dirname [file normalize [info script]]]
set proj_dir [file dirname $script_dir]
set sdk_dir [file join $proj_dir Multi_protocol.sdk]
if {[info exists ::env(MULTI_PROTOCOL_HDF)] &&
    $::env(MULTI_PROTOCOL_HDF) ne ""} {
    set hdf_file [file normalize $::env(MULTI_PROTOCOL_HDF)]
} else {
    # The normal GUI/headless flow uses the HDF exported by this project.
    # A release HDF can still be selected explicitly with MULTI_PROTOCOL_HDF.
    set hdf_file [file join $sdk_dir multi_protocol_bd_wrapper.hdf]
}
if {[info exists ::env(MULTI_PROTOCOL_SDK_WS)] &&
    $::env(MULTI_PROTOCOL_SDK_WS) ne ""} {
    set ws_dir [file normalize $::env(MULTI_PROTOCOL_SDK_WS)]
} else {
    # Match Vivado/SDK's "<Local to Project>" location so the GUI opens the
    # application projects without asking for a separate workspace path.
    set ws_dir $sdk_dir
}

if {![file exists $hdf_file]} {
    puts "ERROR: missing $hdf_file; build the bitstream first"
    exit 1
}

setws $ws_dir
catch {sdk setws $ws_dir}

set stale_projects [list platform_app platform_bsp platform_hw]
foreach project_name $stale_projects {
    catch {deleteprojects -name $project_name}
}
foreach project_name $stale_projects {
    set project_path [file join $ws_dir $project_name]
    if {[file exists $project_path]} {
        file delete -force $project_path
    }
}

createhw -name platform_hw -hwspec $hdf_file
createbsp -name platform_bsp -hwproject platform_hw \
    -proc ps7_cortexa9_0 -os standalone
createapp -name platform_app -hwproject platform_hw \
    -proc ps7_cortexa9_0 -os standalone -lang C \
    -app {Empty Application} -bsp platform_bsp
# The SDK project uses a portable Eclipse linked folder. It points at the
# Git-tracked software/src directory, so SDK edits and branch pulls operate on
# the same authoritative files without copying them into the workspace.
set app_project_file [file join $ws_dir platform_app .project]
set project_fp [open $app_project_file r]
set project_xml [read $project_fp]
close $project_fp
if {[file normalize $ws_dir] eq [file normalize $sdk_dir]} {
    set link_location "\t\t\t<locationURI>PARENT-2-PROJECT_LOC/software/src</locationURI>"
} else {
    set source_dir [file normalize [file join $script_dir src]]
    set source_dir_xml [string map {& &amp; < &lt; > &gt;} $source_dir]
    set link_location "\t\t\t<location>$source_dir_xml</location>"
}
set linked_resources "\t<linkedResources>\n\t\t<link>\n\t\t\t<name>repo_src</name>\n\t\t\t<type>2</type>\n$link_location\n\t\t</link>\n\t</linkedResources>"
if {![string match *<linkedResources>* $project_xml]} {
    set project_xml [string map [list "</projectDescription>" \
        "$linked_resources\n</projectDescription>"] $project_xml]
    set project_fp [open $app_project_file w]
    puts -nonewline $project_fp $project_xml
    close $project_fp
}
after 1000
catch {configapp -app platform_app compiler-optimization {Optimize most (-O3)}}

# SDK 2018.3's headless application builder expects both the GNU tools and
# Xilinx.spec to be directly available from the generated Debug directory.
if {[info exists ::env(XILINX_SDK)] &&
    [file isdirectory $::env(XILINX_SDK)]} {
    set sdk_root [file normalize $::env(XILINX_SDK)]
} elseif {[info exists ::env(RDI_APPROOT)] &&
          [file isdirectory $::env(RDI_APPROOT)]} {
    set sdk_root [file normalize $::env(RDI_APPROOT)]
} else {
    # Compatibility fallbacks for the original development machines.
    set sdk_root {D:/Xilinx/SDK/2018.3}
    if {![file isdirectory $sdk_root]} {
        set sdk_root {D:/Vivado2018.3/SDK/2018.3}
    }
}
if {![file isdirectory $sdk_root]} {
    puts "ERROR: Xilinx SDK root not found; run this script with xsct.bat"
    exit 1
}
set gcc_bin [file join $sdk_root gnu aarch32 nt gcc-arm-none-eabi bin]
set make_bin [file join $sdk_root gnuwin bin]
set ::env(PATH) "${gcc_bin};${make_bin};$::env(PATH)"
set app_debug_dir [file join $ws_dir platform_app Debug]
file mkdir $app_debug_dir
file copy -force \
    [file join $ws_dir platform_app src Xilinx.spec] \
    [file join $app_debug_dir Xilinx.spec]

projects -build

set elf_file [file join $ws_dir platform_app Debug platform_app.elf]
if {![file exists $elf_file]} {
    set old_dir [pwd]
    cd $app_debug_dir
    set make_exe [file join $sdk_root gnuwin bin make.exe]
    if {[catch {exec $make_exe all 2>@1} make_output]} {
        puts $make_output
        cd $old_dir
        puts "ERROR: direct SDK application build failed"
        exit 1
    }
    puts $make_output
    cd $old_dir
}
if {![file exists $elf_file]} {
    puts "ERROR: SDK build did not produce $elf_file"
    exit 1
}

puts "PS_BUILD_DONE"
puts "ELF: $elf_file"
exit
