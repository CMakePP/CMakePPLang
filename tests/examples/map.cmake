#TUTORIAL_START_SKIP
include(cmake_test/cmake_test)
ct_add_test("How to Use the CMakePP Map Class")
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# This tutorial focuses on how to use the CMakePP map class. The map class
# implements an associative container, which tends to be far more useful for
# passing multiple values then CMake's native list.
#
# As a user of the map class you access the class by including
# ``cmakepp_core/map/map``. This brings the ``cpp_map`` function into view.
# The ``cpp_map`` function works similar to CMake's native ``list`` and
# ``string`` functions, basically the first argument is the subcommand (or
# member function if you think of the ``map`` as a class) you want to run and
# the remaning inputs to the command depend on the particular member function
# you are calling. Unlike CMake proper, CMakePP's member function names are
# **NOT** case-sensitive to match the semantics CMake uses for normal functions.
# Nonetheless, we follow the usual CMake convention of writing member function
# names in all captial letters.
#
# In order to use a map, you have to first create a map instance. This is done
# by calling the constructor (by convention the constructor for all classes is
# named ``CTOR``) and providing it a variable name to use. In the following code
# example we create a map and store it in the variable ``my_map``.
include(cmakepp_core/map/map)
cpp_map(CTOR my_map)

#TUTORIAL
#
# As an associative container the main thing we want to do is set and get named
# values. The first two lines of the following example, set the keys ``a_key``
# and ``foo`` respectively to ``a_value`` and ``bar``. The next two lines show
# how to retrieve the values.
cpp_map(SET "${my_map}" a_key a_value)
cpp_map(SET "${my_map}" foo bar)
cpp_map(GET a_key_value "${my_map}" a_key)
cpp_map(GET foo_value "${my_map}" foo)
message("a_key = ${a_key_value} and foo = ${foo_value}")

#TUTORIAL_START_SKIP
ct_assert_equal(a_key_value a_value)
ct_assert_equal(foo_value bar)
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# Aside from setting and getting the keys/values the map class also offers
# functions for inspecting its state. For example, to determine if a particular
# map has a particular key we can use the ``HAS_KEY`` member function:
cpp_map(HAS_KEY has_a_key ${my_map} a_key)
message("Has the key 'a_key' : ${has_a_key}")

#TUTORIAL_START_SKIP
ct_assert_equal(has_a_key TRUE)
#TUTORIAL_STOP_SKIP

#TUTORIAL
#
# Another common usecase is needing to iterate over the map. The most
# straightforward way to do this is to get the list of keys and then use that
# list in CMake's foreach loop.
cpp_map(KEYS the_keys ${my_map})
foreach(key_i IN LISTS the_keys)
    cpp_map(GET value_i "${my_map}" "${key_i}")
    message("${key_i} is set to: ${value_i}")
endforeach()

#TUTORIAL_START_SKIP
ct_assert_equal(the_keys "a_key;foo")
ct_end_test()
#TUTORIAL_STOP_SKIP

