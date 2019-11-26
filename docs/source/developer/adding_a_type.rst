*****************
Adding a New Type
*****************

Generally speaking new types should be added to CMakePP by defining
classes for them. Such types are for the purposes of CMakePP core, derived from
the intrinsic type ``object``, and are thus not intrinsic to CMakePP. The
initial set of intrinsic types was chosen based on the needs of the CMakePP
``object`` class and the set of types CMake natively recognizes. All APIs having
to deal with types (for example ``cpp_member``) are designed to work with
non-intrinsic types as well as intrinsic types. The main distinction between
intrinsic and non-intrinsic types is performance related. Non-intrinsic types
have an additional layer of abstraction under them via the ``object`` class. It
is possible that this abstraction may become too expensive and additional types
may need to be added to CMakePP. The purpose of this page is to document how to
add a new intrinsic type to CMakePP, should the need arise.

For sake of argument these instructions assume you are adding the new type
``foobar`` which is abbreviated ``foo``.

1. Add ``foo`` to ``CMAKEPP_TYPE_LITERALS``

   - This list lives in ``cmakepp_core/types/literals.cmake``
   - List contains the recognized type abbreviations for all intrinsic types
   - Types should be all lowercase and listed in alphabetical order.

2. Write a file ``cmakepp_core/types/detail_/foo.cmake``

   - The function can not simply work by assuming the object is of type ``foo``
     if it is not of any other type.

     - Closure has been used to define ``desc`` as "anything that is not one of
       the other types".
     - It is valid to, for example, first ensure that the object is not a list
       before actually checking if it is of type ``foo`` (this is of note
       because lists are particularly hard to rule out otherwise)

   - Signature must be ``_cpp_is_foo(<result> <obj>)``

     - ``foo`` should be replaced with the name of the type
     - ``<result>`` is the ``desc`` to used for identifier holding the result
     - ``<obj>`` will be the ``str`` the function needs to examine
     - Consequentially the return type should be ``bool*``

   - The ``types`` submodule is very low level and the implementation should
       avoid using functionality not found natively in CMake or elsewhere in
       the ``types`` submodule.

       - This is to avoid circular dependencies

3. Add a check for ``foo`` to ``cmakepp_core/types/get_type.cmake``

   - Checks in ``get_type.cmake`` are listed alphabetically.
   - It should suffice to copy/paste the existing boilerplate for another type

4. Add a unit test for ``foo`` to ``tests/types/detail_/foo.cmake``

   - The unit test must show that the function written in step 2 returns
     ``FALSE`` for any type other than ``foo``.
   - Ideally it should also ensure that the function from step 2 does not get
     confused by lists of objects of type ``foo``, targets with the ``foo`` in
     their name, etc.
   - The unit test needs added to ``tests/types/detail_/CMakeLists.txt``

5. Update each unit test ``tests/types/detail_/bar.cmake``.

   - Here ``bar`` is one of the already existing intrinsic CMakePP types
   - A section needs added to each unit test showing that the already existing
     ``_cpp_is_bar`` function does not return ``TRUE`` for ``foo``
   - This is basically the reciprocal of step 4
   - ``tests/types/detail_/type.cmake`` requires an additional update to the
     ``type`` subsection to show that it recognizes ``foo`` as a type.

6. Update ``tests/types/get_type.cmake`` with a subsection for ``foo``

   - The subsection should show that ``cpp_get_type`` correctly returns ``foo``
     when given an object of type ``foo``.
