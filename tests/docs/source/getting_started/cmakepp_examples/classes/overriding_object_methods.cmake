# include(cmake_test/cmake_test)

# # Begin class definition
# cpp_class(Automobile)

#     # Define an attribute "color" with the value "red"
#     cpp_attr(Automobile color red)

#     cpp_attr(Automobile model "model_1")

#     # Override the equal, ignoring the color and only comparing models
#     cpp_member(_cpp_object_equal Automobile desc Automobile)
#     function("${_cpp_object_equal}" self _oe_result _oe_other)
        
#         Automobile(GET "${self}" _oe_model model)
#         Automobile(GET "${_oe_other}" _oe_other_model model)

#         if("${_oe_model}" STREQUAL "${_oe_other_model}")
#             set("${_oe_result}" TRUE)
#         else()
#             set("${_oe_result}" FALSE)
#         endif()

#         cpp_return("${_oe_result}")

#     endfunction()

#     cpp_member(_cpp_object_copy Automobile Automobile)
#     function("${_cpp_object_copy}" self _oc_other)

#         Automobile(GET "${self}" _oc_color color)
#         Automobile(SET "${_oc_other}" color "${_oc_color}")

#         cpp_return("${_oc_other}")

#     endfunction()

#     cpp_member(_cpp_object_serialize Automobile desc)
#     function("${_cpp_object_serialize}" self _os_result)

#         Automobile(GET "${self}" _os_color color)

#         set("${_os_result}" "Automobile: color = ${_os_color}")
#         cpp_return("${_os_result}")

#     endfunction()

# # End class definition
# cpp_end_class()

# ct_add_test(NAME [[overriding_object_methods]])
# function("${overriding_object_methods}")

#     ct_add_section(NAME [[override_equal]])
#     function("${override_equal}")

#         # Create two instances with different colors, but the same default
#         # car model (with the override these should be equal, as color does
#         # not matter)
#         Automobile(CTOR auto_1)
#         Automobile(CTOR auto_2 KWARGS color green)

#         cpp_equal(equal_result "${auto_1}" "${auto_2}")
#         message(STATUS "cpp_equal result: ${equal_result}")
#         # OUTPUT: cpp_equal result: TRUE

#         ct_assert_equal(equal_result TRUE)
    
#     endfunction()
    
#     ct_add_section(NAME [[override_copy]])
#     function("${override_copy}")

#         # Create two instances using the default CTOR
#         Automobile(CTOR auto_1)
#         Automobile(CTOR auto_2 KWARGS color green)

#         cpp_copy("${auto_2}" "${auto_1}")
#         Automobile(GET "${auto_1}" color_result_1 color)
#         Automobile(GET "${auto_2}" color_result_2 color)
#         message(STATUS "auto_1 color: ${color_result_1}")
#         message(STATUS "auto_2 color: ${color_result_2}")
#         # OUTPUT: auto_1 color: green
#         # OUTPUT: auto_2 color: green

#         ct_assert_equal(color_result_1 "${color_result_2}")
    
#     endfunction()

#     ct_add_section(NAME [[override_serialize]])
#     function("${override_serialize}")

#         # Create an instances using the default CTOR
#         Automobile(CTOR auto_1 KWARGS color green)

#         cpp_serialize(serialize_result "${auto_1}")
#         message(STATUS "auto_1: ${serialize_result}")
#         # OUTPUT: auto_1: Automobile: color = green

#         ct_assert_equal(serialize_result "Automobile: color = green")
    
#     endfunction()

# endfunction()
