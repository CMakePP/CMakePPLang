include_guard()
include(cmakepp_core/class/detail_/bases)
include(cmakepp_core/types/type_of)
include(cmakepp_core/utilities/global)
include(cmakepp_core/utilities/sanitize_string)

#[[[ Determines if an object of a given type can be passed as a different type.
#
# CMakePP is a strongly-typed language with minimal implicit conversions. This
# function knows of all allowed implicit conversions and should be used to
# determine if it is okay to use one type in place of another.
#
# .. note::
#
#    This function is used to implement ``cpp_assert_signature`` and thus can
#    not rely on ``cpp_assert_signature`` for type-checking.
#
# :param _ic_result: Name to use for the variable which will hold the result.
# :type _ic_result: desc
# :param _ic_from: The type we are attempting to cast from.
# :type _ic_from: type
# :param _ic_to: The type we are attempting to cast to.
# :type _ic_to: type
# :returns: ``_ic_result`` will be set to ``TRUE`` if an instance of
#           ``_ic_from`` can be implicitly converted to an instance of
#           ``_ic_to`` and ``FALSE`` otherwise.
# :rtype: bool
#
# Error Checking
# ==============
#
# ``cpp_implicitly_convertible`` will assert that it is called with only three
# arguments, if this is not the case an error will be raised.
#]]
function(cpp_implicitly_convertible _ic_result _ic_from _ic_to)
    if(NOT "${ARGC}" EQUAL 3)
        message(FATAL_ERROR "cpp_implicitly_convertible takes exactly 3 args.")
    endif()

    # Sanitize types to avoid case-sensitivity
    cpp_sanitize_string(_ic_to "${_ic_to}")
    cpp_sanitize_string(_ic_from "${_ic_from}")

    # Check if they are the same type (which are always implicitly convertible)
    if("${_ic_to}" STREQUAL "${_ic_from}")
        set("${_ic_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    # If from-type is "Class" we are casting from a user-defined class
    cpp_type_of(_ic_from_type "${_ic_from}")
    if("${_ic_from_type}" STREQUAL "class")
        # Casting from "Class" to "type" is okay
        if("${_ic_to}" STREQUAL "type")
            set("${_ic_result}" TRUE PARENT_SCOPE)
        else()
            # Need to see if from-type is a base class of to-type
            _cpp_class_get_bases("${_ic_from}" _ic_bases)
            list(FIND _ic_bases "${_ic_to}" _ic_index)
            if("${_ic_index}" EQUAL -1) # Not in list, so not a base class
                set("${_ic_result}" FALSE PARENT_SCOPE)
            else() # In the list, so a base class
                set("${_ic_result}" TRUE PARENT_SCOPE)
            endif()
        endif()
        return()
    endif()

    # Getting here means from-type and to-type are not the same type and
    # from-type is not a user-defined class. In turn this means there are only a
    # few edge-cases where we actually allow an implicit conversion. We check
    # for those now
    set("${_ic_result}" FALSE PARENT_SCOPE)

    # These are the edge-cases that make it an okay conversion
    if("${_ic_to}" STREQUAL "str")      # Everything is a str
        set("${_ic_result}" TRUE PARENT_SCOPE)
    elseif("${_ic_to}" STREQUAL "list")  # Any one object is a one-element list
        set("${_ic_result}" TRUE PARENT_SCOPE)
    endif()
endfunction()
