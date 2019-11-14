Implementation Details for Type Checking
========================================

This directory contains the source files which define what it means to be a
particular CMakePP type. To avoid circular dependencies, these functions perform
no type checking on their signatures and are written to be largely independent.
Other CMakePP functionality should be written in terms of the public APIs of the
CMakePP types submodule.
