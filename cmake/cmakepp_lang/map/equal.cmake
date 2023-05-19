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

include(cmakepp_lang/algorithm/equal)
include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/map/map)

#[[[
# Determines if two map instances are equivalent.
#
# Two map instances are considered equal if they contain the same keys and each
# key is associated with the same value. The order of the keys does not need to
# be the same.
#
# :param this: One of the two maps being compared.
# :type this: map
# :param result: Name for the variable which will hold the result.
# :type result: desc
# :param other: The map we are comparing to.
# :type other: map
# :returns: ``result`` will be set to ``TRUE`` if the two map instances
#           compare equal and ``FALSE`` otherwise.
# :rtype: bool
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
# 
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will assert that it was provided
# exactly three arguments, and that those arguments have the correct types. If
# these assertions fail an error will be raised. These error checks are only
# done if CMakePP is run in debug mode.
#]]
function(cpp_map_equal _me_this _me_result _me_other)
    cpp_assert_signature("${ARGV}" map desc map)

    # Get this map's keys and the number of them
    cpp_map_keys("${_me_this}" _me_my_keys)
    list(LENGTH _me_my_keys _me_my_n_keys)

    # Ge the other map's keys and the number of them
    cpp_map_keys("${_me_other}" _me_other_keys)
    list(LENGTH _me_other_keys _me_other_n_keys)

    # Compare the number of keys
    if(NOT "${_me_other_n_keys}" EQUAL "${_me_my_n_keys}")
        set("${_me_result}" FALSE PARENT_SCOPE)
        return()
    elseif("${_me_my_n_keys}" EQUAL 0) # This trips if both are empty
        set("${_me_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # Loop over keys
    foreach(_me_key_i ${_me_my_keys})

        # Make sure other has the key
        cpp_map_has_key("${_me_other}" _me_good_key "${_me_key_i}")
        if(NOT "${_me_good_key}")
            set("${_me_result}" FALSE PARENT_SCOPE)
            return()
        endif()

        # Get the value each map associates with this key
        cpp_map_get("${_me_this}" _me_my_value "${_me_key_i}")
        cpp_map_get("${_me_other}" _me_other_value "${_me_key_i}")

        # Compare those values
        cpp_equal(_me_good_value "${_me_my_value}" "${_me_other_value}")
        if(NOT "${_me_good_value}")
            set("${_me_result}" FALSE PARENT_SCOPE)
            return()
        endif()
    endforeach()

    # Getting here means the maps weren't different so return TRUE
    set("${_me_result}" TRUE PARENT_SCOPE)
endfunction()
