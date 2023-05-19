# Copyright 2023 CMakePP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_guard()

#[[[
# Logic for enabling/disabling code when CMakePP is run in debug mode.
#
# CMakePP supports a "debug mode" which enables potentially computationally
# expensive logging and error checks. In release mode these operations are
# skipped so that the build proceeds as fast as possible. The
# ``cpp_enable_if_debug`` function will only allow the remainder of the function
# to run if debug mode has been enable (done by setting
# ``CMAKE_CORE_DEBUG_MODE`` to ``TRUE``/``ON``).
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
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
    elseif(NOT "${CMAKEPP_LANG_DEBUG_MODE}")
        return()
    endif()
endmacro()
