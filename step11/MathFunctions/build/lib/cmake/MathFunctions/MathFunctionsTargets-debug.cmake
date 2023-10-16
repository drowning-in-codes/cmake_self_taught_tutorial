#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "MathFunctions" for configuration "Debug"
set_property(TARGET MathFunctions APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(MathFunctions PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/MathFunctions.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/MathFunctions.dll"
  )

list(APPEND _cmake_import_check_targets MathFunctions )
list(APPEND _cmake_import_check_files_for_MathFunctions "${_IMPORT_PREFIX}/lib/MathFunctions.lib" "${_IMPORT_PREFIX}/lib/MathFunctions.dll" )

# Import target "SqrtLibrary" for configuration "Debug"
set_property(TARGET SqrtLibrary APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(SqrtLibrary PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/SqrtLibrary.lib"
  )

list(APPEND _cmake_import_check_targets SqrtLibrary )
list(APPEND _cmake_import_check_files_for_SqrtLibrary "${_IMPORT_PREFIX}/lib/SqrtLibrary.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
