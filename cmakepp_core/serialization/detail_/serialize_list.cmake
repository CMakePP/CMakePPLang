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
include(cmakepp_core/serialization/detail_/serialize_value)

#[[[ Serializes a CMake list into JSON format.
#
# This function will serialize a native CMake list into a JSON list.
# Serialization of the elements of the list will be done recursively.
#
# :param _csl_return: The name for the variable which will hold the result.
# :type _csl_return: desc
# :param _csl_value: The CMake list we are serializing.
# :type _csl_value: list
# :returns: ``_csl_return`` will be set to the JSON serialized form of
#           ``_csl_value``.
# :rtype: desc*
#]]
function(_cpp_serialize_list _csl_return _csl_value)
    cpp_assert_signature("${ARGV}" desc list)

    set(_csl_temp "[")
    set(_csl_not_1st FALSE)
    foreach(_csl_i ${_csl_value})
        if(_csl_not_1st)
            set(_csl_temp "${_csl_temp} ,")
        endif()
        _cpp_serialize_value(_csl_str "${_csl_i}")
        set(_csl_temp "${_csl_temp} ${_csl_str}")
        set(_csl_not_1st TRUE)
    endforeach()
    set("${_csl_return}" "${_csl_temp} ]" PARENT_SCOPE)
endfunction()
