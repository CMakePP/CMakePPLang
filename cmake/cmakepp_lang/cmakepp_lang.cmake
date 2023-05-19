#[[[ @module
# CMakePPLang defines the basic extensions of the CMake language which
# comprise the CMakePP language, adding object-oriented functionality
# and quality of life features in a backwards-compatible way to CMake.
# Including this file will include the entire public API of CMakePPLang.
#]]

include_guard()

include(cmakepp_lang/algorithm/algorithm)
include(cmakepp_lang/asserts/asserts)
include(cmakepp_lang/class/class)
include(cmakepp_lang/exceptions/exceptions)
include(cmakepp_lang/map/map)
include(cmakepp_lang/object/object)
include(cmakepp_lang/serialization/serialization)
include(cmakepp_lang/types/types)
include(cmakepp_lang/utilities/utilities)
