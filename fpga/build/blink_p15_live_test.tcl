# Deprecated compatibility entry point. The controllable board LED is D1/P21,
# not P15. Keep this file so old commands continue to run the correct test.
source [file join [file dirname [info script]] blink_d1_live_test.tcl]
