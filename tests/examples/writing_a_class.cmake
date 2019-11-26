# Declaration of a class of type ClassType

# In a file my_class.cmake
include(cmakepp_core/class/class)
cpp_class(MyClass)
    cpp_member(print_out MyClass)
    function("${print_out}")
        cpp_MyClass(NAME _po_name)
        message("MyClass's name is ${_po_name}")
    endfunction()

    cpp_attr(name desc)
cpp_end_class(MyClass)

# Normally would be in another file in which case we need to include the class
# include(my_class) # Commented out to avoid infinite recursion

MyClass(CTOR new_instance)
MyClass(SET_NAME "${new_instance}" "Bob")
MyClass(PRINT_OUT "${new_instance}")
