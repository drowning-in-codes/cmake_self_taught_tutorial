# build basic project
cmake_minimum_required(VERSION 3.15)
project(tutorial_1 VERSION 1.0)

# set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
add_executable(tutorial_1 tutorial.cxx)

# configure file
configure_file(tutorial.h.in tutorial.h)

# if (MSVC_VERSION GREATER_EQUAL "1900")
#     include(CheckCXXCompilerFlag)
#     CHECK_CXX_COMPILER_FLAG("/std:c++latest" _cpp_latest_flag_supported)
#     if (_cpp_latest_flag_supported)
#         add_compile_options("/std:c++latest")
#     endif()
# endif()


MESSAGE(STATUS "Configure project ${PROJECT_BINARY_DIR}")
target_include_directories(tutorial_1 PUBLIC
    "${PROJECT_BINARY_DIR}"
)   

# 使用INTERFACE继承include,连接这个库的目标也会继承这个include(但这个目标本身不使用这个include)
# target_include_directories(MathFunctions INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

# add_library(tutorial_compiler_flags INTERFACE)
# target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_17)
# target_link_libraries(tutorial_1 MathFunctions tutorial_compiler_flags)

set(mybin "${PROJECT_BINARY_DIR}/bin")
set(myinclude "${PROJECT_BINARY_DIR}/include")
install(TARGETS tutorial_1 DESTINATION ${mybin})
install(FILES "${PROJECT_BINARY_DIR}/tutorial.h" DESTINATION ${myinclude})

set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")
MESSAGE(STATUS "msvc_cxx" "${COMPILE_LANG_AND_ID}")
# target_compile_options(tutorial_compiler_flags INTERFACE
#   "$<${gcc_like_cxx}:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>"
#   "$<${msvc_cxx}:-W3>"
# )

# target_compile_options(tutorial_compiler_flags INTERFACE
#   "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
#   "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
# )

# add test
enable_testing()
add_test(NAME Runs COMMAND tutorial_1 25)
# set(CMAKE_BUILD_TYPE)

# use the PASS_REGULAR_EXPRESSION test property to verify that the output of the test contains certain strings.
#  In this case, verifying that the usage message is printed when an incorrect number of arguments are provided.
add_test(NAME Usage COMMAND tutorial_1)
set_tests_properties(Usage PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number")

add_test(NAME StandardUse COMMAND Tutorial 4)
set_tests_properties(StandardUse
  PROPERTIES PASS_REGULAR_EXPRESSION "4 is 2"
  )



  # To easily add more tests, we make a function called do_test that runs the application and verifies that the computed square root is correct for given input. For each invocation of do_test, 
  # another test is added to the project with a name, input, and expected results based on the passed arguments.
  # function(func_name,executable,args,result)
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction()

do_test(tutorial_1 4 "4 is 2")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is (-nan|nan|0)")
do_test(Tutorial 0.0001 "0.0001 is 0.01")