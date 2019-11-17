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

All valid CMake values are strings. In addition to being of type "string"
CMakePP additionally recognizes each valid CMake value as being of one, and
only one, other intrinsic type. The following subsections discuss the intrinsic
CMakePP types. The subsection headings include the standardized abbreviation of
each type in parenthesis.

Boolean (bool)
--------------

Any CMake string which case-insensitively matches one of the established boolean
literals is deemed to be a boolean. The recognized boolean literals adopted by
CMakePP are a subset of those recognized by CMake itself. Specifically this list
includes:

  - True boolean literals: ``ON``, ``YES``, ``TRUE``, and ``Y``
  - False boolean literals: ``OFF``, ``NO``, ``FALSE``, ``N``, and ``NOTFOUND``

CMake's documentation additionally lists ``0`` and ``1`` as respectively being
false and true boolean literals; however, CMakePP adopts the philosophy that
``0`` and ``1`` are integer literals that can be implicitly casted to booleans.

Description (desc)
------------------

Description is the catchall for any CMake string which fails to meet the
criteria of another intrinsic type. Descriptions are usually used to name and/or
document things and tend to be human-readable. The name "description" was chosen
to avoid confusion with the CMake's fundamental string type. Descriptions also
tend to be the type an object is classified as if there is a syntax error, for
example the literal ``" 1"`` is a description and **NOT** an integer because it
includes whitespace.

Filepath (path)
-------------------

CMake has builtin support for determining whether a string is a valid filepath
for a target operating system. While CMake natively has some support for
relative filepaths, best CMake practice is to always use absolute filepaths.
CMakePP therefore stipulates that any CMake string, which can be interpreted as
an absolute filepath is an object of type ``path``. It is worth noting that the
path does **NOT** need to exist in order for it to be a filepath object.

Floating-Point Number (float)
---------------------------------

CMake strings which contain only a single decimal character (``.``) in addition
to at least one digit in the range 0-9 are floating point numbers. Floating
point numbers may optionally be prefixed with a single minus sign character
(``-``) to denote that the value is negative. Since ultimately the
floating-point value is stored as a string, it is of infinite precision. CMake's
``math`` command does not support arithmetic involving floating point values and
thus floating point numbers are uncommon in typical CMake scripts.

Integers (int)
--------------

Any CMake string comprised entirely of the digits 0-9 is an integer. Integers
may optionally be prefixed with a single minus sign (``-``). Integers are
ultimately stored as strings and thus are of infinite precision. That said
CMake's backend is written in C++ and it is likely (although I can not say for
certain) that passing integers into native CMake functions will result is a loss
of precision.

List (list)
-----------

In CMake strings which contain at least one un-escaped semicolon are lists. In
CMakePP we avoid lists as much as possible owing to the many gotchas associated
with them. Nonetheless, particularly at interfaces with standard CMake code the
use of lists is unavoidable. It is worth noting that CMakePP's definition of a
list makes it such that it is impossible to have a list containing a single
element.

Map (map)
---------

Stealing from Python's design, it becomes much simpler to implement objects if
we have an associative array object. The CMakePP map is such an object. When a
map is created CMakePP creates a unique identifier for that instance. Behind the
scenes, CMakePP keeps track of what state is associated with which instance by
using these unique identifiers. A CMake string is a CMakePP map if it can be
interpreted as being one of these unique identifiers.


Object (obj)
------------

This is the base class for all user-defined classes. A string is an object if it
is recognizable as a "this pointer" for an object. This is done by comparing it
against the name-mangling scheme used internally.

String (str)
------------

This is the fundamental type that all valid CMake values share. In CMakePP the
type ``str`` functions like ``void*`` in C. If a CMakePP function accepts an
argument of type ``str`` that means it accepts any valid CMake value. It should
be noted that ``str`` is not the same thing as ``desc``. In particular all
``desc`` are ``str``, but not all ``str`` are ``desc``. For example the ``str``,
``TRUE`` is a ``bool``.

Target (target)
---------------

CMake keeps an internal list of targets. Any CMake string that CMake recognizes
as the name of a target is of the ``target`` type.

Type (type)
-----------

A CMake string is a type if it matches (case-insensitively) any of the
abbreviations for the types listed in this section.

Other Types
===========

The types in the previous section are the rigorous types recognized by CMakePP,
particularly for documenting returns from functions it is worth creating
fictional CMakePP types.

Identifier (T*)
---------------

Identifiers are ultimately descriptions which have been defined. A description
``x`` is said to be defined if ``if(DEFINED x)`` evaluates to true. Identifiers
are synonymous with "variable". In CMake and CMakePP identifiers play a role
similar to pointers in C/C++. Identifiers are "dereferenced" by using the
``${}`` operation. The notation used for the abbreviation, ``T*``, draws on the
pointer analogy and means that dereferencing the identifier will yield a value
of type ``T``. For example if the identifier ``x`` is of type ```int*``,
``${x}`` results in an integer. Identifiers most commonly show up as return
types, although they can be inputs occasionally.

It is tempting to make identifiers intrinsic types; however, since identifiers
only differ from descriptions by the fact that they are defined, this leads to
an ugly syntax like:

.. code-block:: cmake

   set(an_identifier)
   fxn_taking_an_identifier(an_identifier)

unless ``an_identifier`` was previously defined.

Tuple (tuple(<T>, <U>, ...))
----------------------------

  - strings which contain at least one-unescaped semicolon and a fixed number of
    elements
  - the ``<T>`` and ``<U>`` should be replaced with the types of the elements.
  - CMakePP functions which return multiple values using multiple positional
    arguments are considered to return tuples.



