**********************************
Unit Testing CMakePPLang Functions
**********************************

This page contains guidelines, tips, and tricks which relate to unit testing
functionality in the CMakePPLang module. The contents of this page is somewhat
exclusive to CMakePPLang and is in addition to project-wide guidelines.

Testing Signatures
==================

The CMake language is weakly typed, the CMakePP language is strongly typed.
Because CMakePP is unit tested, users can be confident that CMakePP functions
will correctly enforce type safety (and if they don't that is a bug).
Unfortunately, this means that all other functions intended to implement CMakePP
functions need to have their type-safety checked manually. This section focuses
on how to unit-test the signatures of functions which are strongly typed, but
are not CMakePP functions.

cpp_assert_signature
--------------------

CMakePP provides the function ``cpp_assert_signature`` to facilitate the testing
of signatures. ``cpp_assert_signature`` does the actual type-checking for you.
In your unit test you simply need to make sure you are calling
``cpp_assert_signature`` correctly.

As an example of using ``cpp_assert_signature`` consider the implementation of a
function with the signature ``my_function(desc, bool)``. This would look like:

.. code-block:: cmake

   include(cmakepp_lang/asserts/signature)
   function(my_function arg0 arg1)
       cpp_assert_signature("${ARGV}" desc bool)
       # Function implementation goes here
   endfunction()

The basic pattern is your function's first line should call
``cpp_assert_signature`` with the arguments provided to your function (this is
always ``"${ARGV}"``) and the types that each argument should be (of course you
should use your function's actual types and not ). To make sure you are calling
``cpp_assert_signature`` your unit-test should look like:

.. code-block:: cmake

   include(cmake_test/cmake_test)

   ct_add_test("my_function")
       include(path/to/my_function/implementation)

       ct_add_section("signature")

           ct_add_section("First argument must be a desc")
               my_function(TRUE TRUE)
               ct_assert_fails_as(
                   "Assertion: bool is convertible to desc failed."
               )
           ct_end_section()

           ct_add_section("Second argument must be a bool")
               my_function(hello world)
               ct_assert_fails_as(
                   "Assertion: desc is convertible to bool failed."
               )
           ct_end_section()

           ct_add_section("Function only takes two arguments")
               my_function(hello TRUE 42)
               ct_assert_fails_as(
                   "Function takes 2 argument(s), but 3 was/were provided."
               )
           ct_end_section()
       ct_end_section()
   ct_end_test()

This is admittedly boilerplate heavy, but it is also the minimum required to
make sure that you have correctly set the types of each argument and that your
function is not variadic (in this example we did not define our function as
variadic; if yours is variadic you can skip this check).

Functions that can not be type-checked with cpp_assert_signature
----------------------------------------------------------------

The following UML diagram summarizes the call graph of ``cpp_assert_signature``.

.. image:: assert_signature_call_graph.png

Caveats regarding recursion aside, the call graph of any CMake script must
ultimately be a directed-acyclic graph. This means we can not use
``cpp_assert_signature`` to type-check any of the signatures of the functions
used to implement it. More generally, with respect to the above UML diagram,
each function in the diagram can only use functions below it to implement
type-checking. For example ``sanitize_string`` can not use any function in the
call-graph to implement its type-checking (because all functions in the graph
depend on ``sanitize_string``), whereas ``cmakepp_type`` can use functions in
the ``global`` module as well as ``sanitize_string`` (which is not very helpful
in the long run for this particular use case). For the most part many of these
functions are quite generic (operating on objects of type ``str`` in many cases)
so type-checking is not particularly useful anyways (think of ``str`` as
``void*`` in C/C++). At the moment, for better or for worse, most of these
functions in this call graph have no type-checking.
