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

include(cmakepp_lang/class/detail/bases)
include(cmakepp_lang/object/object)
include(cmakepp_lang/types/cmakepp_type)

#[[[
# Reads KWARGS and assigns sets the appropriate attributes values.
#
# This function takes in an object (an instance of a class) and the KWARGS
# passed to that object's CTOR. It parses the keywords and values from those
# KWARGS and sets the attribute values of the object. For example a class called
# MyClass with attributes "a", "b", and "c" might get a call to its CTOR like:
#
# MyClass(CTOR my_instances KWARGS a red b orange yellow green c blue)
#
# This function would assign the following for my_instance's attributes"
# a = red, b = orange;yellow;green, c = blue
#
# :param this: The object whose KWARG CTOR was called
# :type this: obj
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will ensure that it was
# called with and object as the first argument.
#
# Additionally, this function will ensure that the proper syntax is used for
# the list of KWARGS. That is the KWARGS must consist of pairings of attribute
# name and then one or more values and so on.
#]]
function(_cpp_set_kwargs_attrs _ska_this)
    cpp_assert_signature("${ARGV}" obj args)

    # Get the map of attributes for this object
    _cpp_object_get_meta_attr("${_ska_this}" _ska_attrs "attrs")

    # Loop over each arg
    foreach(_ska_arg_i ${ARGN})
        # Check if arg is the name of an attribute
        cpp_map(HAS_KEY "${_ska_attrs}" _ska_is_attr_name "${_ska_arg_i}")
        if("${_ska_is_attr_name}")
            # Current arg is an attr name
            if(NOT "${_ska_current_attr}" STREQUAL "")
                # If there is a current attribute being captured, store it
                _cpp_object_set_attr(
                    "${_ska_this}" "${_ska_current_attr}"
                    "${_ska_current_value}"
                )

                # Reset value being captured
                set(_ska_current_value "")
            endif()

            # Update name current attribute being captured
            set(_ska_current_attr "${_ska_arg_i}")
        else()
            # Current arg is a value
            if(NOT "${_ska_current_attr}" STREQUAL "")
                # _ska_current_attr is set so an attr is currently being
                # captured
                if("${_ska_current_value}" STREQUAL "")
                    # No value set, so set it
                    set(_ska_current_value "${_ska_arg_i}")
                else()
                    # Value already set so append to it
                    list(APPEND _ska_current_value "${_ska_arg_i}")
                endif()
            else()
                # _ska_current_attr isn't set, so this should be a attribute
                # name not a value. Throw an error
                message(FATAL_ERROR "Instance has no attribute ${_ska_arg_i}")
            endif()
        endif()
    endforeach()

    # Store value of last attribute being captured
    _cpp_object_set_attr(
        "${_ska_this}" "${_ska_current_attr}"
        "${_ska_current_value}"
    )
endfunction()
