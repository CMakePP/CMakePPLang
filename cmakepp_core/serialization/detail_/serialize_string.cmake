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

#[[[ Serializes a string according to the JSON standard.
#
# This is the catch-all serialization for CMakePP types:
#
# - bool
# - filepath
# - float
# - integer
# - type
#
# All of the aforementioned types are serialized as JSON strings.
#
# :param _css_return: Name for the variable which will hold the returned value.
# :type _css_return: desc
# :param _css_value: The value we are serializing.
# :type _css_value: str
# :returns: ``_css_return`` will be set to JSON serialized form of
#           ``_css_value``.
# :rtype: desc*
#
# .. note::
#
#    This function is an implementation detail for the ``cpp_serialize``
#    function and does not perform any error-checking beyond type-checking. In
#    particular this means it does **not** ensure that ``_css_value`` is a
#    CMakePP type which should be serialized as a string.
#]]
function(_cpp_serialize_string _css_return _css_value)
    cpp_assert_signature("${ARGV}" desc str)
    set("${_css_return}" "\"${_css_value}\"" PARENT_SCOPE)
endfunction()
