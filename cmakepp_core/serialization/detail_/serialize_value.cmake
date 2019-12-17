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
include(cmakepp_core/serialization/detail_/serialize_list)
include(cmakepp_core/serialization/detail_/serialize_string)
include(cmakepp_core/types/implicitly_convertible)
include(cmakepp_core/types/type_of)
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
function(_cpp_serialize_value _sv_return _sv_value)
    #cpp_assert_signature("${ARGV}" desc str)

    cpp_type_of(_sv_type "${_sv_value}")
    cpp_implicitly_convertible(_sv_is_list "${_sv_type}" "list")
    if("${_sv_is_list}")
        _cpp_serialize_list("${_sv_return}" "${_sv_value}")
        cpp_return("${_sv_return}")
    endif()

    cpp_implicitly_convertible(_sv_is_obj "${_sv_type}" "obj")
    if("${_sv_is_obj}")
        cpp_object(SERIALIZE "${_sv_value}" "${_sv_return}")
        cpp_return("${_sv_return}")
    endif()

    _cpp_serialize_string("${_sv_return}" "${_sv_value}")
    cpp_return("${_sv_return}")
endfunction()

