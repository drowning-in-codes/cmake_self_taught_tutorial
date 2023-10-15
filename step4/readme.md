A common usage of generator expressions is to conditionally add compiler flags, such as those for language levels or warnings. A nice pattern is to associate this information to an INTERFACE target allowing this information to propagate.

生成器表达式的一个常见用法是有条件地添加编译器标志，例如用于语言级别或警告的标志。一个不错的模式是将此信息与INTERFACE目标相关联，从而允许此信息传播。

Logical expressions are used to create conditional output. The basic expressions are the 0 and 1 expressions. A $<0:...> results in the empty string, and <1:...> results in the content of .... They can also be nested.-config Release`
Generator expressions may be used to enable conditional linking, conditional definitions used when compiling, conditional include directories and more. The conditions may be based on the build configuration, target properties, platform information or any other queryable information.
生成器表达式可用于启用条件链接、编译时使用的条件定义、条件包含目录等。条件可以基于构建配置、目标属性、平台信息或任何其他可查询信息。