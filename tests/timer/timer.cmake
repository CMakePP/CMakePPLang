include(cmake_test/cmake_test)

ct_add_test("timer class")
    include(cmakepp_core/timer/timer)

    start_cmakepp_timer("timer")
    execute_process(COMMAND sleep 2)
    stop_cmakepp_timer(total "timer")

    if(${total} LESS 2)
        message(FATAL_ERROR "Computed that we slept for ${total} != 2 seconds")
    endif()
ct_end_test()
