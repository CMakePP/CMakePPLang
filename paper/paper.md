---
title: 'CMakePPLang'
tags:
  - CMake
  - build tools
  - cross-platform
  - C++
authors:
  - name: Zachery Crandall
    orcid: 0000-0003-3161-9378
    equal-contrib: true
    affiliation: "1, 2"
  - name: Blake Mulnix
    equal-contrib: false
    affiliation: "1, 2"
  - name: Branden Butler
    equal-contrib: false
    affiliation: "1, 2"
  - name: Ryan M. Richard
    orcid: 0000-0003-4235-5179
    corresponding: true
    affiliation: "1, 2"
affiliations:
 - name: Department of Chemistry, Iowa State University, USA
   index: 1
 - name: Chemical and Biological Sciences, Ames National Laboratory, USA
   index: 2
date: 12 June 2023
bibliography: paper/paper.bib # This will need to be tested, it might be relative to this file (just "paper.bib")
---

# Summary

CMakePPLang is an object-oriented extension to the CMake language written entirely using the original CMake language
with the goal of making projects built on CMake easier to create and maintain. 
That said, CMakePPLang has different coding practices, paradigms, and standards than the native CMake language, 
much in the same way that C++ coding differs from C coding despite some level of interoperability. 
Currently, CMakePPLang is used within the CMakePP organization as the 
foundation for two in-progress projects: CMakeTest and CMakeTest. CMakeTest
provides a solution for unit testing CMake and CMakePPLang code. CMaize
is a CMake tool to simplify interoperability between projects and writing 
their CMake build files.


# Statement of Need

CMake is an extensible build tool that exceeds at generating build systems
for many combinations of platforms, compilers, and build configurations.
CMake has become the *de facto* standard tool for building C, C++, and Fortran
programs of moderate to large size. However, as the size of a project increases, the
complexity of the CMake code to build it tends to also increase. 
In addition, as more tooling is built around CMake to make building projects with CMake
easier and less error prone, these tools will need to be designed in a
maintainable and testable way.[@ref_needed] 
The complexity of builds will also increase as
we move toward heterogeneous systems, requiring programs to leverage a
combination of CPUs, GPUs, and other specialized hardware. Object-
oriented programming excels at managing and maintaining large, complex code
bases[@wirth_good_2006; @ambler_realistic_1998], and there is an increasing
need for this in the CMake language.

Tobias Becker recognized these issues and wrote a purely object-oriented
language on top of CMake, called CMake++ (formerly oo-cmake).[@becker_cmake_2021]
CMake++ contains an abundance of CMake extensions. Many of those extensions
have direct overlap with extensions that are part of CMakePPLang. Features include
(among many): maps, objects, tasks/promises. Unfortunately development of
CMake++ has largely been done by a single developer and it appears to have been
abandoned, as there have only been two commits since July 2017, both in 2021.

One of the primary issues with CMake++ is the lack of documentation. While
there is some high-level documentation, there is little to no API or detailed
developer documentation. This makes it very challenging for a new developer to figure out
what is going on. Initially, forking and expanding on CMake++ was
considered, but it was determined that it would take similar time to come 
decipher CMake++ as it would to develop CMakePPLang.

*ZDC: There are other related project, listed [here](https://github.com/CMakePP/.github/blob/main/docs/source/about/other_projects.rst).
Do we want to discuss each of them? If so, I think we need to shorten the discussion of each one instead of the keeping each one around
the length of the CMake++ comparison*

CMakePPLang has been developed to provide extensions to the CMake language
which provide objected-oriented functionality and other quality-of-life
improvements. The main features of CMakePPLang are the object-oriented
functionality, addition of a map structure, strong data typing, and 
backwards-compatability with CMake. These features allow for easier general
programming in CMake, which is key to writing complex build tools in the
language.

# Basic Usage


*TLW: Give a short description of the design (maybe a picture?) and then briefly discuss each of the Features mentioned above.*

# Acknowledgement

This research was supported by the Exascale Computing Project (17-SC-20-SC), a collaborative 
effort of the U.S. Department of Energy Office of Science and the National Nuclear Security Administration.
The software was developed in the NWChemEx subproject and the research was performed at the Ames National Laboratory, 
which is operated for the US DOE by Iowa State University under [Contract No. DE-AC02-07CH11358].

# References
