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

include(cmakepp_lang/asserts/signature)
include(cmakepp_lang/object/object)
include(cmakepp_lang/utilities/return)

#[[[
# Returns a new default constructed Object instance.
#
# This function creates a new default constructed Object instance. This instance
# is only an Object instance (contrast this with derived class instances created
# using ``_cpp_object_ctor``). All instances of the Object class have identical
# state and thus for efficiency reasons it makes sense to have a single Object
# instance that all derived class instances alias.
#
# :param this: Name for the variable which will hold the new instance.
# :type this: desc
# :returns: ``this`` will be set to the newly created Object instance.
# :rtype: obj
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# .. note::
#
#    This command is a macro so that the member function definitions permeate
#    into the caller's scope.
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode (and only if CMakePP is run in debug mode)
# this function will ensure that it was called with exactly one argument and
# that the one argument is of type ``desc``. If either of these asserts fails an
# error will be raised.
#]]
macro(_cpp_object_singleton _os_this)
    cpp_assert_signature("${ARGV}" desc)

    # Create the object singleton using the default CTOR
    _cpp_object_ctor("${_os_this}" "obj")

    # Add the default CTOR, equal, and serialize functions to object
    _cpp_object_add_fxn("${${_os_this}}" ctor desc)
    function("${ctor}" __oc_this)
        # Do nothing
    endfunction()

    _cpp_object_add_fxn("${${_os_this}}" equal obj desc obj)
    function("${equal}" __oe_this __oe_result __oe_other)
        _cpp_object_equal("${__oe_this}" "${__oe_result}" "${__oe_other}")
        cpp_return("${__oe_result}")
    endfunction()

    _cpp_object_add_fxn("${${_os_this}}" serialize obj desc)
    function("${serialize}" __os_this __os_result)
        _cpp_object_serialize("${__os_this}" "${__os_result}")
        cpp_return("${__os_result}")
    endfunction()
endmacro()
