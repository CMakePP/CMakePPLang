include_guard()
include(cmakepp_core/algorithm/contains)
include(cmakepp_core/array/array)
include(cmakepp_core/asserts/signature)
include(cmakepp_core/object/detail_/get_state)

#[[[ Encapsulates the process of adding a base class to an object.
#
# This function registers with an Object instance that it is dervied from the
# provided type. Actually merging that type into this object is not the
# responsibility of this function, but rather of ``_cpp_object_merge``.
#
# :param _coab_object: The object which is getting a new base class.
# :type _coab_object: obj
# :param _coab_base: The name of the base class.
# :type _coab_base: desc
#
#]]
function(_cpp_object_add_base _coab_object _coab_base)
    cpp_assert_signature("${ARGV}" obj type)

    cpp_get_global(_coab_bases "${_coab_object}_bases")
    list(APPEND _coab_bases "${_coab_base}")
    list(REMOVE_DUPLICATES _coab_bases)
    cpp_set_global("${_coab_object}_bases" "${_coab_bases}")
endfunction()

