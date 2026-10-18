# Prepare an editable GUI project without synthesis or board programming.
set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file dirname [file dirname $script_dir]]
if {![info exists ::env(MULTI_PROTOCOL_BUILD_DIR)] ||
    $::env(MULTI_PROTOCOL_BUILD_DIR) eq ""} {
    set ::env(MULTI_PROTOCOL_BUILD_DIR) [file join $repo_dir build vivado]
}
set ::MULTI_PROTOCOL_KEEP_VIVADO_OPEN 1
source [file join $script_dir create_project.tcl]
source [file join $script_dir create_bd.tcl]
puts "GUI_WORKSPACE_READY"
exit
