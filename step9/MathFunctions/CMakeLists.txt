# build basic project
cmake_minimum_required(VERSION 3.12)
project(MathFunction VERSION 1.0)
include(MakeTable.cmake)
# add_library(MathFunctions mysqrt.cpp)
include_directories(${PROJECT_BINARY_DIR})

option(USE_MYMATH "The tutorial uses my math implementation" ON)
if (USE_MYMATH)
    # target_compile_definitions(tutorial_1 PUBLIC "USE_MYMATH")
endif()

add_library(tutorial_compiler_flags INTERFACE)
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)
# add_library(SqrtLibrary STATIC
#               mysqrt.cpp)           
# target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
# add_library(MathFunctions MathFunctions.cpp)
add_library(SqrtLibrary STATIC mysqrt.cpp ${CMAKE_CURRENT_BINARY_DIR}/Table.h)
target_link_libraries(SqrtLibrary PUBLIC tutorial_compiler_flags)
# target_link_libraries(MathFunctions PUBLIC tutorial_compiler_flags)

target_include_directories(SqrtLibrary PRIVATE
${CMAKE_CURRENT_BINARY_DIR}
)

