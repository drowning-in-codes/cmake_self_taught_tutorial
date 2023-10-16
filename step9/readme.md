cPack


cpack -G ZIP -C Debug
cpack --config CPackSourceConfig.cmake
NSIS needed

`
include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")
include(CPack)`
配置好后,cmake --build . 构建后会生成`CPackSourceConfig.cmake`等类似的pack文件,然后使用`cpack`打包