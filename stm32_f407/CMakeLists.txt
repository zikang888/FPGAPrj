cmake_minimum_required(VERSION 3.16)
project(stm32_f407_protocol_node_host_tests C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_library(mc_protocol_common
    common/src/mc_cli_rx.c
    common/src/mc_protocol_runner.c
    common/src/mc_truth_log.c
    common/src/mc_faults.c
    common/src/mc_can_session.c
    common/src/mc_can_raw.c
)
target_include_directories(mc_protocol_common PUBLIC common/include)

if(MSVC)
    target_compile_options(mc_protocol_common PRIVATE /W4)
else()
    target_compile_options(mc_protocol_common PRIVATE -Wall -Wextra -Wpedantic -Werror)
endif()

enable_testing()
add_executable(mc_protocol_tests tests/test_protocol_runner.c)
target_link_libraries(mc_protocol_tests PRIVATE mc_protocol_common)
if(MSVC)
    target_compile_options(mc_protocol_tests PRIVATE /W4)
else()
    target_compile_options(mc_protocol_tests PRIVATE -Wall -Wextra -Wpedantic -Werror)
endif()
add_test(NAME mc_protocol_tests COMMAND mc_protocol_tests)

add_executable(mc_can_session_tests tests/test_can_session.c)
target_link_libraries(mc_can_session_tests PRIVATE mc_protocol_common)
if(MSVC)
    target_compile_options(mc_can_session_tests PRIVATE /W4)
else()
    target_compile_options(mc_can_session_tests PRIVATE -Wall -Wextra -Wpedantic -Werror)
endif()
add_test(NAME mc_can_session_tests COMMAND mc_can_session_tests)

# Compile the actual HAL adapter against a small hardware model in both gate modes.
# This checks register/result handling, not electrical behavior or CAN bit timing.
foreach(gate IN ITEMS default enabled)
    add_executable(mc_can_hal_${gate}_tests
        tests/test_can_session_hal.c hal/src/mc_can_session_hal.c)
    target_include_directories(mc_can_hal_${gate}_tests PRIVATE
        tests/fake_hal hal/include common/include)
    if(gate STREQUAL "enabled")
        target_compile_definitions(mc_can_hal_${gate}_tests PRIVATE MC_ENABLE_CAN_FAULTS)
    endif()
    if(MSVC)
        target_compile_options(mc_can_hal_${gate}_tests PRIVATE /W4)
    else()
        target_compile_options(mc_can_hal_${gate}_tests PRIVATE -Wall -Wextra -Wpedantic -Werror)
    endif()
    add_test(NAME mc_can_hal_${gate}_tests COMMAND mc_can_hal_${gate}_tests)
endforeach()

add_executable(mc_can_raw_tests tests/test_can_raw.c)
target_link_libraries(mc_can_raw_tests PRIVATE mc_protocol_common)
add_executable(mc_can_raw_disabled_tests tests/test_can_raw_disabled.c hal/src/mc_can_raw_hal.c)
target_include_directories(mc_can_raw_disabled_tests PRIVATE tests/fake_hal hal/include)
target_link_libraries(mc_can_raw_disabled_tests PRIVATE mc_protocol_common)
foreach(test IN ITEMS mc_can_raw_tests mc_can_raw_disabled_tests)
    if(MSVC)
        target_compile_options(${test} PRIVATE /W4)
    else()
        target_compile_options(${test} PRIVATE -Wall -Wextra -Wpedantic -Werror)
    endif()
    add_test(NAME ${test} COMMAND ${test})
endforeach()
