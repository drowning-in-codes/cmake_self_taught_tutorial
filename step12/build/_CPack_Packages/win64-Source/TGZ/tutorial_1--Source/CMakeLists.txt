# build basic project
cmake_minimum_required(VERSION 3.15)
project(tutorial_1 VERSION 1.0)
include(CTest)
include(CheckCXXSourceCompiles)
include(CMakePackageConfigHelpers)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

check_cxx_source_compiles("
#include <cmath>
int main() {
  std::log(1.0);
  return 0;
}
" HAVE_LOG)

check_cxx_source_compiles("
#include <cmath>
int main() {
  std::exp(1.0);
  return 0;
}
" HAVE_EXP)


# MESSAGE(STATUS "${CMAKE_CURRENT_LIST_DIR}")
if (HAVE_LOG AND HAVE_EXP)
    # target_compile_definitions(tutorial_1 PRIVATE "HAVE_LOG" "HAVE_EXP")
endif()
add_executable(tutorial_1 tutorial.cxx)






# configure file
# configure_file(tutorial.h.in tutorial.h)

# set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
MESSAGE(STATUS "Configure project ${PROJECT_BINARY_DIR}")
# target_include_directories(tutorial_1 PUBLIC
#     "${PROJECT_BINARY_DIR}"
# )   

# 使用INTERFACE继承include,连接这个库的目标也会继承这个include(但这个目标本身不使用这个include)
# target_include_directories(MathFunctions INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

# add_library(tutorial_compiler_flags INTERFACE)
# target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_17)
# target_link_libraries(tutorial_1 MathFunctions tutorial_compiler_flags)


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
add_test(NAME mytest COMMAND tutorial_1)

# 使用cpack构建时
include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")
include(CPack)