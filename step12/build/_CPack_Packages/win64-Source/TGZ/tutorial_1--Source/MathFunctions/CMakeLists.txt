# build basic project
cmake_minimum_required(VERSION 3.12)
project(MathFunction VERSION 1.0)
include(MakeTable.cmake)
add_library(MathFunctions mysqrt.cpp)
include_directories(${PROJECT_BINARY_DIR})

option(USE_MYMATH "The tutorial uses my math implementation" ON)
if (USE_MYMATH)
    # target_compile_definitions(tutorial_1 PUBLIC "USE_MYMATH")
endif()
add_library(SqrtLibrary STATIC
              mysqrt.cpp)    
              option(BUILD_SHARED_LIBS "Build using shared libraries" ON)
set_target_properties(SqrtLibrary PROPERTIES 
POSITION_INDEPENDENT_CODES ${BUILD_SHARED_LIBS})
add_library(tutorial_compiler_flags INTERFACE)
target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)
       
# target_link_libraries(MathFunctions PRIVATE SqrtLibrary)
# add_library(MathFunctions MathFunctions.cpp)
# add_library(SqrtLibrary STATIC mysqrt.cpp ${CMAKE_CURRENT_BINARY_DIR}/Table.h)
target_link_libraries(SqrtLibrary PUBLIC tutorial_compiler_flags)
# target_link_libraries(MathFunctions PUBLIC tutorial_compiler_flags)

target_include_directories(SqrtLibrary PRIVATE
${CMAKE_CURRENT_BINARY_DIR}
)

set(installable_libs MathFunctions tutorial_compiler_flags)
if(TARGET SqrtLibrary)
    list(APPEND installable_libs SqrtLibrary)       
endif()


install(
    TARGETS ${installable_libs}
    EXPORT MathFunctionsTargets
    DESTINATION lib
       )


# 生成导出的库，方便上层引用 
# export(EXPORT MathFunctionsTargets
#         FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake")

include(CMakePackageConfigHelpers)

configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
  INSTALL_DESTINATION "lib/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )

  write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)
# install include headers
# install(FILES MathFunctions.h DESTINATION include)
target_include_directories(MathFunctions INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                            $<INSTALL_INTERFACE:include>)

install(EXPORT MathFunctionsTargets
        FILE MathFunctionsTargets.cmake
        DESTINATION lib/cmake/MathFunctions
                        )   
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake
  DESTINATION lib/cmake/MathFunctions
  )

export(EXPORT MathFunctionsTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
)