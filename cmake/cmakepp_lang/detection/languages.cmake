# Copyright 2025 CMakePP
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
include(cmakepp_lang/utilities/return)

#[[[
# Wraps the process of retrieving a list of enabled languages.
#
# CMake sets a global property
# :ref:`ENABLED_LANGUAGES <https://cmake.org/cmake/help/latest/prop_gbl/ENABLED_LANGUAGES.html>` 
# to be a list of coding
# languages which have been enabled either via 
# :ref:`project() <https://cmake.org/cmake/help/latest/command/project.html>` or 
# the
# :ref:`enable_language() <https://cmake.org/cmake/help/latest/command/enable_language.html>` 
# commands. CMake's documentation is a bit dodgy in 
# discussing what variables the aforementioned commands set, so we wrote this
# function as a wrapper around the logic in the event that CMake changes how
# they do things. At the very least, this function should be more user-
# friendly.
#
# :param: return_variable A variable to hold the resulting list.
# :type: list*
#]]
function(cpp_enabled_languages _el_return_variable)
    get_property("${_el_return_variable}" GLOBAL PROPERTY ENABLED_LANGUAGES)

    # CMake apparently doesn't remove NONE from the list if other languages are
    # also in the list...
    list(LENGTH "${_el_return_variable}" _el_length)
    if("${_el_length}" GREATER 1)
        list(REMOVE_ITEM "${_el_return_variable}" "NONE")
    endif()

    cpp_return("${_el_return_variable}")
endfunction()