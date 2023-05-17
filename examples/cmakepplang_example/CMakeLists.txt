cmake_minimum_required(VERSION 3.14) # b/c of FetchContent_MakeAvailable
project(CMakePPLangExample VERSION 1.0.0 LANGUAGES NONE)

option(BUILD_TESTING "Should we build and run the unit tests?" OFF)

# Bring the 'cmake' directory into scope to include files contained
# within easily
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(get_cmakepp_lang)

# Include the Greeter class definition
include(greeter/greeter_class)

# Create a Greeter instance
Greeter(CTOR greeter_obj)

# Set the 'name' attribute of the Greeter instance
Greeter(SET "${greeter_obj}" name "John Doe")

# Get the 'name' attribute value of the Greeter instance to check it
Greeter(GET "${greeter_obj}" name_result name)
message("Name attribute value: ${name_result}")
# OUTPUT: Name attribute value: John Doe

# Call the 'Greeter(hello' method for the Greeter instance, which uses the
# 'name' attribute to get the name to print
Greeter(hello "${greeter_obj}")
# OUTPUT: Hello, John Doe!

# We can also test the class using CMakeTest
if("${BUILD_TESTING}")
    include(CTest)
    add_subdirectory(tests)
endif()
