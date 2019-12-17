include_guard()
include(cmakepp_core/types/type_of)
include(cmakepp_core/utilities/global)

#[[[ Determines if an object of a given type can be passed as a different type.
#
# CMakePP is a strongly-typed language with minimal implicit conversions. All of
# the allowed implicit conversions are encapsulated by this function.
#
# :param _ic_result: Name to use for the variable which will hold the result.
#]]
function(cpp_implicitly_convertible _ic_result _ic_from _ic_to)

    # Make the to-type lowercase in order to avoid case-sensitivity
    string(TOLOWER "${_ic_to}" _ic_to)

    # See if we are casting from a user-defined class
    cpp_type_of(_ic_from_type "${${_ic_from}}")
    if("${_ic_from_type}" STREQUAL "class")
        # Casting from "class" to "type" is okay
        if("${_ic_to}" STREQUAL "type")
            set("${_ic_result}" TRUE PARENT_SCOPE)
        else()
            # Get the list of bases
            cpp_get_global(_ic_bases "${${_ic_from}}_bases")
            list(FIND _ic_bases "${_ic_to}" _ic_index)
            if("${_ic_index}" EQUAL -1)
                set("${_ic_result}" FALSE PARENT_SCOPE)
            else()
                set("${_ic_result}" TRUE PARENT_SCOPE)
            endif()
        endif()
        return()
    endif()

    # No longer need to dereference _ic_from, so can make it lowercase now
    string(TOLOWER "${_ic_from}" _ic_from)

    # Not convertible unless one of the following "if" conditions are true
    set("${_ic_result}" FALSE PARENT_SCOPE)

    if("${_ic_from}" STREQUAL "${_ic_to}")  # Casting to same type
        set("${_ic_result}" TRUE PARENT_SCOPE)
    elseif("${_ic_to}" STREQUAL "str")      # Casting to "str"
        set("${_ic_result}" TRUE PARENT_SCOPE)
    elseif("${_ic_from}" STREQUAL "overload")
        if("${_ic_to}" STREQUAL "obj")
            set("${_ic_result}" TRUE PARENT_SCOPE)
        endif()
    endif()
endfunction()

