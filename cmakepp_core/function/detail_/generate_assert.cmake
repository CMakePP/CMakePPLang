include_guard()
include(cmakepp_core/asserts/signature)

#[[[ Generates the assertion for type checking.
#
# The wrapper ultimately needs to call ``cpp_assert_signature`` with the
# forwarded types. This function thus generates a line of CMake code which looks
# like:
#
# .. code-block:: cmake
#
#    cpp_assert_signature("${ARGV}" <type0> <type1> ...)
#
# :param _cga_contents: Name for the variable which will hold the result.
# :type _cga_contents: desc
# :param *args: The types of the positional arguments to the function.
# :returns: ``_cga_contents`` will be set to the assertion required for strong
#           types.
# :rtype: desc*
#
# .. note::
#
#    This function is not intended for use outside of ``_cpp_generate_wrapper``
#    and only exists to increase readability and facilitate unit-testing.
#
# Error Checking
# ==============
#
# If CMakePP is run in debug mode this function will ensure that the first
# input is of type ``desc``.
#]]
function(_cpp_generate_assert _cga_contents)
    cpp_assert_signature("${ARGV}" desc args)

    set("${_cga_contents}" [[cpp_assert_signature("${ARGV}"]])
    foreach(_cga_arg_i ${ARGN})
        set("${_cga_contents}" "${${_cga_contents}} ${_cga_arg_i}")
    endforeach()
    set("${_cga_contents}" "${${_cga_contents}})" PARENT_SCOPE)
endfunction()
