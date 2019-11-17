***************
Logic Directory
***************

The ``logic`` directory contains functions for determining if a condition is
true or false. In native CMake checking whether one of these conditions has been
met is usually done using boilerplate code like:

.. code-block:: cmake

   if(<condition>)
       set(is_condition_met TRUE)
   else()
       set(is_condition_met FALSE)
   endif()

The functions in this directory encapsulate such logic statements, which in
turn:

1. Reduces boilerplate
2. Protects against the many gotchas of CMake's "if"-statements
3. Makes it easier to chain conditions
