include_guard()
include(cmakepp_core/types/bool)
include(cmakepp_core/types/float)
include(cmakepp_core/types/int)
include(cmakepp_core/types/list)
include(cmakepp_core/types/literals)
include(cmakepp_core/types/path)
include(cmakepp_core/types/target)
include(cmakepp_core/types/type)
include(cmakepp_core/utilities/global)

#[[[ Returns the type literal for the provided object.
#
# This function encapsulates the process of determining the type of an object.
# It is capable of determing the type of intrinsic CMake objects (integers,
# booleans, etc.), intrinsic CMakePP objects (Object, Overload, etc.), and
# user-defined classes.
#
# :param _to_result: Name for the variable which will hold the result.
# :type _to_result: desc
# :param _to_obj: The object we want the type of.
# :type _to_obj: str
# :returns: ``_to_result`` will be set to the type literal corresponding to
#           ``_to_obj``'s type.
# :rtype: type*
#]]
function(cpp_type_of _to_result _to_obj)

    # If _to_obj is "" it's a desc (catch it now to avoid corner cases later)
    if("${_to_obj}" STREQUAL "")
        set("${_to_result}" "desc" PARENT_SCOPE)
        return()
    endif()

    # CMakePP-defined and user-defined classes set a meta-parameter "_type", see
    # if that exists
    cpp_get_global("${_to_result}" "${_to_obj}__cpp_type")
    if(NOT "${${_to_result}}" STREQUAL "")
        set("${_to_result}" "${${_to_result}}" PARENT_SCOPE)
        return()
    endif()

    # Try the literal types known to the runtime
    # (only need CMake literals as CMakePP literals would have been caught by
    # using the meta-parameter)
    foreach(_to_type_i ${CMAKE_TYPE_LITERALS})

        if("${_to_type_i}" STREQUAL bool)
            cpp_is_bool(_to_is_type_i "${_to_obj}")
        elseif("${_to_type_i}" STREQUAL float)
            cpp_is_float(_to_is_type_i "${_to_obj}")
        elseif("${_to_type_i}" STREQUAL int)
            cpp_is_int(_to_is_type_i "${_to_obj}")
        elseif("${_to_type_i}" STREQUAL list)
            cpp_is_list(_to_is_type_i "${_to_obj}")
        elseif("${_to_type_i}" STREQUAL path)
            cpp_is_path(_to_is_type_i "${_to_obj}")
        elseif("${_to_type_i}" STREQUAL target)
            cpp_is_target(_to_is_type_i "${_to_obj}")
        elseif("${_to_type_i}" STREQUAL "type")
            cpp_is_type(_to_is_type_i "${_to_obj}")
        else()
            message(FATAL_ERROR "No dispatch for type ${_to_type_i}")
        endif()

        if("${_to_is_type_i}")
            set("${_to_result}" "${_to_type_i}" PARENT_SCOPE)
            return()
        endif()

    endforeach()

    # Only choice left is desc
    set("${_to_result}" desc PARENT_SCOPE)
endfunction()
