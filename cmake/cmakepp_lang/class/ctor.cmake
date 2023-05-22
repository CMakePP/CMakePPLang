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

include(cmakepp_lang/class/detail/bases)
include(cmakepp_lang/object/object)
include(cmakepp_lang/map/map)
include(cmakepp_lang/types/cmakepp_type)
include(cmakepp_lang/class/find_ctor)
include(cmakepp_lang/class/flatten_attrs)

#[[[
# Handles the construction of a class instance.
#
# This function handles the construction of a new class and calls to the
# constructors for base classes.
#
# :param this: The handle to the object that will be constructed.
# :type this: desc
# :param type: The class we are calling the constructor for.
# :type type: class
# :param \*args: The arguments the constructor was called with (not including
#                the instance name and class).
# :returns: ``this`` will be set to the mangled name of the newly
            constructed instance.
# :rtype: desc
#]]
function(cpp_class_ctor _cc_this _cc_type)
    # Check if _cc_this is already an instance
    cpp_type_of(_cc_this_type "${_cc_this}")
    cpp_implicitly_convertible(_cc_conv_to_obj "${_cc_this_type}" "obj")

    if(_cc_conv_to_obj)
        # _cc_this is an instance of a class. Ensure that it is an instance of
        # a subclass of _cc_type
        cpp_implicitly_convertible(_cc_is_conv "${_cc_this_type}" "${_cc_type}")
        if(NOT "${_cc_is_conv}")
            message(
                FATAL_ERROR
                "Constructor for type ${_cc_type} called from instance of\
                type ${_cc_this_type}. ${_cc_this_type} is\
                not a subclass of ${_cc_type}."
            )
        endif()

        # Get the subobject of _cc_this of type _cc_type
        _cpp_object_get_meta_attr("${_cc_this}" _cc_subobjs "sub_objs")
        cpp_map(GET "${_cc_subobjs}" _cc_subobj "${_cc_type}")

        # Try to find a CTOR function of this instance to call
        _cpp_find_ctor("${_cc_this}" "${_cc_type}" ${ARGN})
    else()
        # If type of _cc_this not object then no instance has been
        # created yet, so create a new instance
        cpp_get_global(_cc_state "${_cc_type}__state")
        _cpp_object_copy("${_cc_state}" "${_cc_this}")

        # Move all attributes from base classes to this classes attributes
        _cpp_flatten_attrs("${${_cc_this}}")

        # Try to find a CTOR function of this instance to call
        _cpp_find_ctor("${${_cc_this}}" "${_cc_type}" ${ARGN})

        # Return the new class instance
        set("${_cc_this}" "${${_cc_this}}" PARENT_SCOPE)
    endif()
endfunction()
