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

include(cmakepp_lang/serialization/detail/serialize_value)

#[[[
# Serializes a CMake list into JSON format.
#
# This function will serialize a native CMake list into a JSON list. This means
# the contents of the list will be enclosed in ``[]`` and the contents of the
# list stored in a comma-separated list whose elements are the serialized
# values.
#
# :param return: The name for the variable which will hold the result.
# :type return: desc
# :param value: The CMake list we are serializing.
# :type value: list
# :returns: ``return`` will be set to the JSON serialized form of
#           ``value``.
# :rtype: desc
#]]
function(_cpp_serialize_list _csl_return _csl_value)

    # Start a temporary buffer to avoid recursion problems
    set(_csl_temp "[")

    # Tracks if this is not the first element (to avoid spurious "," in list)
    set(_csl_not_1st FALSE)

    # Loop over the elements in the list
    foreach(_csl_i ${_csl_value})

        # If not the 1st element need a comma before printing the element
        if(_csl_not_1st)
            set(_csl_temp "${_csl_temp},")
        endif()

        # Serialize the element and add it
        _cpp_serialize_value(_csl_str "${_csl_i}")
        set(_csl_temp "${_csl_temp} ${_csl_str}")

        # Signal that we are past the first element
        set(_csl_not_1st TRUE)
    endforeach()

    # Add the last "]" and return the result
    set("${_csl_return}" "${_csl_temp} ]" PARENT_SCOPE)
endfunction()
