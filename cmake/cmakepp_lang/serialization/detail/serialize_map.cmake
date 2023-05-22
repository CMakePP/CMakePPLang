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

include(cmakepp_lang/map/map)
include(cmakepp_lang/serialization/detail/serialize_value)

#[[[
# Serializes a map using JSON serialization.
#
# This function encapsulates the algorithm required to serialize a CMakePP map
# into JSON. In JSON a map is a container whose contents are enclosed in "{}".
# The contents of the map are expressed as a comma-separated list whose elements
# are the key-value pairs in the form ``<key> : <value>`` where ``<key>`` and
# ``<value>`` are respectively the JSON serialized forms of the key and the
# value.
#
# :param return: Name to use for the variable which will hold the result.
# :type return: desc
# :param value: The map we are serializing.
# :type value: map
# :returns: ``return`` will be set to the JSON serialized form of
#           ``value``.
# :rtype: desc
#
# Error Checking
# ==============
#
# This routine is considered an implementation detail of ``cpp_serialize`` and
# is not error checked.
#]]
function(_cpp_serialize_map _sm_return _sm_value)

    # Use a temporary buffer to avoid recursion overwriting the buffer.
    set(_sm_temp "{")

    # Get the keys, number of keys, and start a counter to avoid a trailing ","
    cpp_map(KEYS "${_sm_value}" _sm_keys)
    list(LENGTH _sm_keys _sm_n_keys)
    set(_sm_counter 0)

    # Loop over the keys
    foreach(_sm_key_i ${_sm_keys})

        # Get the value associated with key
        cpp_map(GET "${_sm_value}" _sm_value_i "${_sm_key_i}")

        # Serialize BOTH the key and the value
        _cpp_serialize_value(_sm_serial_key "${_sm_key_i}")
        _cpp_serialize_value(_sm_serial_value "${_sm_value_i}")

        # Add the serialized values to the buffer
        string(APPEND _sm_temp " ${_sm_serial_key} : ${_sm_serial_value}")

        # Update counter and print a comma so long as this isn't the last pair
        math(EXPR _sm_counter "${_sm_counter} + 1")
        if("${_sm_counter}" LESS "${_sm_n_keys}")
            string(APPEND _sm_temp ",")
        endif()
    endforeach()

    # Add the closing "}" and return
    string(APPEND _sm_temp " }")
    set("${_sm_return}" "${_sm_temp}" PARENT_SCOPE)
endfunction()
