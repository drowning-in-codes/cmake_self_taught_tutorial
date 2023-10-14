[CMake Tutorial — CMake 3.28.0-rc1 Documentation](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)官方tutorial
在Windows上开发c++相比Linux还是有点不方便,这里介绍CMake,跨平台的构建工具.

在Windows上可选择的构建后端有vs,codeblocks这种软件的文件结构,或者单纯的Makefiles以及Ninja.相当于忽略了几个项目构建的差异.

<img src="https://i.imgur.com/0mXZUbA.png" alt="image-20231013105520974" style="zoom:50%;" />

## 常用变量

` PROJECT_BINARY_DIR`

编译生成项目的目录

` PROJECT_SOURCE_DIR`

顶层目录

`EXECUTABLE_OUTPUT_PATH `以及`LIBRARY_OUTPUT_PATH`

分别用来重新定义最终结果的存放目录

`CMAKE_ARCHIVE_OUTPUT_DIRECTORY`：默认存放静态库的文件夹位置；

`CMAKE_LIBRARY_OUTPUT_DIRECTORY`：默认存放动态库的文件夹位置；

`LIBRARY_OUTPUT_PATH`：默认存放库文件的位置，如果产生的是静态库并且没有指定 CMAKE_ARCHIVE_OUTPUT_DIRECTORY 则存放在该目录下，动态库也类似；

`CMAKE_RUNTIME_OUTPUT_DIRECTORY`：存放可执行软件的目录；

`CMAKE_CXX_FLAGS`和`CMAKE_C_FLAGS`

设置C/ C++编译选项,`CMAKE_C_COMPILER `设置对应编译器路径.

`BUILD_SHARED_LIBS`

用来控制默认的库编译方式,如果不进行设置,使用ADD_LIBRARY 并没有指定库类型的情况下,默认编译生成的库都是静态库.

此外还有一些系统信息

![image-20231013163518609](https://i.imgur.com/cozY007.png)

使用$ENV{}调用系统变量.

## 指定生成程序

```cmake
add_library(<name> [STATIC | SHARED | MODULE]
            [EXCLUDE_FROM_ALL]
            source1 [source2 ...])
```

将源码source构建成一个库， 供他人使用

`[STATIC | SHARED | MODULE]` ：类型有三种

```cmake
add_executable(< name> [WIN32] [MACOSX_BUNDLE]
                [EXCLUDE_FROM_ALL]  source1 source2 … sourceN)
```

使用给定的源文件，为工程引入一个可执行文件。引入一个名为< name>的可执行目标，该目标会由调用该命令时在源文件列表中指定的源文件来构建

## 添加头文件目录和库

```cmake
include_directories([AFTER|BEFORE] [SYSTEM]  dir1  dir2 ...)
target_include_directories()
```

将给定目录 dir1 dir2 加给编译器搜索到的包含文件 .默认情况下，加到目录列表的最后,target_include_directories可以指定针对目标文件添加头文件目录.

```cmake
target_link_libraries(<target> [item1] [item2] [...]
                      [[debug|optimized|general] <item>] ...)
```

该指令的作用为将目标文件与库文件进行链接。

上述指令中的`<target>`是指通过add_executable()和add_library()指令生成已经创建的目标文件.

可以使用`<a>_FOUND`检查是否通过find加载成功,之后使用target_link_libraries连接.



## find_package&find_path&find_library

find_path和find_library分别用来找头文件和库.找到之后可以使用include_directory或者target_link_libraries用来使用.

```cmake
FIND_PATH(myCeres NAMES ceress.h PATHS /ceres/include/ceres NO_DEFAULT_PATH)
INCLUDE_DIRECTORIES(${myCeres})
```

## 编译时消息输出

```cmake
MESSAGE(STATUS "HELLO")
```



## 设置变量

```cmake
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/x86)
```

set设置变量,后续使用${}使用变量

## 控制结构

if elseif else endif

文件中可以使用条件,循环等控制语句.可以用来判断构建时系统的一些环境.

比如

```cmake
# include dynamic link path
if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86")
    link_directories(${CMAKE_CURRENT_SOURCE_DIR}/../nwpu_std_msgs/lib/x86)
    link_directories(${CMAKE_CURRENT_SOURCE_DIR}/../nwpucutils/lib/x86)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "arm")
    link_directories(${CMAKE_CURRENT_SOURCE_DIR}/../nwpu_std_msgs/lib/arm)
    link_directories(${CMAKE_CURRENT_SOURCE_DIR}/../nwpucutils/lib/arm)
endif()
```



## 添加其他子目录

```cmake
add_subdirectory(source_dir [binary_dir] [EXCLUDE_FROM_ALL] [SYSTEM])
```

**添加一个子目录并构建该子目录**。source_dir指定源CMakeLists.txt和代码文件所在的目录。

一般用在嵌套的项目中,顶层CMakeLists.txt文件添加子目录,让子目录先构建完成之后添加其中生成的库和头文件.



## 获取文件

```cmake
FILE (GLOB ALL_SOURCES "*.cpp" "*.c" "./AFolder/*.cpp" )
```

使用正则匹配响应文件并存到一个变量中

```cmake
aux_source_directory(dir VAR) 
```

发现一个目录下所有的**源代码文件**并将列表存储在一个变量中.

## vs中显示头文件

```cmake
file(GLOB_RECURSE pipe_header_files  ${CMAKE_CURRENT_SOURCE_DIR}/include/*.h )
source_group("Header Files" FILES ${pipe_header_files}) 
```

使用source_group增加文件

并添加到生成目标中

```cmake
add_library( lib_pipe_shared SHARED ${pipe_src} ${pipe_header_files})
```



## option与add_definitions

```cmake
option(<variable> "<help_text>" [value])
```

可以在cmake命令中指定该值.

而add_definition用于指定编译器参数，比如`add_definitions("-Wall -g")`,此外更推荐使用add_compile_definitions将预处理器定义添加到编译器命令行,使用add_compile_options命令添加其它选项。

比如下面文件,使用add_definition定义了TEST_DEBUG,option定义为OFF并在cmake执行时指定为on,然后在cmake文件中指定option为on,这样就执行了`add_definitions(-DTEST_DEBUG)`,定义了该宏.

```
#!/bin/sh

cmake -DTEST_DEBUG=ON .
cmake --build .

```

```cmake
project(test)

option(TEST_DEBUG "option for debug" OFF)
if (TEST_DEBUG)
add_definitions(-DTEST_DEBUG)
endif()
```

```c
#include "test.h"

#ifdef TEST_DEBUG
...
#endif
```



CMake中的命令特别多,事实上并不需要去一个一个记住,通常只要知道一个项目的大致构建流程以及可能需要的命令就行了.

### 参考资料

1. [cmake指令汇总_cmake命令大全_nuosen123的博客-CSDN博客](https://blog.csdn.net/llffss/article/details/120121617)
2. [C++静态库与动态库 | 菜鸟教程 (runoob.com)](https://www.runoob.com/w3cnote/cpp-static-library-and-dynamic-library.html)
3. [使用C++创建并调用动态链接库(dll) - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/578843962)
4. [CMake指令详解_cmake -d-CSDN博客](https://blog.csdn.net/Op_chaos/article/details/110476264?spm=1001.2101.3001.6650.7&utm_medium=distribute.pc_relevant.none-task-blog-2~default~CTRLIST~Rate-7-110476264-blog-120121617.235^v38^pc_relevant_anti_t3_base&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2~default~CTRLIST~Rate-7-110476264-blog-120121617.235^v38^pc_relevant_anti_t3_base&utm_relevant_index=11)
5. [VS的包含目录、库目录、引用目录、可执行目录解释_vs包含目录和引用目录-CSDN博客](https://blog.csdn.net/qq_25160757/article/details/79813428)
6. [cmake之Visual studio无法显示头文件 - mohist - 博客园 (cnblogs.com)](https://www.cnblogs.com/pandamohist/p/13674438.html)
7. [Linux之cmake的指令以及内部构建和外部构建_cmake 外部编译-CSDN博客](https://blog.csdn.net/sandalphon4869/article/details/100589747)
8. [cmake 常用变量和常用环境变量 - 小果子啊 - 博客园 (cnblogs.com)](https://www.cnblogs.com/guoshuai-ouc/p/cmake_variable.html)
9. [【CMake】CMakeLists.txt的超傻瓜手把手教程（附实例源码）_【cmake】cmakelists.txt的超傻瓜手把手教程(附实例源码)-CSDN博客](https://blog.csdn.net/qq_38410730/article/details/102477162)
10. [make的link_directories命令不起作用-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/243229#:~:text=官网不推荐使用l,aries使用。)
11. [CMake Reference Documentation — CMake 3.28.0-rc1 Documentation](https://cmake.org/cmake/help/latest/)
12. [CMakeLists.txt 语法介绍与实例演练-CSDN博客](https://blog.csdn.net/afei__/article/details/81201039)