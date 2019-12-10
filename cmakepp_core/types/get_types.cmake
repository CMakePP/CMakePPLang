include_guard()
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/types/get_type)
include(cmakepp_core/utilities/return)

#[[[ Determines the type of a series of objects.
#
# ``cpp_get_types`` is more-or-less the same function as ``cpp_get_type`` except
# that it accepts a variadic number of inputs to type and returns an array of
# the types.
#
# :param _cgt_result: Name for the variable which will hold the result.
# :type _cgt_result: desc
# :param *args: The objects we want the types of.
# :returns: ``_cgt_result`` will be set to an array containing the types of the
#           objects provided via ``*args``.
# :rtype: array*
#
# Error Checking
# ==============
#
# :var  CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                                debug mode or not.
#
# If CMakePP is run in debug mode this function will ensure that arguments have
# the correct types. This error check is only performed in debug mode.
#]]
function(cpp_get_types _cgt_result)
    cpp_assert_signature("${ARGV}" desc args)

    cpp_array(CTOR "${_cgt_result}")
    foreach(_cgt_arg_i ${ARGN})
        cpp_get_type(_cgt_type_i "${_cgt_arg_i}")
        cpp_array(APPEND "${${_cgt_result}}" "${_cgt_type_i}")
    endforeach()

    cpp_return("${_cgt_result}")
endfunction()
