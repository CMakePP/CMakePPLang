<!--
  ~ Copyright 2023 CMakePP
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
-->

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
