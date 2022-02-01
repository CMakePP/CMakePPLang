*********************************
Debugging Code Written in CMakePP
*********************************

Native CMake has limited debugging capabilities, which are limited to printing
variables out and very verbose printing of every line that is executed by the
interpreter. While writing CMakePP we attempted to build in more robust
programming error checking and debugging features. These features come at a
computational cost so they should only be used to debug/unit test your build
systems.

Basics
======

The variable ``CMAKEPP_CORE_DEBUG_MODE`` can be used to cause all CMakePP
functions to run in debug mode. If you are familiar with the C/C++ preprocessor
macro definition ``NDEBUG`` it's the same idea, without the odd negative logic.
Basically verbose logging and extra error checks, like type and bounds checks,
are only done when ``CMAKEPP_CORE_DEBUG_MODE`` is defined and set to a true
value.

.. warning::

   There can be significant computational overhead associated with running your
   build system in debug mode, so your releases should **NOT** be in debug mode.
   As a rule-of-thumb, only enable debug mode when you are debugging or to
   ensure that you didn't make any programming mistakes.
