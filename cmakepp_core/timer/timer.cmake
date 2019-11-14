include_guard()
include(cmakepp_core/timer/subtract_time)

#[[[ Starts a timer associated with the provided tag.
#
# This function starts a timer so that you can measure the passage of time, such
# as for profiling. We support having concurrent timers by allowing you to tag
# your timers. Each tag is associated with a unique timer, which starts when you
# call ``start_cmakepp_timer`` with that tag. Timers are local objects and are
# freed-up when the current scope returns.
#
# :param _sct_name: The name to tag the newly created timer with.
# :type _sct_name: str
#]]
function(start_cmakepp_timer _sct_name)
    string(TIMESTAMP "__timer__${_sct_name}_start" "%j:%H:%M:%S")
    set(
        "__timer__${_sct_name}_start"
        "${__timer__${_sct_name}_start}"
        PARENT_SCOPE
    )
endfunction()

#[[[ Measures the time since a particular timer was started.
#
# This function determines how much time has passed (in seconds) since the
# specified timer was started. Despite the name, this function does not actually
# stop the timer, and it is possible to keep making measurements against the
# original starting point. The timer can be reset by calling
# ``start_cmakepp_timer`` again with the same tag.
#
# :param _sct_time: An identifier to hold the time since the timer was started.
# :type _sct_time: identifier.
# :param _sct_name: The name of the timer we want the time from.
# :type _sct_name: str
# :returns: The time since ``_sct_name`` was started, in seconds. The result is
#           accessible via ``_sct_time``.
#]]
function(stop_cmakepp_timer _sct_time _sct_name)
    string(TIMESTAMP "__timer__${_sct_name}_now" "%j:%H:%M:%S")
    _subtract_timestamps(
       _sct_dt "${__timer__${_sct_name}_now}" "${__timer__${_sct_name}_start}"
    )
    set(${_sct_time} "${_sct_dt}" PARENT_SCOPE)
endfunction()
