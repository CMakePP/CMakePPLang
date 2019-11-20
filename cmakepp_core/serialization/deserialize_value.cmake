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
include(serialization/deserialize_string)
include(serialization/deserialize_list)
include(serialization/deserialize_object)
include(serialization/json_error)
include(object/is_object)
include(string/cpp_string_pop)
include(utility/set_return)

## Dispatches to the appropriate deserialization function
#
# Deserializing JSON is considerably harder than serializing to it. If we think
# of the JSON file as a stream/buffer, then this function pulls the first
# character out of it and dispatches based on that character. The dispatched
# functions will read their respective type out of the buffer and return to this
# function the modified buffer as well as the CMake object. This function then
# returns the CMake object and the modified buffer.
#
# :param return: An identifier whose value will be set to the CMake object
#                corresponding to the next value in the JSON buffer
# :param buffer: An identifier to the JSON remaining to be parsed. The buffer
#                will be modified by this function.
function(_cpp_deserialize_value _cdv_return _cdv_buffer)
    set(_cdv_value "${${_cdv_buffer}}")
    string(STRIP "${_cdv_value}" _cdv_value)

    #Handle value being the empty string or all whitespace
    _cpp_is_empty(_cdv_empty _cdv_value)
    if(_cdv_empty)
        _cpp_set_return(${_cdv_return} "")
        return()
    endif()

   #Dispatch based on first character
   _cpp_string_pop(_cdv_1st_char _cdv_value)
   _cpp_are_equal(_cdv_is_lbrace "${_cdv_1st_char}" "{")
   _cpp_are_equal(_cdv_is_lbracket "${_cdv_1st_char}" "[")
   _cpp_are_equal(_cdv_is_quote "${_cdv_1st_char}" "\"")
   if(_cdv_is_lbrace)
       _cpp_deserialize_object(_cdv_rv _cdv_value)
   elseif(_cdv_is_lbracket)
       _cpp_deserialize_list(_cdv_rv _cdv_value)
   elseif(_cdv_is_quote)
       _cpp_deserialize_string(_cdv_rv _cdv_value)
   else()
       _cpp_json_error("${_cdv_buffer}")
   endif()
   _cpp_set_return(${_cdv_return} "${_cdv_rv}")
   _cpp_set_return(${_cdv_buffer} "${_cdv_value}")
endfunction()
