#TUTORIAL_START_SKIP
include(cmake_test/cmake_test)
ct_add_test("CMakePP function tutorial")
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# CMakePP allows you to declare strongly-typed functions, which are overloadable
# and variadic. The machinery for declaring and defining CMakePP functions lives
# in the ``cmakepp_core/function/function.cmake`` module. Once this machinery
# has been included declaring a CMakePP function is as simple as declaring a
# normal CMake function "decorated" with ``cpp_function``. As a first example
# let us declare a function ``say_hello`` which prints "Hello World" when
# invoked. This is done by:
include(cmakepp_core/function/function)

cpp_function(say_hello)
function(${say_hello})
    message("Hello World")
endfunction()

say_hello()

#TUTORIAL_START_SKIP
ct_add_section("prints hello world")
ct_assert_prints("Hello World")
ct_end_section()
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# The call ``cpp_function(hello_world)`` declares a function ``hello_world``
# which takes 0 positional arguments. The next three lines actually implement
# the declared function. Notice that when the function is declared it retrieves
# its name from the ``say_hello`` variable. Without going into too much detail,
# CMakePP relies on name mangling to tell overloads apart. So what you are
# actually defining is not a function ``say_hello``, but a particular overload
# of ``say_hello`` (namely one which accepts 0 arguments). This brings us to the
# next point, unlike CMake which treats all functions as variadic, CMakePP
# functions must be explicitly marked as variadic. In other words, for CMakePP
# functions the following is not valid:

# say_hello(foo)  # <---- Not valid with CMakePP

#TUTORIAL_START_SKIP
ct_add_section("Is actually an error")
say_hello(foo)
ct_assert_fails_as("Overload say_hello(desc) does not exist")
ct_end_section()
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# As already mentioned CMakePP functions can be overloaded (the implementation
# is choosen based on the types of the arguments). With our current definition
# of ``say_hello`` in scope we can introduce a more generic implementation which
# says "Hello" to a person of our choosing. Generic strings are of type ``desc``
# in CMakePP so we need to declare an overload ``say_hello(desc)``, which is
# done like:

cpp_function(say_hello desc)
function(${say_hello} person_to_say_hi_to)
    message("Hello ${person_to_say_hi_to}")
endfunction()

say_hello()         # <--- Calls say_hello(void) and prints "Hello World"
say_hello("Alice")  # <--- Calls say_hello(desc) and prints "Hello Alice"

#TUTORIAL_START_SKIP
ct_add_section("Says hi to Alice")
ct_assert_prints("Hello Alice")
ct_end_section()
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# Preventing all functions from being variadic protects agains a common CMake
# pitfall arising when a CMake list is not passed in double quotes. Without
# double quotes, the CMake list gets expanded and passed as multiple arguments,
# an error that is hard to catch otherwise. That said, CMakePP functions can be
# variadic, but they must be declared as such. We can declare a variadic
# overload of ``say_hello`` by passing ``args`` as the last argument (think of
# it as ``*args`` from Python). This looks like:

cpp_function(say_hello desc desc args)
function(${say_hello} person1 person2)
    foreach(personi ${person1} ${person2} ${ARGN})
        message("Hello ${personi}")
    endforeach()
endfunction()

say_hello()                         # say_hello()
say_hello("Alice")                  # say_hello(desc)
say_hello("Alice" "Bob")            # say_hello(desc, desc, args), args = []
say_hello("Alice" "Bob" "Clarice")  # say_hello(desc, desc, args),
                                    # args = [Clarice]

#TUTORIAL
#
# It should be noted that we could not define the variadic overload as
# ``cpp_function(say_hello desc args)`` as this overload would be ambiguous with
# ``cpp_function(say_hello desc)``. More specifically it would be impossible to
# distinguish between a call to ``say_hello(desc)`` and
# ``say_hello(desc, args)`` with an empty ``args`` argument. CMakePP will raise
# an error if you attempt to define an ambiguous overload.
#
# .. note::
#
#    The ambiguous overload error check is computationally expensive and only
#    performed if CMakePP is run in debug mode (by setting `
#    `CMAKEPP_CORE_DEBUG_MODE`` to a true value). It is strongly recommended
#    that you always test your CMakePP code in debug mode at least once.

#TUTORIAL_START_SKIP
ct_add_section("Ambiguous overloads is an error")
set(CMAKEPP_CORE_DEBUG_MODE ON)
cpp_function(say_hello desc args)
ct_assert_fails_as("say_hello(desc, args) conflicts with existing")
ct_end_section()

ct_add_section("Variadic works")
ct_assert_prints("Hello Bob")
ct_assert_prints("Hello Clarice")
ct_end_section()
#TUTORIAL_STOP_SKIP

#TUTORIAL_START_SKIP
ct_end_test()
#TUTORIAL_STOP_SKIP
