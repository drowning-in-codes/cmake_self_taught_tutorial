# build basic project
cmake_minimum_required(VERSION 3.12)
project(tutorial_1 VERSION 1.0)
add_executable(tutorial_1 tutorial.cxx)

# configure file
configure_file(tutorial.h.in tutorial.h)

# set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
MESSAGE(STATUS "Configure project ${PROJECT_BINARY_DIR}")
target_include_directories(tutorial_1 PUBLIC
    "${PROJECT_BINARY_DIR}"
)   
