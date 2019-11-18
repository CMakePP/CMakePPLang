include_guard()
include(cmakepp_core/types/detail_/array)
include(cmakepp_core/types/detail_/bool)
include(cmakepp_core/types/detail_/filepath)
include(cmakepp_core/types/detail_/float)
include(cmakepp_core/types/detail_/integer)
include(cmakepp_core/types/detail_/list)
include(cmakepp_core/types/detail_/map)
include(cmakepp_core/types/detail_/target)
include(cmakepp_core/types/detail_/type)

#[[[ Determines the intrinsic type of the provided string.
#
# This function is used to determine the intrinsic type of a valid CMake string.
#
# :param _cgt_result: The name for the variable that will hold the result.
# :type _cgt_result: desc
# :param _cgt_str2identify: The string we want the type of.
# :type _cgt_str2identify: str
# :returns: ``_cgt_result`` will be set to the literal type of
#           ``_cgt_str2identify``.
# :rtype: type*
#
# Example Usage;
# ==============
#
# The following code snippet shows how to determine the type of a string in a
# variable.
#
# .. code-block:: cmake
#
#    include(cmakepp_core/types/get_type)
#    set(my_var 1)
#    cpp_get_type(result "${my_var}")
#    message("The type of 1 is: ${result}")  # Will print "int"
#
#]]
function(cpp_get_type _cgt_result _cgt_str2identify)

    _cpp_is_array("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "array" PARENT_SCOPE)
        return()
    endif()

    _cpp_is_bool("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "bool" PARENT_SCOPE)
        return()
    endif()

    _cpp_is_filepath("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "path" PARENT_SCOPE)
        return()
    endif()

    _cpp_is_float("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "float" PARENT_SCOPE)
        return()
    endif()

    _cpp_is_int("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "int" PARENT_SCOPE)
        return()
    endif()

    _cpp_is_list("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "list" PARENT_SCOPE)
        return()
    endif()

    _cpp_is_map("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "map" PARENT_SCOPE)
        return()
    endif()

    _cpp_is_target("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "target" PARENT_SCOPE)
        return()
    endif()

    _cpp_is_type("${_cgt_result}" "${_cgt_str2identify}")
    if(${${_cgt_result}})
        set("${_cgt_result}" "type" PARENT_SCOPE)
        return()
    endif()

    set("${_cgt_result}" "desc" PARENT_SCOPE)
endfunction()
