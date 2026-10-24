# Dedicated 2026.1 build. Never open or upgrade the checked-in legacy XPR.
set script_dir [file dirname [file normalize [info script]]]
set source_dir [file dirname [file dirname $script_dir]]
set migration_root [file dirname [file dirname $source_dir]]
set allowed_build_root [file normalize [file join $migration_root migration_build 2026.1]]
set build_dir [file join $allowed_build_root pl]
if {[info exists ::env(MULTI_PROTOCOL_BUILD_DIR)] && $::env(MULTI_PROTOCOL_BUILD_DIR) ne ""} {
    set build_dir [file normalize $::env(MULTI_PROTOCOL_BUILD_DIR)]
}
proc migration_assert_build_path {path} {
    global allowed_build_root
    set normalized [string tolower [string map {\\ /} [file normalize $path]]]
    set root [string tolower [string map {\\ /} $allowed_build_root]]
    if {![string match "${root}/*" $normalized]} {
        error "Refusing write outside dedicated migration build: $path"
    }
}
migration_assert_build_path $build_dir
if {![string match "2026.1*" [version -short]]} {
    error "This entry point requires Vivado 2026.1, got [version -short]"
}
file mkdir $build_dir
set num_jobs 2
set_param general.maxThreads 4
