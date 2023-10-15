CheckCXXSourceCompiles

检查代码能否通过编译
`  include(CheckCXXSourceCompiles)
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
  " HAVE_EXP)`

  如果能通过,设置一个变量,然后条件编译(通过add_compile_definitions或target_compile_definitions添加宏定义)
target_compile_definitions()
`target_compile_definitions(SqrtLibrary
                               PRIVATE "HAVE_LOG" "HAVE_EXP"
                               )`
添加宏定义