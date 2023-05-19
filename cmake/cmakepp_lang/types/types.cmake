#[[[ @module
# Since CMakePPLang is strongly typed and CMake is not, various functions are
# needed to determine which CMakePPLang type is contained in a CMake variable.
# This file provides an easy way for the user to include these functions for
# each type, as well as other functions necessary to support this strong
# typing.
#]]

include_guard()

include(cmakepp_lang/types/bool)
include(cmakepp_lang/types/cmakepp_type)
include(cmakepp_lang/types/float)
include(cmakepp_lang/types/fxn)
include(cmakepp_lang/types/implicitly_convertible)
include(cmakepp_lang/types/int)
include(cmakepp_lang/types/is_callable)
include(cmakepp_lang/types/list)
include(cmakepp_lang/types/literals)
include(cmakepp_lang/types/path)
include(cmakepp_lang/types/target)
include(cmakepp_lang/types/type)
include(cmakepp_lang/types/type_of)
