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
include(serialization/deserialize_value)
include(object/object)
include(string/cpp_string_pop)
include(string/cpp_string_peek)
include(utility/set_return)

## Deserializes a JSON Object into a CMake list
#
#
# :param return: An identifier to hold the returned object
# :param buffer: The buffer to read the JSON from
function(_cpp_deserialize_object _cdo_return _cdo_buffer)
    set(_cdo_value "${${_cdo_buffer}}")
    _cpp_Object_ctor(_cdo_rv)
    while(TRUE)
        string(STRIP "${_cdo_value}" _cdo_value)

        #If string empties we never found the closing }
        _cpp_is_empty(_cdo_is_empty _cdo_value)
        if(_cdo_is_empty)
            _cpp_json_error("${_cdo_buffer}")
        endif()

        #The buffer is pointing at the key or the closing }
        _cpp_string_peek(_cdo_1st_char _cdo_value)
        _cpp_are_equal(_cpp_is_quote "${_cdo_1st_char}" "\"")
        _cpp_are_equal(_cpp_is_rbrace "${_cdo_1st_char}" "}")
        if(_cpp_is_quote)
            _cpp_deserialize_value(_cdo_key _cdo_value)
        elseif(_cpp_is_rbrace)
            _cpp_set_return(${_cdo_return} "${_cdo_rv}" PARENT_SCOPE)
            _cpp_string_pop(_cdo_1st_char _cdo_value)
            _cpp_set_return(${_cdo_buffer} "${_cdo_value}")
            return()
        else()
            _cpp_json_error("${_cdo_buffer}")
        endif()
        _cpp_Object_add_members(${_cdo_rv} "${_cdo_key}")

        string(STRIP "${_cdo_value}" _cdo_value)

        #Now the buffer is pointing at the colon consume it
        _cpp_string_pop(_cdo_1st_char _cdo_value)
        _cpp_are_not_equal(_cdo_not_colon "${_cdo_1st_char}" ":")
        if(_cdo_not_colon)
            _cpp_json_error("${_cdo_buffer}")
        endif()

        #Deserialize the value
        _cpp_deserialize_value(_cdo_item _cdo_value)
        _cpp_Object_set_value(${_cdo_rv} "${_cdo_key}" "${_cdo_item}")

        #If there's more members then the next character is a comma, remove it
        string(STRIP "${_cdo_value}" _cdo_value)
        _cpp_string_peek(_cdo_1st_char _cdo_value)
        _cpp_are_equal(_cdo_is_comma "${_cdo_1st_char}" ",")
        if(_cdo_is_comma)
            _cpp_string_pop(_cdo_1st_char _cdo_value)
        endif()
    endwhile()
endfunction()
