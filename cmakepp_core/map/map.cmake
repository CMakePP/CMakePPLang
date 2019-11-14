macro(cpp_map _cm_mode)
    if("${_cm_mode}" STREQUAL "HAS_KEY")
        cpp_map_has_key(${ARGN})
    else()
