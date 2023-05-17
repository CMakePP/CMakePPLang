#!/usr/bin/env bash

cmake -H. -Bbuild -DBUILD_TESTING=ON \
    -DFETCHCONTENT_SOURCE_DIR_CMAKEPP_LANG=$HOME/programs/cmakepp_workspace/cmakepplang \
    -DFETCHCONTENT_SOURCE_DIR_CMAKE_TEST=$HOME/programs/cmakepp_workspace/cmaketest \
    -DFETCHCONTENT_SOURCE_DIR_CMAIZE=$HOME/programs/cmakepp_workspace/cmaize

cd build
ctest --output-on-failure
