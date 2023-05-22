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
# Asserts that provided value is true.
#
# The ``cpp_assert`` function is code factorization for the very common scenario
# where we want to crash the program if a condition is not met.
#
# :param cond: The condition which should be true. This can be anything that
#              can be passed to CMake's ``if`` statement; however, if the
#              condition is not a single argument it must be provided as a
#              list, *e.g.*, ``x STREQUAL x`` becomes ``x;STREQUAL;x``.
# :type cond: bool or str or list(str)
# :param desc: Human-readable description of the assertion.
# :type desc: str
#
# Example Usage
# =============
#
# This first example shows how to use ``cpp_assert`` to ensure that an object is
# a particular type (in this case an integer). It should be noted that this same
# functionality is provided by the ``cpp_assert_int`` function and does not need
# to be reimplemented.
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/asserts/assert)
#    include(cmakepp_lang/types/integer)
#    cpp_is_int(is_int 3)
#    cpp_assert("${_is_int}" "3 is an integer")
#
# This second example shows how to pass an actual condition as opposed to a
# result:
#
# .. code-block:: cmake
#
#    include(cmakepp_lang/asserts/assert)
#    set(x 4)
#    cpp_assert("${x};GREATER;3" "x is > 3")
#]]
function(cpp_assert _ca_cond _ca_desc)
    if(NOT ${_ca_cond})
        message(FATAL_ERROR "Assertion: ${_ca_desc} failed.")
    endif()
endfunction()
