*******
Objects
*******

The ``object`` class is the base class for all user-defined classes. This is the
class that defines the default implementations for the equality, copy, and
serialization functionalities. The member functions of ``object`` that implement
these features are called:

- ``_cpp_object_equal``
- ``_cpp_object_copy``
- ``_cpp_object_serialize``

Currently, these functions cannot be overridden in user-defined classes.

.. TODO add when object methods can be overridden
.. The implementations of these functionalities within the object class are what
.. are called by the ``cpp_equal``, ``cpp_copy``, and ``cpp_serialize`` utilities.
.. It is useful to note that these functions may be **overridden** by any class
.. (since all classes inherit from object). Examples of overriding these methods
.. are provided in :ref:`overriding-object-methods`.
..
.. Other than the above, the object class is not assumed to be of much interest
.. to most users of CMakePP.
