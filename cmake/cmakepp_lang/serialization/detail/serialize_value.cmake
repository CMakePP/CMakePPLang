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

include(cmakepp_lang/object/object)
include(cmakepp_lang/serialization/detail/serialize_list)
include(cmakepp_lang/serialization/detail/serialize_map)
include(cmakepp_lang/serialization/detail/serialize_string)
include(cmakepp_lang/types/implicitly_convertible)
include(cmakepp_lang/types/type_of)
include(cmakepp_lang/utilities/return)

#[[[
# Dispatches based on type to the appropriate serialization implementation.
#
# This function is used to encapsulate the logic required to dispatch to the
# correct serialization implementation based on the type of the input value.
#
# :param return: The name for the variable which will hold the result.
# :type return: desc
# :param value: The value we are serializing.
# :type value: str
# :returns: ``return`` will be set to the JSON serialized form of
#           ``value``.
# :rtype: desc
#
# Error Checking
# ==============
#
# This function is considered an implementation detail of ``cpp_serialize`` and
# performs no error-checking.
#]]
function(_cpp_serialize_value _sv_return _sv_value)

    # Get the type of the object we are serializing
    cpp_type_of(_sv_type "${_sv_value}")

    # Special dispatch if the object is a list or a map
    if("${_sv_type}" STREQUAL "list")
        _cpp_serialize_list("${_sv_return}" "${_sv_value}")
        cpp_return("${_sv_return}")
    elseif("${_sv_type}" STREQUAL "map")
        _cpp_serialize_map("${_sv_return}" "${_sv_value}")
        cpp_return("${_sv_return}")
    endif()

    # If the object is a literal object call its serialize member function
    cpp_implicitly_convertible(_sv_is_obj "${_sv_type}" "obj")
    if("${_sv_is_obj}")
        _cpp_object(SERIALIZE "${_sv_value}" "${_sv_return}")
        cpp_return("${_sv_return}")
    endif()

    # If none of the above it's just a string-like thing
    _cpp_serialize_string("${_sv_return}" "${_sv_value}")
    cpp_return("${_sv_return}")
endfunction()

