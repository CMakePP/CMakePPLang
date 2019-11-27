################################################################################
#                        Copyright 2018 Ryan M. Richard                        #
#       Licensed under the Apache License, Version 2.0 (the "License");        #
#       you may not use this file except in compliance with the License.       #
#                   You may obtain a copy of the License at                    #
#                                                                              #
#                  http://www.apache.org/licenses/LICENSE-2.0                  #
#                                                                              #
#     Unless required by applicable law or agreed to in writing, software      #
#      distributed under the License is distributed on an "AS IS" BASIS,       #
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
#     See the License for the specific language governing permissions and      #
#                        limitations under the License.                        #
################################################################################

include_guard()
include(cmakepp_core/asserts/signature)
include(cmakepp_core/serialization/detail_/serialize_array)
include(cmakepp_core/serialization/detail_/serialize_string)
include(cmakepp_core/serialization/detail_/serialize_list)
include(cmakepp_core/serialization/detail_/serialize_map)
include(cmakepp_core/serialization/detail_/serialize_obj)
include(cmakepp_core/types/get_type)
include(cmakepp_core/utilities/return)

#[[[ Dispatches based on type to the appropiate serialization impelementation.
#
# This function is used to encapsulate the logic required to dispatch to the
# correct serialization implemenation based on the type of the input value.
#
# :param _csv_return: The name for the variable which will hold the result.
# :type _csv_return: desc
# :param _csv_value: The value we are serializing.
# :type _csv_value: str
# :returns: ``_csv_return`` will be set to the JSON serialized form of
#           ``_csv_value``.
# :rtype: desc*
#]]
function(_cpp_serialize_value _csv_return _csv_value)
    cpp_assert_signature("${ARGV}" desc str)
    cpp_get_type(_csv_type "${_csv_value}")
    if("${_csv_type}" STREQUAL "array")
        _cpp_serialize_array("${_csv_return}" "${_csv_value}")
    elseif("${_csv_type}" STREQUAL "list")
        _cpp_serialize_list("${_csv_return}" "${_csv_value}")
    elseif("${_csv_type}" STREQUAL "map")
        _cpp_serialize_map("${_csv_return}" "${_csv_value}")
    elseif("${_csv_type}" STREQUAL "obj")
        _cpp_serialize_obj("${_csv_return}" "${_csv_value}")
    else()
        _cpp_serialize_string("${_csv_return}" "${_csv_value}")
    endif()
    cpp_return("${_csv_return}")
endfunction()

