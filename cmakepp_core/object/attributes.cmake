include_guard()
include(cmakepp_core/utilities/assert)
include(cmakepp_core/utilities/enable_if_debug)
include(cmakepp_core/utilities/global)
include(cmakepp_core/utilities/return)

macro(cpp_object_get_attrs _oga_this _oga_result)
    cpp_get_global("${_oga_result}" "${_oga_this}__cpp_attrs")
endmacro()

function(cpp_object_set_attrs _osa_this _osa_value)
    cpp_set_global("${_osa_this}__cpp_attrs" "${_osa_value}")
endfunction()

function(cpp_object_has_attr _oha_this _oha_result _oha_attr)

    # Attributes are always stored lowercase
    string(TOLOWER "${_oha_attr}" _oha_attr)
    cpp_object_get_attrs("${_oha_this}" _oha_attrs)
    list(FIND _oha_attrs "${_oha_attr}" _oha_index)
    if("${_oha_index}" EQUAL -1)
        set("${_oha_result}" FALSE PARENT_SCOPE)
    else()
        set("${_oha_result}" TRUE PARENT_SCOPE)
    endif()
endfunction()

function(cpp_object_assert_has_attr _oaha_this _oaha_attr)
    cpp_enable_if_debug()
    cpp_object_has_attr("${_oaha_this}" _oaha_result "${_oaha_attr}")
    cpp_get_global(_oaha_type "${_oaha_this}__type")
    cpp_assert("${_oaha_result}" "${_oaha_type} has attribute '${_oaha_attr}'")
endfunction()


function(cpp_object_get_attr _oga_this _oga_value _oga_attr)
    cpp_object_assert_has_attr("${_oga_this}" "${_oga_attr}")
    string(TOLOWER "${_oga_attr}" _oga_attr)
    cpp_get_global("${_oga_value}" "${_oga_this}_${_oga_attr}")
    cpp_return("${_oga_value}")
endfunction()

function(cpp_object_set_attr _osa_this _osa_attr _osa_value)

    # Attribute names are always lower case
    string(TOLOWER "${_osa_attr}" _osa_attr)

    # Record the attribute with the object
    cpp_object_get_attrs("${_osa_this}" _osa_attrs )
    list(APPEND _osa_attrs "${_osa_attr}")
    list(REMOVE_DUPLICATES _osa_attrs)
    cpp_set_global("${_osa_this}__cpp_attrs" "${_osa_attrs}")

    cpp_set_global("${_osa_this}_${_osa_attr}" "${_osa_value}")
endfunction()

