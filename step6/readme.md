in CMakeLists.txt
include(CTest)
...
add_test(NAME mytest COMMAND executable)
and build
`
mkdir build
cd build 
cmake ../
cmake --build ..
`

in ctest configure file CTestConfig.cmake 
`set(CTEST_PROJECT_NAME "CMakeTutorial")
set(CTEST_NIGHTLY_START_TIME "00:00:00 EST")

set(CTEST_DROP_METHOD "http")
set(CTEST_DROP_SITE "my.cdash.org")
set(CTEST_DROP_LOCATION "/submit.php?project=CMakeTutorial")
set(CTEST_DROP_SITE_CDASH TRUE)
`

`ctest [-VV] -C Debug -D Experimental` test and submit 
`ctest [-VV] -C Debug ` test 
