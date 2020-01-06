************************
CMakePP Core Conventions
************************

Function Argument Order
=======================

The signatures of functions found in the CMakePP library all follow the same
conventions when it comes to argument orders. For a non-member CMakePP function
taking :math:`m` arguments and returning :math:`n` values (:math:`n\le m`), the
first :math:`n` arguments will be the :math:`n` values returned by the function
and the remaining :math:`m-n` values will be the inputs. CMake nor CMakePP make
any attempt to distinguish the value of :math:`n` in the signature and the only
way to know if a value is input or output is to consult the documentation (or
read the source code).

.. note::

   Native CMake tends to have output variables as the last argument to a
   function. This however, is clunky for variadic functions which almost always
   have a variable number of inputs, but not outputs. Furthermore this breaks
   from most languages' conventions which tend to have results on the left of a
   call (typically separated from the call by an equal sign, but on the left
   nonetheless).

For member functions associated with a type ``T``, CMake convention is to access
these members via a function named ``T`` whose first argument is the name of the
member function and whose second argument is the instance the member is being
called on (*e.g.*, the ``this`` instance in C++ or the ``self`` instance in
Python). CMakePP preserves this convention. Arguments following the object
instance obey the same ordering conventions as non-member functions.
