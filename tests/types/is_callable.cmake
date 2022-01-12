include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_compare_names")
function("${test__cpp_compare_games}")
    include(cmakepp_core/types/is_callable)

    set(sig0 a_fxn int bool)
    ct_add_section(NAME "Names match")
        set(sig1 a_fxn bool int)
        _cpp_compare_names(result sig0 sig1)
        ct_assert_equal(result TRUE)
    endfunction()

    ct_add_section(NAME "Names do not match")
        set(sig1 another_fxn bool int)
        _cpp_compare_names(result sig0 sig1)
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "case_insens_compare")
    function("${case_insens_compare}")
        set(sig1 a_FXN bool int)
        _cpp_compare_names(result sig0 sig1)
        ct_assert_equal(result TRUE)
    endfunction()
endfunction()

ct_add_test(NAME "test__cpp_compare_lengths")
function("${test__cpp_compare_lengths}")
    include(cmakepp_core/types/is_callable)

    ct_add_section(NAME "Function takes no arguments")
        set(sig0 a_fxn)

        ct_add_section(NAME "Trial signature takes no arguments")
            set(sig1 a_fxn)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes more arguments")
            set(sig1 a_fxn int)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Pure variadic function")
        set(sig0 a_fxn args)

        ct_add_section(NAME "Trial signature takes no arguments")
            set(sig1 a_fxn)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes more arguments")
            set(sig1 a_fxn int)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Non-variadic function with one argument")
        set(sig0 a_fxn int)

        ct_add_section(NAME "Trial signature takes no arguments")
            set(sig1 a_fxn)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()

        ct_add_section(NAME "Trial signature takes one argument")
            set(sig1 a_fxn int)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes more arguments")
            set(sig1 a_fxn int bool)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Variadic function with one argument")
        set(sig0 a_fxn int args)

        ct_add_section(NAME "Trial signature takes no arguments")
            set(sig1 a_fxn)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()

        ct_add_section(NAME "Trial signature takes one argument")
            set(sig1 a_fxn int)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes more arguments")
            set(sig1 a_fxn int bool)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "No-variadic function with two arguments")
        set(sig0 a_fxn int bool)

        ct_add_section(NAME "Trial signature takes no arguments")
            set(sig1 a_fxn)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()

        ct_add_section(NAME "Trial signature takes one argument")
            set(sig1 a_fxn int)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()

        ct_add_section(NAME "Trial signature takes two arguments")
            set(sig1 a_fxn int bool)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes more arguments")
            set(sig1 a_fxn int bool path)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Variadic function with two arguments")
        set(sig0 a_fxn int bool args)

        ct_add_section(NAME "Trial signature takes no arguments")
            set(sig1 a_fxn)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()

        ct_add_section(NAME "Trial signature takes one argument")
            set(sig1 a_fxn int)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()

        ct_add_section(NAME "Trial signature takes two arguments")
            set(sig1 a_fxn int bool)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes more arguments")
            set(sig1 a_fxn int bool path)
            _cpp_compare_lengths(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()
endfunction()

ct_add_test(NAME "test_cpp_is_callable")
function("${test_cpp_is_callable}")
    include(cmakepp_core/types/is_callable)

    ct_add_section(NAME "Signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)

        ct_add_section(NAME "0th argument must be desc")
            cpp_is_callable(TRUE a_list b_list)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        endfunction()

        ct_add_section(NAME "1st argument must be desc")
            cpp_is_callable(result TRUE b_list)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        endfunction()

        ct_add_section(NAME "2nd argument must be desc")
            cpp_is_callable(result a_list FALSE)
            ct_assert_fails_as("Assertion: bool is convertible to desc failed.")
        endfunction()

        ct_add_section(NAME "Takes only three arguments")
            cpp_is_callable(result a_list b_list hello)
            ct_assert_fails_as("Function takes 3 argument(s), but 4 was/were")
        endfunction()
    endfunction()

    ct_add_section(NAME "Function takes no arguments")
        set(sig0 a_fxn)

        ct_add_section(NAME "Trial signature takes no arguments")
            set(sig1 a_fxn)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes more arguments")
            set(sig1 a_fxn int)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Pure variadic function")
        set(sig0 a_fxn args)

        ct_add_section(NAME "Trial signature takes no arguments")
            set(sig1 a_fxn)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes more arguments")
            set(sig1 a_fxn int)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Non-variadic with one argument")
        set(sig0 a_fxn int)

        ct_add_section(NAME "Trial signature takes same argument")
            set(sig1 a_fxn int)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes different argument")
            set(sig1 a_fxn bool)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Variadic with one argument")
        set(sig0 a_fxn int args)

        ct_add_section(NAME "Trial signature takes same argument")
            set(sig1 a_fxn int)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes same first argument plus others")
            set(sig1 a_fxn int bool)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes different argument")
            set(sig1 a_fxn bool)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Non-variadic with two arguments")
        set(sig0 a_fxn int bool)

        ct_add_section(NAME "Trial signature takes same arguments")
            set(sig1 a_fxn int bool)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes different first argument")
            set(sig1 a_fxn bool bool)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()

        ct_add_section(NAME "Trial signature takes different second argument")
            set(sig1 a_fxn int int)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "Variadic with two arguments")
        set(sig0 a_fxn int bool args)

        ct_add_section(NAME "Trial signature takes same arguments")
            set(sig1 a_fxn int bool)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes same arguments plus others")
            set(sig1 a_fxn int bool path)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result TRUE)
        endfunction()

        ct_add_section(NAME "Trial signature takes different first argument")
            set(sig1 a_fxn bool bool)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()

        ct_add_section(NAME "Trial signature takes different second argument")
            set(sig1 a_fxn int int)
            cpp_is_callable(result sig0 sig1)
            ct_assert_equal(result FALSE)
        endfunction()
    endfunction()
endfunction()
