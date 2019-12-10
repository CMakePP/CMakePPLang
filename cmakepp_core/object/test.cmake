macro(cpp_class class_name)
    cpp_function(_cpp_${class_name}_ctor obj)
    function("${_cpp_${class_name}_ctor}" base)
        foreach(_cc_base_i ${ARGN})


endfunction()
