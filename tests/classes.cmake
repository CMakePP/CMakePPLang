# Declaration of a class
cmakepp_class(ClassType)
    cmakepp_ctor(ClassType)
    cmakepp_member(ClassType public_member_fxn str bool)
    cmakepp_member(ClassType _private_member_fxn)
    cmakepp_attr(ClassType )
end_cmakepp_class()

# Definition of ctor
cmakepp_member_def(ClassType public_member_fxn name write_out)
    if(${write_out})
        message("The name is ${name}")
    endif()
end_cmakepp_member_def()


cmakepp_new(ClassType a)

function(cmake_pp_member_def class_type fxn_name)

endfunction()
