include(cmake_test/cmake_test)

ct_add_test("cpp_stop_timing")
    include(cmakepp_core/utilities/timer)

    ct_add_section("Raises an error if timer was not started.")
        cpp_stop_timing(time not_a_timer)
        ct_assert_fails_as("Timer not_a_timer was never started.")
    ct_end_section()
ct_end_test()

ct_add_test("cpp_time_fxn")
    include(cmakepp_core/utilities/timer)

    function(fxn2time)
    endfunction()

    cpp_time_fxn(fxn2time)

    ct_assert_prints("Time for fxn2time")
ct_end_test()
