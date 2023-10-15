在本节中，我们将展示BUILD_SHARED_LIBS变量如何用于控制add_library（）的默认行为，并允许控制如何构建没有显式类型（STATIC、SHARED、MODULE或OBJECT）的库。
CMAKE_ARCHIVE_OUTPUT_DIRECTORY：默认存放静态库的文件夹位置；
CMAKE_LIBRARY_OUTPUT_DIRECTORY：默认存放动态库的文件夹位置；
LIBRARY_OUTPUT_PATH：默认存放库文件的位置，如果产生的是静态库并且没有指定 CMAKE_ARCHIVE_OUTPUT_DIRECTORY 则存放在该目录下，动态库也类似；
CMAKE_RUNTIME_OUTPUT_DIRECTORY：存放可执行软件的目录

set_target_properties(SqrtLibrary PROPETIES POSITION_INDEPENDENT_CODES ${BUILD_SHARED_LIBS})
At this point, if you build everything, you may notice that linking fails as we are combining a static library without position independent code with a library that has position independent code. The solution to this is to explicitly set the POSITION_INDEPENDENT_CODE target property of SqrtLibrary to be True when building shared libraries.
也就是将静态库链接啊都到动态库时报需要设置POSITION_INDEPENDENT_CODE 
option(BUILD_SHARED_LIBS "Build using shared libraries" ON)可以在cmake文件中访问同时在cmake -D中设置
target_compile_definitions可以在cpp文件中使用宏
本章设置了是用静态库还是动态库 如果在windows上导出动态库还涉及到
__declspec(dllexport)和__declspec(dllimport)
https://blog.csdn.net/yaotuzhi/article/details/108037549