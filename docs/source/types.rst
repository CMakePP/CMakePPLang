****************
Types in CMakePP
****************

Native CMake is a weakly typed language where all values are strings and in 
certain circumstances, certain strings are interpreted as being of another type. 
A common example is when a  string is used as an argument to CMake's ``if``
statement. There the  string is implicitly cast to a boolean. In practice this
weak typing can lead to subtle hard-to-detect errors. CMakePP implements strong
types in order to avoid/catch such errors.

Defining Strong Types
=====================

Native CMake supports the following implicit, contextually dependent casts from
strings:

- bool
- filepath
- float
- int
- list
- target

CMakePP comes with several additional "intrinsic" types:

- map
- object

These types are not recognized by CMake proper; however, they are treated by
CMakePP as if they were native intrinsic types. The union of the types
recognized by CMake and those recognized by CMakePP forms the set of intrinsic
types recognized by CMakePP.

A given valid CMake string is recognized by CMakePP as being of one, and
only one, intrinsic type. The following list comprises the types CMakePP
recognizes. For each type we have included its abbreviation in parenthesis (the
abbreviation is what you use when declaring signatures), a description of which
CMake strings qualify as that type, and any other things to note about the type.

- boolean (``bool``)

  - strings which case-insensitively match any of the true or false literals
  - true values: ``ON``, ``YES``, ``TRUE``, ``Y``
  - false values: ``OFF``, ``NO``, ``FALSE``, ``N``, ``NOTFOUND``

- description (``desc``)

  - strings which are not recognized as any type on this list.
  - the name "description" was chosen to avoid confusion with the CMake's
    fundamental string type and to highlight that such objects should primarily
    be used to provide human-readable descriptions and not convey information...

- filepath (``path``)

  - string which may be interpreted as being an absolute filepath for the
    present operating system
  - The path does not have to exist
  - Relative paths are poorly supported by CMake and will not be recognized as
    filepaths by CMakePP, but as strings

- floating-point (``float``)

  - strings which only contain a single ``.`` character and at least one of
    the digits in the range 0-9
  - may optionally be prefixed with a single ``-`` sign
  - floating-point values are stored as strings and are thus infinite precision
  - CMake's ``math`` command does not perform math with floating point values

- integers (``int``)

  - strings which only contain the digits 0-9
  - may optionally be prefixed with a single ``-`` sign

- list (``list``)

  - strings which contain at least one un-escaped semicolon
  - it is not possible to have a list with one element in CMakePP

    - While this sounds restrictive, in practice lists are only used in CMakePP
      to interface with native CMake and this restriction presents no problems
      in those circumstances

- map (``map``)

  - strings which are recognizable as "this pointers" for CMakePP maps

    - CMakePP creates "this pointers" for maps by a name-mangling technique
      which should not interfere with any other type.

- object (``obj``)

  - strings which are recognizable as "this pointers" for CMakePP objects

    - CMakePP creates "this pointers" for objects by a name-mangling technique
      which should not interfere with any other type.

- string (``str``)

  - This is the fundamental type that all valid CMake values share
  - A function which takes a value of type ``str`` accepts any valid CMake value
    for that argument (think of it as ``void*``).
  - Take care not to confuse string with description.

- target (``target``)

  - strings which CMake additionally identifies as targets
  - targets are always created via the native CMake calls like ``add_library``

Other Types
===========

While reading CMakePP API documentation you will come across several types not
on the above list.

- identifier (`*<T>`)

  - Identifiers are ultimately descriptions which have been defined

    - A description ``x`` is defined if ``if(DEFINED ${x})`` evaluates to true.

  - Identifiers play a role similar to pointers in C/C++ allowing values to be
    passed by reference vs. value

  - The notation


