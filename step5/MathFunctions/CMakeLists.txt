# build basic project
cmake_minimum_required(VERSION 3.12)
project(MathFunction VERSION 1.0)

# add_library(MathFunctions mysqrt.cpp)
include_directories(${PROJECT_BINARY_DIR})

option(USE_MYMATH "The tutorial uses my math implementation" ON)
if (USE_MYMATH)
    target_compile_definitions(tutorial_1 PUBLIC "USE_MYMATH")
endif

add_library(tutorial_compiler_flags INTERFACE)
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)
         
target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
target_link_libraries(SqrtLibrary PUBLIC tutorial_compiler_flags)
target_link_libraries(MathFunctions PUBLIC tutorial_compiler_flags)
add_library(MathFunctions MathFunctions.cpp)
add_library(SqrtLibrary STATIC
              mysqrt.cpp)  

set(installable_libs MathFunctions tutorial_compiler_flags)
if (TARGET SqrtLibrary)
  list(APPEND installable_libs SqrtLibrary)
endif()

# True if the given name is an existing logical target name created by a call to the add_executable(), 
# add_library(), or add_custom_target() command that has already been invoked
install(TARGETS ${installable_libs} DESTINATION lib)
install(FILES tutorial.h DESTINATION include)