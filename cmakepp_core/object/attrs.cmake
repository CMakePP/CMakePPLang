include_guard()
include(cmakepp_core/map/map)
include(cmakepp_core/object/get_meta_attr)
include(cmakepp_core/utilities/return)

#[[[ Core of the routine which retrieves the attributes.
#
# Attributes need to be searched for using depth-first search. This function
# implements the part of the search which is done recursively for each class of
# the hierarchy associated with this instance's class. This function will work
# regardless of whether or not the object has the requested attribute. If the
# object does not
#
# :param _ogag_this: The instance in which we are looking for the attribute.
# :type _ogag_this: obj
# :param _ogag_value: Identifier for the variable which will hold the value of
#                     the attribute.
# :type _ogag_value: desc
# :param _ogag_done: Identifier which will hold whether or not the recursion is
#                    done.
# :type _ogag_done: desc
# :param _ogag_attr: Name of the attribute we are looking for.
# :type _ogag_attr: desc
# :returns: ``_ogag_value`` will be set to the value of the attribute, if the
#           object has the attribute and the empty string otherwise.
#           ``_ogag_done`` will be set to ``TRUE`` if the object has the
#           attribute and ``FALSE`` otherwise. Hence one can use ``_ogag_done``
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
    foreach(_ogag_type_i ${_ogag_bases})

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

#[[[ Retrieves the value of an object's attribute.
#
# This is the "public" API (for the most part users shouldn't be going through
# the Object API at all) for accessing the attributes of an Object instance.
#
# :param _oga_this: The object whose attribute is being accessed.
# :type _oga_this: obj
# :param _oga_value: Name for the identifier which will hold the value of the
#                    attribute.
# :type _oga_value: desc
# :param _oga_attr: Name of the attribute whose value we want.
# :type _oga_attr: desc
# :returns: ``_oga_value`` will be set to the value of the attribute.
# :rtype: str
#
# Error Checking
# ==============
#
# If CMakePP is being run in debug mode this function will ensure that it was
# called with exactly three arguments and that the arguments have the correct
# type. If any of these assertions fail an error will be raised. These errors
# are only considered if CMakePP is being run in debug mode.
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode or not.
# :vartype CMAKEPP_CORE_DEBUG_MODE: bool
#
# Additionally, this function will always assert that the object possesses the
# requested attribute. If the object does not posses the attribute an error will
# be raised.
#]]
function(_cpp_object_get_attr _oga_this _oga_value _oga_attr)
    cpp_assert_signature("${ARGV}" obj desc desc)

    _cpp_object_get_attr_guts(
        "${_oga_this}" "${_oga_value}" _oga_found "${_oga_attr}"
    )

    if(_oga_found)
        cpp_return("${_oga_value}")
    endif()

    message(FATAL_ERROR "Instance has no attribute ${_oga_attr}")
endfunction()

#[[[ Sets the value of an Object instance's attribute.
#
# This function is the "public" API (generally speaking users of CMakePP should
# not be going through the Object API) for setting an Object's attribute. This
# is the function that is ultimately called by ``cpp_attr`` and by the ``SET``
# member function. If the object already has the specified attribute, this
# function will overwrite its value.
#
# :param _osa_this: The Object instance whose attribute is being set.
# :type _osa_this: obj
# :param _osa_attr: The name of the attribute we are setting.
# :type _osa_attr: desc
# :param _osa_value: The value we are setting the attribute to.
# :type _osa_value: str
#]]
function(_cpp_object_set_attr _osa_this _osa_attr _osa_value)
    cpp_assert_signature("${ARGV}" obj desc str)

    _cpp_object_get_meta_attr("${_osa_this}" _osa_attrs "attrs")
    cpp_map(SET "${_osa_attrs}" "${_osa_attr}" "${_osa_value}")
endfunction()
