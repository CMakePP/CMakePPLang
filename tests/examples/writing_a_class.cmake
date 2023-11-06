#TUTORIAL_START_SKIP
include(cmake_test/cmake_test)
ct_add_test(NAME [[writing_a_class]])
function("${CMAKETEST_TEST}")
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# The machinery for declaring and defining a CMakePP class lives in
# ``cmakepp_lang/class/class``. Let's start by writing a simple class
# ``Greeter`` which has a single member function ``say_hello``. ``say_hello``
# simply returns ``"Hello World"`` via the variable ``result``. The code to do
# this is:
include(cmakepp_lang/class/class)

cpp_class(Greeter)

    cpp_member(say_hello Greeter)
    function("${say_hello}")
        set(result "Hello World" PARENT_SCOPE)
    endfunction()

cpp_end_class()


#TUTORIAL
#
# The above code would typically live in a file called ``greeter.cmake`` akin to
# defining a C++ class in a header file or a Python class in a module. Users
# bring your class into scope by including this file. Once your class definition
# is in scope it defines a function with the same name (in this case we get a
# function named ``Greeter``). CMakePP classes generalize the syntax introduced
# by CMake for ``string`` and ``list``, which for ``Greeter`` looks something
# like:
#
# .. code-block:: cmake
#
#    Greeter(<member function> self arg0 arg1 ...)
#
# The first argument to the function is always the name of the member function
# we want to invoke. CMake precedent is to specify the member function in
# screaming case, but we note that CMakePP is case-insensitive in this regard.
# The remaining arguments are the arguments which will be forwarded to the
# member function. With the exception of the constructor, the first argument to
# all member functions is the instance the member function belongs to (the
# analog of ``*this`` in C++ or ``self`` in Python). For the constructor, the
# first argument is the name to use for the instance being created. The
# remaining arguments depend on the member function being called.
#
# The following snippet shows how to create a new ``Greeter`` instance, call
# its ``say_hello`` member function, and print the contents of ``result`` set
# by ``say_hello``.
Greeter(CTOR new_instance)
set(result "") # Set result to "" to prove it is being set by the Greeter
Greeter(SAY_HELLO "${new_instance}")
message("${result}")  # Prints "Hello World"

#TUTORIAL_START_SKIP
ct_add_section(NAME [[val_result_correct]])
function("${CMAKETEST_SECTION}")
ct_assert_equal(result "Hello World")
endfunction()

ct_add_section(NAME [[no_method]] EXPECTFAIL)
function("${CMAKETEST_SECTION}")
Greeter(SAY_HELLO TRUE)
endfunction()

ct_add_section(NAME [[no_overload_multi_args]] EXPECTFAIL)
function("${CMAKETEST_SECTION}")
Greeter(SAY_HELLO "${new_instance}" foo bar)
endfunction()
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# CMakePP is strongly typed so you will get an error if you try to pass
# additional arguments into ``say_hello`` or if you pass an object that is not
# implicitly convertible to a ``Greeter`` as the self instance.
#
# .. code-block:: cmake
#
#    #Greeter(SAY_HELLO TRUE) # bool is not implicitly convertible to Greeter
#    #Greeter(SAY_HELLO "${new_instance}" foo bar) # error only takes 1 argument
#
# At this point our ``Greeter`` class is not particularly useful. It'd be a lot
# more useful if we could control who the class greets. CMakePP classes  behave
# a lot like Python classes, namely all methods are virtual and you can add
# attributes on the fly. Thus we can make a more useful ``Greeter``  by deriving
# a class ``UsefulGreeter`` from ``Greeter`` and overriding the ``say_hello``
# method. The code to do this looks like:

cpp_class(UsefulGreeter Greeter)

    cpp_attr(UsefulGreeter name Alice)

    cpp_member(say_hello UsefulGreeter)
    function("${say_hello}" self)
        UsefulGreeter(GET "${self}" my_name name)
        set(result "Hello ${my_name}" PARENT_SCOPE)
    endfunction()

cpp_end_class()

#TUTORIAL
#
# The first line declares our ``UsefulGreeter`` class as a derived class of
# ``Greeter``. More generally we note that the ``cpp_class`` command is
# variadic; the first argument is the name of the class we are declaring and all
# additional arguments are direct base classes of the class being declared. In
# other words, CMakePP supports multiple inheritance. Multiple inheritance is
# not covered in this tutorial, but we note that it behaves identically to
# multiple inheritance in Python.
#
# Since we are overriding a function with a signature ``say_hello(Greeter)``,
# our override must get any additional information from the instance being
# provided (*i.e.*, if we tried to pass in the name of the person we were
# greeting we'd actually be defining a function ``say_hello(Greeter, desc)``,
# which is an overload of ``say_hello`` not an override). The second line of the
# above snippet declares that the ``UsefulGreeter`` class has an attribute
# ``name`` (and sets the default value to ``Alice``).
#
# The remainder of the snippet defines the override of ``say_hello``. It is
# worth noting the syntax for getting/setting attributes of an instance. When
# you declare an attribute CMakePP automatically defines a "getter" and a
# "setter"; for an attribute ``foo`` the getter and setter are respectively
# ``get_foo`` and ``set_foo`` and the arguments to the getter and setter are
# the object instance we are getting/setting the attribute of and the variable
# to put the value in (for the getter) or the value of the attribute (for the
# setter).
#
# Creating and using instances of ``UsefulGreeter`` work the same way as they
# did for ``Greeter``:

UsefulGreeter(CTOR useful)
UsefulGreeter(SAY_HELLO "${useful}")
message("${result}")  # Prints "Hello Alice"

#TUTORIAL_START_SKIP
ct_add_section(NAME [[val_result_derived]])
function("${CMAKETEST_SECTION}")
ct_assert_equal(result "Hello Alice")
endfunction()

#ct_add_section(NAME [[no_overload_for_greeter_arg]] EXPECTFAIL)
#function("${no_overload_for_greeter_arg}")
#UsefulGreeter(SAY_HELLO "${new_instance}")
#endfunction()
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# Additionally, ``UsefulGreeter`` instances can be passed to the ``Greeter``
# function (think of this as accessing ``UsefulGreeter`` instances through the
# base class ``Greeter``):

Greeter(SAY_HELLO "${useful}")
message("${result}")  # Prints "Hello Alice"

#TUTORIAL_START_SKIP
ct_add_section(NAME [[val_result_base]])
function("${CMAKETEST_SECTION}")
ct_assert_equal(result "Hello Alice")
endfunction()
endfunction()
#TUTORIAL_STOP_SKIP
