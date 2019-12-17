cpp_class(MyClass)

    cpp_member(say_hello MyClass)
    function("${say_hello}" self)
        message("Hello world")
    endfunction()

cpp_end_class(MyClass)

MyClass(CTOR foo)
MyClass(SAY_HELLO "${foo}") # Prints "Hello world"

cpp_class(Greeter MyClass)

    cpp_member(say_hello Greeter desc)
    function("${say_hello}" self person)
        message("Hello ${person}")
    endfunction()

end_cpp_class(Greeter)

Greeter(CTOR a_greeter)
Greeter(SAY_HELLO "${a_greeter}")        # Prints "Hello world"
Greeter(SAY_HELLO "${a_greeter}" Alice)  # Prints "Hello alice"

MyClass(SAY_HELLO "${a_greeter}")         # Prints "Hello world"
# MyClass(SAY_HELLO "${a_greeter}" Alice) # Error base class has no such method
