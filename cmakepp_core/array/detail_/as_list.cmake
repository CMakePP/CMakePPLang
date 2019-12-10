include_guard()
include(cmakepp_core/array/detail_/end)
include(cmakepp_core/array/detail_/get)
include(cmakepp_core/asserts/signature)

#[[[ Turns a CMakePP array into a CMake list.
#
# CMakePP arrays are nice to work with, but sometimes (particularly when
# interfacing with native CMake code) we need a native CMake list. This function
# wraps the process of converting a (possibly nested) CMakePP array into a
# (possibly nested) CMake list.
#
# :param _caal_result: Name for the variable which will hold the result.
# :type _caal_result: desc
# :param _caal_array: The array we want as a CMake list.
# :type _caal_array: array
# :returns: ``_caal_result`` will be set to a CMake list, which is a deep copy
#           of ``_caal_array``. In particular this means that if ``_caal_array``
#           was a nested array, the resulting list is a nested list and does not
#           alias the nested arrays.
# :rtype: list*
#
# Error Checking
# ==============
#
# :var CMAKEPP_CORE_DEBUG_MODE: Used to determine if CMakePP is being run in
#                               debug mode.
#
# If CMakePP is run in debug mode this function will ensure that all arguments
# have the correct types. This  error check is only performed if CMakePP is run
# in debug mode.
#]]
function(_cpp_array_as_list _caal_result _caal_array)
    cpp_assert_signature("${ARGV}" desc array)

    # Store results in a temporary, not _caal_result, because of recursion
    set(_caal_temp_result)

    # Loop over elements, appending to _caal_temp_result
    _cpp_array_end(_caal_end "${_caal_array}")
    foreach(_caal_i RANGE "${_caal_end}")

        _cpp_array_get(_caal_elem_i "${_caal_array}" "${_caal_i}")

        # Handle nestings (shudder)
        cpp_get_type(_caal_type "${_caal_elem_i}")
        if("${_caal_type}" STREQUAL array)
            _cpp_array_as_list(_caal_temp "${_caal_elem_i}")
            string(REGEX REPLACE ";" "\\\;" _caal_elem_i "${_caal_temp}")
        endif()

        list(APPEND _caal_temp_result "${_caal_elem_i}")
    endforeach()

    set("${_caal_result}" "${_caal_temp_result}" PARENT_SCOPE)
endfunction()
