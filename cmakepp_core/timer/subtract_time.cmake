include_guard()

#[[[ Carries from days to hours.
#
# This function wraps the process of breaking one day into 24 hours when we are
# implementing subtraction of timestamps.
#
# .. note::
#
#    ``_borrow_from_days`` is a macro only because we create no temporaries in
#    it and by making it a macro we save lines on the returns.
#
# :param _bfd_day: An identifier holding the number of days. The value is
#                  assumed to be greater than 0.
# :type _bfd_day: int*
# :param _bfd_hour: An identifier holding the number of hours.
# :type _bfd_hour: int*
# :returns: In-place subtracts one from the value of ``_bfd_day`` and in-place
#           increases the value of ``_bfd_hour`` by 24.
# :rtype: int*
#]]
macro(_borrow_from_days _bfd_day _bfd_hour)
    math(EXPR ${_bfd_hour} "${${_bfd_hour}} + 24")
    math(EXPR ${_bfd_day} "${${_bfd_day}} - 1")
endmacro()

#[[[ Carries from hours to minutes.
#
# This function wraps the process of breaking one hour into 60 minutes, possibly
# by breaking one day into 24 hours (only if ``_bfd_hour == 0``). This function
# is meant to be used in implementing subtraction of timestamps.
#
# .. note::
#
#    ``_borrow_from_hours`` is a macro only because we create no temporaries
#    in it and by making it a macro we save lines on the returns.
#
# :param _bfh_day: An identifier hodling the number of days. Held value is
#                  assumed to be greater than 0.
# :type _bfh_day: identifier
# :param _bfh_hour: An identifier hodling the number of hours. Held value is
#                   assumed to be greater than 0.
# :type _bfh_hour: identifier
# :param _bfh_min: An identifier holding the number of minutes.
# :type _bfh_min: identifier
# :returns: All or only some inputs may be modified depending on how many
#           carries are needed to get an hour to break into minutes.
#]]
macro(_borrow_from_hours _bfh_day _bfh_hour _bfh_min)
    math(EXPR ${_bfh_min} "${${_bfh_min}} + 60")
    if("${${_bfh_hour}}" STREQUAL 0)
        _borrow_from_days(${_bfh_day} ${_bfh_hour})
    endif()
    math(EXPR ${_bfh_hour} "${${_bfh_hour}} - 1")
endmacro()

#[[[ Carries from minutes to seconds.
#
# This function wraps the process of breaking one minute into 60 seconds,
# possibly by breaking hours and days if needed. This function is meant to be
# used in implementing subtraction of timestamps.
#
# .. note::
#
#    ``_borrow_from_minutes`` is a macro only because we create no temporaries
#    in it and by making it a macro we save lines on the returns.
#
# :param _bfm_day: An identifier hodling the number of days. Held value is
#                  assumed to be greater than 0.
# :type _bfm_day: identifier
# :param _bfm_hour: An identifier hodling the number of hours. Held value is
#                   assumed to be greater than 0.
# :type _bfm_hour: identifier
# :param _bfm_min: An identifier holding the number of minutes. Held value is
#                 assumed to be greater than 0.
# :type _bfm_min: identifier
# :param _bfm_sec: An identifier holding the number of seconds.
# :type _bfm_sec: identifier
# :returns: All or only some inputs may be modified depending on how many
#           carries are needed to get a minute to break into seconds.
#]]
macro(_borrow_from_minutes _bfm_day _bfm_hour _bfm_min _bfm_sec)
    math(EXPR ${_bfm_sec} "${${_bfm_sec}} + 60")
    if("${${_bfm_min}}" STREQUAL 0)
        _borrow_from_hours(${_bfm_day} ${_bfm_hour} ${_bfm_min})
    endif()
    math(EXPR ${_bfm_min} "${${_bfm_min}} - 1")
endmacro()

#[[[ Parses a timestamp and returns the parts.
#
# This function encapsulates the process of parsing a timestamp and separating
# it into days, hours, minutes and seconds. It is assumed that the format of the
# timestamp is ``w:x:y:z`` where:
#
# - ``w`` is the day of the year as a three digit integer [1,366]
# - ``x`` is the hour on a 24-hour clock as a two digit integer [00, 23]
# - ``y`` is the minute of the current hour as a two digit integer [00, 59]
# - ``z`` is the second of the current minute as a two digit integer [00, 59]
#
# If the timestamp provided to this function has an incorrect format an error
# will be raised.
#
# :param _ctps_d: An identifier to hold ``w``.
# :type _ctps_d: identifier
# :param _ctps_h: An identifier to hold ``x``.
# :type _ctps_h: identifier
# :param _ctps_m: An identifier to hold ``y``.
# :type _ctps_m: identifier
# :param _ctps_s: An identifier to hold ``z``.
# :type _ctps_s: identifier
# :param _ctps_stamp: The timestamp to parse.
# :type _ctps: str
# :returns: ``_ctps_d``, ``_ctps_h``, ``_ctps_m``, and ``_ctps_s`` will
#           respectively hold the ``w``, ``x``, ``y``, and ``z`` from the
#           timestamp upon this functions return.
#]]
function(_cmakepp_timer_parse_stamp _ctps_d _ctps_h _ctps_m _ctps_s _ctps_stamp)
    set(_ctps_regex "(...):(..):(..):(..)")
    string(REGEX MATCH "${_ctps_regex}" _ctps_match "${_ctps_stamp}")

    if("${_ctps_match}" STREQUAL "")
        message(FATAL_ERROR "Timestamp: ${_ctps_stamp} has incorrect format.")
    endif()

    set(${_ctps_d} "${CMAKE_MATCH_1}" PARENT_SCOPE)
    set(${_ctps_h} "${CMAKE_MATCH_2}" PARENT_SCOPE)
    set(${_ctps_m} "${CMAKE_MATCH_3}" PARENT_SCOPE)
    set(${_ctps_s} "${CMAKE_MATCH_4}" PARENT_SCOPE)
endfunction()

#[[[ Returns the difference, in seconds, between two timestamps
#
# Natively CMake's only timing capabilities come from timestamps. This function
# will parse two timestamps and return the difference in seconds.
#]]
function(_subtract_timestamps _st_dt _st_final _st_initial)
    _cmakepp_timer_parse_stamp(_st_day _st_hour _st_min _st_sec "${_st_final}")
    _cmakepp_timer_parse_stamp(
        _st_day0 _st_hour0 _st_min0 _st_sec0 "${_st_initial}"
    )

    if("${_st_day}" LESS "${_st_day0}")
        message(FATAL_ERROR "Do not yet support subtracting across years.")
    endif()

    # If final seconds are less than initial we need to borrow from minuts
    if("${_st_sec}" LESS "${_st_sec0}")
        _borrow_from_minutes(_st_day _st_hour _st_min _st_sec)
    endif()

    # If final minutes are less than initial we need to borrow from hours
    if("${_st_min}" LESS "${_st_min0}")
        _borrow_from_hours(_st_day _st_hour _st_min)
    endif()

    # If final hours are less than initial we need to borrow from days
    if("${_st_hour}" LESS "${_st_hour0}")
        _borrow_from_days(_st_day _st_hour)
    endif()

    math(EXPR _st_ds "${_st_sec} - ${_st_sec0}")
    math(EXPR _st_dm "${_st_min} - ${_st_min0}")
    math(EXPR _st_dh "${_st_hour} - ${_st_hour0}")
    math(EXPR _st_dd "${_st_day} - ${_st_day0}")
    math(
        EXPR
        ${_st_dt}
        "86400*${_st_dd} + 3600*${_st_dh} + 60*${_st_dm} + ${_st_ds}"
    )
    set(${_st_dt} "${${_st_dt}}" PARENT_SCOPE)
endfunction()
