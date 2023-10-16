The EXPORT keyword generates a CMake file containing code to import all targets listed in the install command from the installation tree. 

EXPORT关键字生成一个CMake文件，该文件包含从安装树导入install命令中列出的所有目标的代码。

CMAKE_CURRENT_LIST_DIR:当 CMake 处理项目中的列表文件时，此变量将始终设置为当前正在处理的列表文件 (CMAKE_CURRENT_LIST_FILE) 所在的目录

这一章是为了导出自己的包以及进行配置
首先,设置需要安装的Targets,然后将其EXPORT导出
`install(TARGETS ${installable_libs}
        EXPORT MathFunctionsTargets
        DESTINATION lib)`注意,并不会生成MathFunctionsTargets.cmake文件,需要直接使用install(EXPORT)
        `install(EXPORT MathFunctionsTargets
  FILE MathFunctionsTargets.cmake
  DESTINATION lib/cmake/MathFunctions
)`

`
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
  INSTALL_DESTINATION "lib/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )`
此外还需要一个config文件
config_package_config_file（）。此命令将配置提供的文件，但与标准的configure_file（）方式有一些特定的区别。为了正确使用此函数，输入文件除了需要的内容外，还应该有一行文本@PACKAGE_INIT@。该变量将替换为一个代码块，该代码块将设置值转换为相对路径。
将一个模板文件写入到一个配置文件

`write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)`写入包版本信息
此命令写入find_package（）使用的文件，记录所需包的版本和兼容性。在这里，我们使用Tutorial_VERSION_*变量，并表示它与AnyNewerVersion兼容，这表示此版本或任何更高版本与请求的版本兼容。

最后设置下载文件
`install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake
  DESTINATION lib/cmake/MathFunctions
  )`下载文件到本地


当把配置文件和版本文件和targets文件配置后,导出并下载文件targets
使用find_package()查找相关库和头文件

我们已经为我们的项目生成了一个可重用的CMake配置，该配置可以在项目安装或打包后使用
如果我们希望我们的项目也能从构建目录中使用，我们只需要将以下内容添加到顶级CMakeLists.txt的底部,这样能生成${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake文件用于使用build
`export(EXPORT MathFunctionsTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
)`
