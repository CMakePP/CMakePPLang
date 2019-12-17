include_guard()
include(cmakepp_core/object/attributes)
include(cmakepp_core/utilities/global)
include(cmakepp_core/utilities/return)
include(cmakepp_core/utilities/unique_id)

#[[[ Creates a CMakePP Object instance.
#
# This function creates a default initialized CMakePP Object instance. The
# resulting instance has no attributes (aside from its type, which is "obj")
# and no member functions.
#
# :param _coc_result: Name to use for variable which will hold the result.
# :type _coc_result: desc
# :returns: ``_coc_result`` will be set to the resulting instance.
# :rtype: obj*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is in debug mode.
#
# If CMakePP is in debug mode this function will ensure that only one argument
# has been provided to it and that the argument is of the correct type. This
# error check is only done if CMakePP is in debug mode.
#]]
function(cpp_object_ctor _oc_this)

    string(TOLOWER "${_oc_type}" _oc_type)


    cpp_unique_id("${_oc_this}")

    # Technically _oc_attrs is an attribute too, but including it leads to
    # infinite recursion in most algorithms which loop over attributes.
    set(_oc_attrs _cpp_bases _cpp_type)

    cpp_object_set_attrs("${${_oc_this}}" "${_oc_attrs}")
    cpp_object_set_attr("${${_oc_this}}" "_cpp_bases" "obj")
    cpp_object_set_attr("${${_oc_this}}" "_cpp_type" "obj")
    cpp_return("${_oc_this}")
endfunction()
