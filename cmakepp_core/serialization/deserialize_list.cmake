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
include(serialization/deserialize_value)
include(serialization/json_error)
include(string/cpp_string_pop)
include(string/cpp_string_peek)
include(utility/set_return)

## Deserializes a JSON list into a CMake list
#
#
# :param return: An identifier to hold the returned list
function(_cpp_deserialize_list _cdl_return _cdl_buffer)
    set(_cdl_rv "")
    set(_cdl_value "${${_cdl_buffer}}")
    while(TRUE)
        string(STRIP "${_cdl_value}" _cdl_value)

        #Sanity check to avoid going on forever
        _cpp_is_empty(_cdl_empty _cdl_value)
        if(_cdl_empty)
            _cpp_json_error("${_cdl_buffer}")
        endif()

        #Grab the first character (strip removed whitespace)
        _cpp_string_peek(_cdl_1st_char _cdl_value)

        #There's 5 valid possible characters: {, [, ", ] or comma
        #If we find ], we're done, if we find comma there's another element,
        #the other three (as well as any invalid character) will be handled by
        #deserialize_value
        if("${_cdl_1st_char}" STREQUAL "]") #End of our list, return values
            set(${_cdl_return} "${_cdl_rv}" PARENT_SCOPE)
            _cpp_string_pop(_cdl_1st_char _cdl_value)
            _cpp_set_return(${_cdl_buffer} "${_cdl_value}")
            return()
        elseif("${_cdl_1st_char}" STREQUAL "," ) #Remove the comma
            _cpp_string_pop(_cdl_1st_char _cdl_value)
        endif()
        _cpp_deserialize_value(_cdl_item _cdl_value)

        #Now the fun part, because this is a CMake list, any nested lists in the
        #return need escapes added. I think it suffices to escape every escape
        #character and to add an escape to bare semicolons
        string(REGEX REPLACE "\\\\" "\\\\\\\\" _cdl_item "${_cdl_item}")
        string(REGEX REPLACE ";" "\\\;" _cdl_item "${_cdl_item}")
        list(APPEND _cdl_rv "${_cdl_item}")
    endwhile()
endfunction()
