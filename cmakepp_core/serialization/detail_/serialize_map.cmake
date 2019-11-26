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
include(cmakepp_core/map/map)

#[[[ Serializes a CMakePP map object.
#
# This function serializes a CMakePP object into JSON format. The keys of the
# map are assumed to be strings (in the JSON sense). The elements will be
# further serialized by calling ``_cpp_serialize_value`` (likely recursively).
#
# :param _csm_return: The name to use for the variable holding the return.
# :type _csm_return: desc
# :param _csm_handle: The map instance we are serializing.
# :type _csm_handle: map
# :returns: ``_csm_return`` will be set to the JSON serialized form of
#           ``_csm_handle``.
#]]
function(_cpp_serialize_map _csm_return _csm_handle)
    cpp_assert_signature("${ARGV}" desc map)
    set(_csm_temp "{")
    set(_csm_not_1st FALSE)
    cpp_map(KEYS _csm_keys "${_csm_handle}")
    foreach(_csm_i ${_csm_keys})
        if(_csm_not_1st)
            set(_csm_temp "${_csm_temp} ,")
        endif()
        cpp_map(GET _csm_value "${_csm_handle}" "${_csm_i}")
        _cpp_serialize_value(_csm_serial_key "${_csm_i}")
        _cpp_serialize_value(_csm_serial_value "${_csm_value}")
        set(_csm_temp "${_csm_temp} ${_csm_serial_key} : ${_csm_serial_value}")
        set(_csm_not_1st TRUE)
    endforeach()
    set("${_csm_return}" "${_csm_temp} }" PARENT_SCOPE) # Adds ending "}"
endfunction()
