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

#[[[ @module
# Defines functions to manipulate the attributes on a CMakePPLang Object.
#]]

include_guard()

include(cmakepp_lang/map/map)
include(cmakepp_lang/object/get_meta_attr)
include(cmakepp_lang/utilities/return)

#[[[
# Core of the routine which retrieves the attributes.
#
# Attributes need to be searched for using depth-first search. This function
# implements the part of the search which is done recursively for each class of
# the hierarchy associated with this instance's class. This function will work
# regardless of whether or not the object has the requested attribute. If the
# object does not
#
# :param this: The instance in which we are looking for the attribute.
# :type this: obj
# :param value: Identifier for the variable which will hold the value of
#               the attribute.
# :type value: desc
# :param done: Identifier which will hold whether or not the recursion is
#              done.
# :type done: desc
# :param attr: Name of the attribute we are looking for.
# :type attr: desc
# :returns: ``value`` will be set to the value of the attribute, if the
#           object has the attribute and the empty string otherwise.
#           ``done`` will be set to ``TRUE`` if the object has the
#           attribute and ``FALSE`` otherwise. Hence one can use ``done``
#           to determine if the attribute does not exist, or if it was just set
#           to an empty string.
# :rtype: (str, bool)
#
# .. note::
#
#    This function is considered an implementation detail and performs no error
#    checking on its own.
#]]
function(_cpp_object_get_attr_guts _ogag_this _ogag_value _ogag_done _ogag_attr)
    #attr could be anything so use str instead of desc
    cpp_assert_signature("${ARGV}" obj desc desc str)

    # Get the list of attributes and determine if the target attr is in it.
    _cpp_object_get_meta_attr("${_ogag_this}" _ogag_attrs "attrs")
    cpp_map(HAS_KEY "${_ogag_attrs}" _ogag_has_key "${_ogag_attr}")
    if(_ogag_has_key)

        # The attribute is present, get its value and return
        cpp_map(GET "${_ogag_attrs}" "${_ogag_value}" "${_ogag_attr}")
        set("${_ogag_done}" TRUE PARENT_SCOPE)
        cpp_return("${_ogag_value}")
    endif()

    # This part of the object did not have the attribute, so loop over bases
    _cpp_object_get_meta_attr("${_ogag_this}" _ogag_sub_objs "sub_objs")
    cpp_map(KEYS "${_ogag_sub_objs}" _ogag_bases)
    foreach(_ogag_type_i IN LISTS _ogag_bases)

        # Get the i-th base class and see if it has the attribute
        cpp_map(GET "${_ogag_sub_objs}" _ogag_base_i "${_ogag_type_i}")
        _cpp_object_get_attr_guts(
           "${_ogag_base_i}" "${_ogag_value}" _ogag_found "${_ogag_attr}"
        )

        #If it had the attribute return the value and signal end of recursion
        if(_ogag_found)
            set("${_ogag_done}" TRUE PARENT_SCOPE)
            cpp_return("${_ogag_value}")
        endif()
    endforeach()

    # Getting here means the attribute is no where in this object
    set("${_ogag_value}" "" PARENT_SCOPE)
    set("${_ogag_done}" FALSE PARENT_SCOPE)
endfunction()

#[[[
# Retrieves the value of an object's attribute.
#
# This is the "public" API (for the most part users shouldn't be going through
# the Object API at all) for accessing the attributes of an Object instance.
# This function can get one attribute or multiple depending on the signature
# of the call.
#
# Single Attribute GET Signature:
#
# .. code-block:: cmake
#
#    _cpp_object_get_attr(this value attribute)
#
# Here "this" is the object to retrieve the attribute from, "value" is the
# handle where the attribute is to be returned to the parent scope, and
# "attribute" is the name of the attribute to be retrieved.
#
# Multiple Attribute GET Signature:
# 
# .. code-block:: cmake
# 
#    _cpp_object_get_attr(this prefix attrs)
#
# Here is the object to retrieve the attributes from, prefix will be prepended
# to the each attributes name and used as the handle where that attribute is
# returned to the parent scope, and attributes is the list of attributes to
# retrieve.
#
# :param this: The object whose attribute is being accessed.
# :type this: obj
#
# :var CMAKEPP_LANG_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_LANG_DEBUG_MODE: bool
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will ensure that it was
# called with exactly three arguments and that the arguments have the correct
# type. If any of these assertions fail an error will be raised. These errors
# are only considered if CMakePP is being run in debug mode.
#
# Additionally, this function will always assert that the object possesses the
# requested attribute. If the object does not posses the attribute an error will
# be raised.
#]]
function(_cpp_object_get_attr _oga_this)
    cpp_assert_signature("${ARGV}" obj args)

    # Check arg types to determine type of call
    if(${ARGC} GREATER 3)
        # If more than 3 args, then multiple attributes and a prefix were passed
        # in, so get the prefix and list of attrs to get
        set(_oga_prefix "${ARGV1}")
        list(SUBLIST ARGN 1 -1 _oga_attrs)

        # Loop over all attributes
        foreach(_oga_attr ${_oga_attrs})
            # Attempt to find the attribute
            _cpp_object_get_attr_guts(
                "${_oga_this}" _oga_value _oga_found "${_oga_attr}"
            )

            if(_oga_found)
                # Return the variable using the prefix if it is found
                set("${_oga_prefix}_${_oga_attr}" "${_oga_value}" PARENT_SCOPE)
            else()
                # Otherwise throw an error
                message(FATAL_ERROR "Instance has no attribute ${_oga_attr}")
            endif()
        endforeach()
    else()
        # If only 2 args, then an attribute an result identifier were passed in
        # Get the attr and value handle that will contain the result
        set(_oga_value "${ARGV1}")
        set(_oga_attr "${ARGV2}")

        # Attempt to find the attr
        _cpp_object_get_attr_guts(
            "${_oga_this}" "${_oga_value}" _oga_found "${_oga_attr}"
        )

        # If it is found, return it
        if(_oga_found)
            cpp_return("${_oga_value}")
        endif()

        # Throw an error if is not found
        message(FATAL_ERROR "Instance has no attribute ${_oga_attr}")
    endif()
endfunction()

#[[[
# Sets the value of an Object instance's attribute.
#
# This function is the "public" API (generally speaking users of CMakePP should
# not be going through the Object API) for setting an Object's attribute. This
# is the function that is ultimately called by ``cpp_attr`` and by the ``SET``
# member function. If the object already has the specified attribute, this
# function will overwrite its value.
#
# :param this: The Object instance whose attribute is being set.
# :type this: obj
# :param attr: The name of the attribute we are setting.
# :type attr: desc
# :param \*args: The value or values the attribute will be set as.
#]]
function(_cpp_object_set_attr _osa_this _osa_attr)
    cpp_assert_signature("${ARGV}" obj desc args)
    _cpp_object_get_meta_attr("${_osa_this}" _osa_attrs "attrs")
    cpp_map(SET "${_osa_attrs}" "${_osa_attr}" "${ARGN}")
endfunction()
