include(cmake_test/cmake_test)

ct_add_test(NAME [[test_cpp_stop_timing]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/timer)

    ct_add_section(NAME [[timer_not_starter]] EXPECTFAIL)
    function("${CMAKETEST_SECTION}")
        cpp_stop_timing(time not_a_timer)
    endfunction()
endfunction()

ct_add_test(NAME [[cpp_time_fxn]])
function("${CMAKETEST_TEST}")
    include(cmakepp_lang/utilities/timer)

    function(fxn2time)
    endfunction()

    cpp_time_fxn(fxn2time)

    ct_assert_prints("Time for fxn2time")
endfunction()
