Often, it is not enough to only build an executable, it should also be installable. With CMake, we can specify install rules using the install() command. Supporting local installations for your builds in CMake is often as simple as specifying an install location and the targets and files to be installed
通常，仅仅构建一个可执行文件是不够的，它还应该是可安装的。使用CMake，我们可以使用install（）命令指定安装规则。在CMake中支持构建的本地安装通常很简单，只需指定安装位置以及要安装的目标和文件即可。
`cmake --install . `

The CMake variable CMAKE_INSTALL_PREFIX is used to determine the root of where the files will be installed. If using the cmake --install command, the installation prefix can be overridden via the --prefix argument.
`cmake --install . --prefix=''`
` cmake --build . --target install --config Debug`cmake --install . 默认是输出Release并且目录在C盘下(Windows)