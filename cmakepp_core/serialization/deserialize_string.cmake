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
include(serialization/json_error)
include(utility/set_return)

## Deserializes a string according to the JSON standard.
#
# This function takes the buffer and strips off all characters until the closing
# ``"`` is found. The stripped off characters are put into a CMake string, which
# is then returned along with the modified buffer.
#
# :param return: An identifier to hold the deserialized string.
# :param buffer: The JSON remaining to be deserialized.
function(_cpp_deserialize_string _cds_return _cds_buffer)
    set(_cds_value "${${_cds_buffer}}")
    #WARNING do not strip the whitespace off, it's part of the string

    #Find the closing double quote and set the return
    string(FIND "${_cds_value}" "\"" _cds_end)
    if("${_cds_end}" STREQUAL "-1")
        _cpp_json_error("${_cds_buffer}")
    endif()
    string(SUBSTRING "${_cds_value}" 0 ${_cds_end} _cds_rv)
    set(${_cds_return} "${_cds_rv}" PARENT_SCOPE)

    #Advance and return the buffer
    math(EXPR _cds_endp1 "${_cds_end} + 1")
    string(SUBSTRING "${_cds_value}" ${_cds_endp1} -1 _cds_value)
    _cpp_set_return(${_cds_buffer} "${_cds_value}")
endfunction()
