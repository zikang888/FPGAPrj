cmake_minimum_required(VERSION 3.16)
project(stm32_f407_protocol_node_host_tests C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_library(mc_protocol_common
    common/src/mc_protocol_runner.c
    common/src/mc_truth_log.c
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
