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

include(cmakepp_lang/utilities/global)

#[[[
# Encapsulates the logic for retrieving the base classes of a user-defined
# type.
#
# The type system needs to know which base classes a user-defined class can be
# implicitly converted to. This function encapsulates the logic of retrieving
# that list to avoid a direct coupling to how that list is stored.
#
# .. note::
#
#    This function is used by ``cpp_implicitly_convertible`` and thus is inside
#    the type-checking machinery which can not have its type checked by
#    ``cpp_assert_signature``. Also worth noting this function is currently a
#    macro because all it does is set a variable for the caller, thus we save a
#    call to ``cpp_return``.
#
# :param this: The class instance we are retrieving the bases of.
# :type this: class
# :param bases: An identifier to which the list of base classes will be
#               assigned.
# :param bases: desc
# :returns: ``bases`` will be set to the list of base classes that the
#           user-defined type stored in ``this`` derives from. This is not
#           the list of base classes that the ``Class`` class derives from.
# :rtype: [type]
#
# Error Checking
# ==============
#
# This function will ensure that it has been called with exactly two arguments,
# and if it has not, will raise an error.
#]]
macro(_cpp_class_get_bases _cgb_this _cgb_bases)
    if(NOT "${ARGC}" EQUAL 2)
        message(
          FATAL_ERROR
          "Function takes 2 argument(s), but ${ARGC} was/were provided"
        )
    endif()

    cpp_get_global("${_cgb_bases}" "${_cgb_this}__bases")
endmacro()

#[[[
# Encapsulates the logic for setting the base classes of a user-defined
#    type.
#
# The type system needs to know which base classes a user-defined class can be
# implicitly converted to. This function encapsulates the logic of setting that
# list to avoid a direct coupling to how that list is stored. If the bases for a
# class have already been set this function will overwrite the previous list.
#
# :param this: The class instance we are setting the bases of.
# :type this: class
# :param bases: An identifier containing the list of base classes.
# :param bases: [type]*
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only when it is) this function will
# assert that the caller supplied exactly two arguments and that those arguments
# have the correct types.
#]]
function(_cpp_class_set_bases _csb_this _csb_bases)
    include(cmakepp_lang/asserts/signature)
    cpp_assert_signature("${ARGV}" class desc)

    cpp_set_global("${_csb_this}__bases" "${${_csb_bases}}")
endfunction()
