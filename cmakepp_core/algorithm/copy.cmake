include_guard()
#include(cmakepp_core/asserts/signature)
include(cmakepp_core/map/map)
include(cmakepp_core/object/copy)
include(cmakepp_core/types/type_of)
include(cmakepp_core/utilities/return)

#[[[ Creates a new object which is a deep copy of an already existing object.
#
# :param _cc_result: The name of the variable to return the result in.
# :type _cc_result: desc
# :param _cc_obj2copy: The object we are deep copying
# :type _cc_obj2copy: str
# :returns: ``_cc_result`` will be set to a deep copy of ``_cc_obj2copy``.
# :rtype: str*
#]]
function(cpp_copy _cc_result _cc_obj2copy)
    #cpp_assert_signature("${ARGV}" desc str)
    cpp_type_of(_cc_type "${_cc_obj2copy}")
    cpp_implicitly_convertible(_cc_is_obj "${_cc_type}" "obj")
    if("${_cc_type}" STREQUAL "map")
        cpp_map(COPY "${_cc_obj2copy}" "${_cc_result}")
    elseif(_cc_is_obj)
        _cpp_object_copy("${_cc_obj2copy}" "${_cc_result}")
    else()
        set("${_cc_result}" "${_cc_obj2copy}")
    endif()
    cpp_return("${_cc_result}")
endfunction()
