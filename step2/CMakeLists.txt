# build basic project
cmake_minimum_required(VERSION 3.12)
project(tutorial_1 VERSION 1.0)
add_executable(tutorial_1 tutorial.cxx)

# configure file
configure_file(tutorial.h.in tutorial.h)

# set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
if(MSVC)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17")
endif(MSVC)
MESSAGE(STATUS "Configure project ${PROJECT_BINARY_DIR}")


add_subdirectory(MathFunctions)
target_link_libraries(tutorial_1 PUBLIC MathFunctions)

target_include_directories(tutorial_1 PUBLIC
    "${PROJECT_SOURCE_DIR}"
    "${PROJECT_BINARY_DIR}"
    "${PROJECT_SOURCE_DIR}/MathFunctions"
)

