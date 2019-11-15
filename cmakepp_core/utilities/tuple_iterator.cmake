include_guard()
include(cmakepp_core/asserts/divisible)
include(cmakepp_core/asserts/greater_than_equal)
include(cmakepp_core/asserts/type)
include(cmakepp_core/utilities/return)

#[[[ Computes the number of m-tuples in a list of n items.
#
# :param _ctis_result: The name to use to hold the result.
# :type _ctis_result: desc
# :param _ctis_n: The length of the list we are taking tuples from. Must be a
#                 multiple of ``_ctis_m``.
# :type _ctis_n: int
# :param _ctis_m: The size of the tuples we are taking from the list. Must be a
#                 divisor of ``_ctis_n``.
# :type _ctis_n: int
# :returns: The length of the range that should be looped over. This takes into
#           account the fact that foreach is inclusive. The result is returned
#           via ``_ctis_result``.
# :rtype: int*
#]]
function(cpp_tuple_iterator_size _ctis_result _ctis_n _ctis_m)
    cpp_assert_type(desc "${_ctis_result}" int "${_ctis_n}" int "${_ctis_m}")
    cpp_assert_greater_than_equal("${_ctis_n}" "${_ctis_m}")
    cpp_assert_divisible("${_ctis_n}" "${_ctis_m}")

    if(${_ctis_m} EQUAL 0)
        set(${_ctis_result} -1)
        cpp_return(${_ctis_result})
    endif()

    # Foreach is inclusive despite starting at 0...
    math(EXPR "${_ctis_result}" "(${_ctis_n} / ${_ctis_m}) - 1")
    cpp_return("${_ctis_result}")
endfunction()

#[[[ Retrieves the i-th n-tuple from a list.
#
# :param _cti_i: Which tuple to retrieve from the list.
# :type _cti_i: int
# :param _cti_n:
#]]
function(cpp_tuple_iterator _cti_i _cti_n)
    math(EXPR _cti_min_elems "2 + (${_cti_i} + 2)*${_cti_n}")
    if(${ARGC} LESS ${_cti_min_elems})
        message(
            FATAL_ERROR
            "cpp_tuple_iterator with i == ${_cti_i} and n == ${_cti_n} requires"
            "${_cti_min_elems} positional arguments minimally, but got ${ARGC}."
            "Args: ${ARGV}"
        )
    endif()

    # Foreach is inclusive despite starting at 0...
    math(EXPR _citi_done "${_cti_n} - 1")

    # Each iteration gets the j-th element of our tuple
    foreach(_cti_j RANGE ${_citi_done})
        # First 2 arguments are i and n
        math(EXPR _cti_i_offset "2 + ${_cti_j}")
        # There are 2 + (i+1)*n arguments before the n-tuple we want
        math(EXPR _cti_v_offset "2 + (${_cti_i} + 1)*${_cti_n} + ${_cti_j}")

        set("${ARGV${_cti_i_offset}}" "${ARGV${_cti_v_offset}}" PARENT_SCOPE)
    endforeach()
endfunction()
