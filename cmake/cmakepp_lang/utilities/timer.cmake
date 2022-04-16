include_guard()
include(cmakepp_lang/utilities/call_fxn)
include(cmakepp_lang/utilities/return)
include(cmakepp_lang/utilities/sanitize_string)
include(cmakepp_lang/utilities/unique_id)

#[[[ Starts a timer using the provided name.
#
# This function is used to start a timer under the provided name. If another
# timer has previously been created using this name it will be overridden.
#
# :param _st_name: The name for the timer.
# :type _st_name: desc
#
#]]
function(cpp_start_timing _st_name)
    cpp_sanitize_string(_st_nice_name "${_st_name}")
    set(_st_start_var "__CMAKEPP_LANG_${_st_nice_name}_TIMER_START__")
    string(TIMESTAMP "${_st_start_var}" "%s")
    cpp_return("${_st_start_var}")
endfunction()


#[[[ Stops and computes the time since the specified timer was started.
#
# This function will compute the time (in seconds) since the specified timer was
# started. Despite the name of this function, the timer will persist meaning it
# is possible to continue to measure time since the timer was started with
# additional calls.
#
# :param _st_time: Name for variable which will hold how long (in seconds) the
#                  the timer has been running.
# :type _st_time: desc
# :param _st_name: The name of the timer we want to measure
# :type _st_name: desc
# :returns: ``_st_time`` will be set to the time (in seconds) since the timer
#           was started.
# :rtype: int
#
# Error Checking
# ==============
#
# This function will assert that the specified timer exists. If the timer does
# not exist an error will be raised. This error check is always performed.
#
#]]
function(cpp_stop_timing _st_time _st_name)
    # Record the time right away to increase accuracy
    string(TIMESTAMP _st_end "%s")

    # Now look for the timer, if it doesn't exist raise an understandable error
    cpp_sanitize_string(_st_nice_name "${_st_name}")
    set(_st_start_var "__CMAKEPP_LANG_${_st_nice_name}_TIMER_START__")

    if("${${_st_start_var}}" STREQUAL "")
        message(FATAL_ERROR "Timer ${_st_name} was never started.")
    endif()

    # If the timer hadn't existed this would have raised a syntax error anyways
    math(EXPR "${_st_time}" "${_st_end} - ${${_st_start_var}}")

    # Return the time since the timer started
    set("${_st_time}" "${${_st_time}}" PARENT_SCOPE)
endfunction()

#[[[ Convenience function for printing the time since a timer was started.
#
# Usually when we are timing something we want to log the time. This function is
# a convenience function which will do that by printing the timer to standard
# out.
#
# :param _sapt_name: The name of the timer we are measuring.
# :type _sapt_name: desc
#
# Error Checking
# ==============
#
# This function will assert that the specified timer exists. If the timer does
# not exist an error will be raised. This error check is always performed.
#
#]]
function(cpp_stop_and_print_timing _sapt_name)
    cpp_stop_timing(_sapt_time "${_sapt_name}")
    message("Time for ${_sapt_name} : ${_sapt_time} s")
endfunction()

#[[[ Convenience function for timing a function.
#
# A very common timing scenario is that we want to know how long it takes a
# function to run. This function is a convenience function for doing that and
# will start a timer, call the function to be timed, and print how long the
# function ran for.
#
# :param _tf_fxn_name: The name of the function we are timing.
# :type _tf_fxn_name: fxn
# :param *args: The arguments which should be forwarded to the function.
#
#]]
function(cpp_time_fxn _tf_fxn_name)

    # Use a unique ID for the timer to avoid clobbering existing timers
    cpp_unique_id(_tf_timer_name)

    # Start timer, call function, and stop the timer
    cpp_start_timing("${_tf_timer_name}")
    cpp_call_fxn("${_tf_fxn_name}" ${ARGS})
    cpp_stop_timing(_tf_time "${_tf_timer_name}")

    # Record how long it took.
    message("Time for ${_tf_fxn_name}: ${_tf_time} s.")
endfunction()
