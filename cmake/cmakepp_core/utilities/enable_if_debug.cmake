include_guard()

#[[[ Logic for enabling/disabling code when CMakePP is run in debug mode.
#
# CMakePP supports a "debug mode" which enables potentially computationally
# expensive logging and error checks. In release mode these operations are
# skipped so that the build proceeds as fast as possible. The
# ``cpp_enable_if_debug`` function will only allow the remainder of the function
# to run if debug mode has been enable (done by setting
# ``CMAKE_CORE_DEBUG_MODE`` to ``TRUE``/``ON``).
#
# :var CMAKE_CORE_DEBUG_MODE: Whether or not CMakePP is being run in debug mode.
# :type CMAKE_CORE_DEBUG_MODE: bool
#
# .. warning::
#
#    This function is a macro in order to allow it to prematurely return from
#    the function that called it. For this reason it is important that
#    ``cpp_enable_if_debug`` is only called from functions and **NOT** macros.
#
# Error Checking
# ==============
#
# ``cpp_enable_if_debug`` will raise an error if it is called with any
# arguments.
#]]
macro(cpp_enable_if_debug)
    if("${ARGC}" GREATER 0)
        message(FATAL_ERROR "cpp_enable_if_debug accepts no arguments.")
    elseif(NOT "${cmakepp_lang_DEBUG_MODE}")
        return()
    endif()
endmacro()
