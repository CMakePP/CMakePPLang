include_guard()

macro(cpp_enable_if_debug)
    if(NOT ${CMAKEPP_CORE_DEBUG_MODE})
        return()
    endif()
endmacro()
