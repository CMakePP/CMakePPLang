**********************************
Unit Testing CMakePPCore Functions
**********************************

This page contains guidelines, tips, and tricks which relate to unit testing
functionality in the CMakePPCore module. The contents of this page is somewhat
exclusive to CMakePPCore and is in addition to project-wide guidelines.

Testing Signatures
==================

The CMake language is weakly typed, the CMakePP language is strongly typed.
Because CMakePP is unit tested, users can be confident that member functions
declared with ``cpp_member`` and functions declared with ``cpp_function`` will
correctly enforce type safety (and if they don't that is a bug). Unfortunately,
this means that all other functions intended for use as part of the CMakePP API
need to have their type-safety checked manually. This section focuses on how to
unit-test the signatures of functions which are strongly typed, but are not
declared using ``cpp_member`` or ``cpp_function``.

CMakePP provides the ``cpp_assert_signature("${ARGV}" ...)`` function, which
will assert that the provided arguments have the types contained in the
ellipses. This function is unit tested, so you know it works. What this means is
you only need to ensure that you hooked this function correctly into the
function you are writing. Basically for a function taking :math:`N` positional
arguments you need :math:`N` checks where check :math:`i` ensures that the type
for the :math:`i`-th positional argument is set correctly. For non-variadic
functions an additional check should be done to make sure it is not possible to
pass :math:`(N + 1)` arguments, whereas for variadic functions a check should be
done to ensure you can pass :math:`(N + 1)` (and more) arguments.

Signatures in Types and Asserts
-------------------------------

The ``Types`` and ``Asserts`` CMakePP submodules are very low-level and care
needs to be taken to ensure that circular dependencies do not arise when unit
testing signatures. Such circular dependencies can arise because functions like
``cpp_assert_signature`` are implemented in terms of other functions within the
``Types`` and ``Asserts`` submodules.
