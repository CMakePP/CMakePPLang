include_guard()
include(cmakepp_core/algorithm/equal)
include(cmakepp_core/map/map)

function(cpp_map_equal _me_this _me_result _me_other)
    cpp_map_keys("${_me_this}" _me_my_keys)
    list(LENGTH _me_my_keys _me_my_n_keys)

    cpp_map_keys("${_me_other}" _me_other_keys)
    list(LENGTH _me_other_keys _me_other_n_keys)

    if(NOT "${_me_other_n_keys}" EQUAL "${_me_my_n_keys}")
        set("${_me_result}" FALSE PARENT_SCOPE)
        return()
    elseif("${_me_my_n_keys}" EQUAL 0)
        set("${_me_result}" TRUE PARENT_SCOPE)
        return()
    endif()

    foreach(_me_key_i ${_me_my_keys})
        message("Map Equal: ${_me_key_i}")
        cpp_map_has_key("${_me_other}" _me_good_key "${_me_key_i}")
        if(NOT "${_me_good_key}")
            set("${_me_result}" FALSE PARENT_SCOPE)
            return()
        endif()

        cpp_map_get("${_me_this}" _me_my_value "${_me_key_i}")
        cpp_map_get("${_me_other}" _me_other_value "${_me_key_i}")

        cpp_equal(_me_good_value "${_me_my_value}" "${_me_other_value}")
        if(NOT "${_me_good_value}")
            set("${_me_result}" FALSE PARENT_SCOPE)
            return()
        endif()
    endforeach()

    set("${_me_result}" TRUE PARENT_SCOPE)
endfunction()
