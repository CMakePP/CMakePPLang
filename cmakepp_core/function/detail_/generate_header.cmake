include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Wraps the process of generating the header of the wrapper function.
#
# This function generates the static string:
#
# .. code-block:: cmake
#
#    include_guard()
#    include(cmakepp_core/asserts/signature)
#
# which is the header for the wrapper function's implementation file.
#
# :param _cgh_contents: The name for the variable which will hold the result.
# :type _cgh_contents: desc
# :returns: ``_cgh_contents`` will be set to the header for the implementation
#           file.
# :rtype: desc*
#
# .. note::
#
#    This function is not really intended for use outside of the
#    ``_cpp_generate_wrapper`` function and has only been factored out for
#    readability and ease of unit testing.
#
# Error Checking
# ==============
#
# If CMakePP is in debug mode (*i.e.* ``CMAKEPP_CORE_DEBUG_MODE`` is set to a
# true value), then this function will type-check the arguments. An error will
# be raised if ``_cgh_contents`` is not a ``desc`` or if more than one input
# is supplied.
#]]
function(_cpp_generate_header _cgh_contents)
    cpp_assert_signature("${ARGV}" desc)
    set("${_cgh_contents}" "include_guard()\ninclude(cmakepp_core/asserts")
    set("${_cgh_contents}" "${${_cgh_contents}}/signature)\n\n" PARENT_SCOPE)
endfunction()
