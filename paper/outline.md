# Outline

## Statement of Need

- Similar to C++ justification over just C
- To extend CMake with the level of abstraction needed for other projects
  planned by CMakePP project, an object-oriented language would be needed
  to make the projects tractable
- CMake is not an object-oriented language and things like abstraction
  are easier in an object-oriented paradigm
- Easier general programming

## Similar Projects

- Look up object-oriented CMake

## Architecture and Design

- Need object-oriented language
- Maintain compatability with CMake
- Python and Lua use maps to represent objects
- Strong typing
- Top-level object class that all user classes inherit from
