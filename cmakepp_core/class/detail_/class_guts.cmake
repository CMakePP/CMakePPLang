include_guard()
include(cmakepp_core/class/detail_/ctor)
include(cmakepp_core/class/detail_/get_class_registry)

#[[[ Implements ``cpp_class``.
#
# Because ``cpp_class`` needs to be a macro for the ``return()`` command to work
# we have factored the guts of ``cpp_class`` into this function. ``_cpp_class``
# is thus able to create temporaries without fear of contaminating the parent
# namespace.
#
# :param _cc_src_file: The name of variable used for the return.
# :type _cc_src_file: desc
# :param _cc_type: The name of the new type we are creating.
# :type _cc_type: desc
# :param *args: The types of the base classes.
# :returns: ``_cc_src_file`` will be set to a false value if ``_cc_type`` does
#           not already exist and will be set to the filepath for the class's
#           implementation if it does already exist.
# :rtype: bool* or path*
#]]
function(_cpp_class_guts _ccg_src_file _ccg_type)
    cpp_assert_signature("${ARGV}" desc desc)
    set("${_ccg_src_file}" FALSE PARENT_SCOPE)
    _cpp_get_class_registry(_ccg_registry)
    cpp_map(HAS_KEY _ccg_exists "${_ccg_registry}" "${_ccg_type}")
    if(_ccg_exists)
        cpp_map(GET _ccg_class "${_ccg_registry}" "${_ccg_type}")
        cpp_map(GET "${_ccg_src_file}" "${_ccg_class}" impl_file)
        cpp_return("${_ccg_src_file}")
    endif()

    _cpp_class_ctor(_ccg_new_class "${_ccg_type}" ${ARGN})

    cpp_map(SET "${_ccg_registry}" "${_ccg_type}" "${_ccg_new_class}")
endfunction()
