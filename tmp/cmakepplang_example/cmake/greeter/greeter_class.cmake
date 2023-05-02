include_guard()
include(cmakepp_lang/cmakepp_lang)

#[[[
# Greeter class to greet the user using their name.
#
# The class definition for the Greeter class starts here with ``cpp_class``.
#]]
cpp_class(Greeter)

    #[[[
    # :type: str
    #
    # Name to use in the greeting. This attribute defaults to a blank string
    # ("") if it is not set by the user.
    #]]
    cpp_attr(Greeter name "")

    #[[[
    # Member function used to say hello to the user.
    # 
    # Notice that there is a ``cpp_member()`` call to provide the function
    # parameter typings, followed immediately by a ``function()`` call with
    # the dereferenced function name and parameter names.
    #
    # :param self: Greeter object to use.
    # :type self: Greeter
    #]]
    cpp_member(hello Greeter)
    function("${hello}" self)

        # Get the value of the 'name' attribute
        Greeter(GET "${self}" _name_result name)

        # Print the hello message to the user
        message("Hello, ${_name_result}!")

    endfunction() # End Greeter(hello

cpp_end_class() # End Greeter class
