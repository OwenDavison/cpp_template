cmake_minimum_required(VERSION 2.8)

project(my_project)

set(CMAKE_EXPORT_COMPILE_COMMANDS "ON")

# General
###############################################################################
# Activate C++0x support (if you encounter gmock errors, use 1.6.0 version)
add_definitions(-std=c++0x)

# Extra warnings
add_definitions(-Wextra)
add_definitions(-Wall)

# Google Mock & Test
###############################################################################
set(GMOCK_ROOT "${CMAKE_SOURCE_DIR}/lib/gmock-1.7.0")
#add_subdirectory(${GMOCK_ROOT})
include_directories(${GMOCK_ROOT}/include)
include_directories(${GMOCK_ROOT}/gtest/include)
link_directories(${GMOCK_ROOT}/build)
link_directories(${GMOCK_ROOT}/build/gtest)

# Main program executable
###############################################################################
set(EXECUTABLE_NAME "program")

# Source files
file(GLOB SRC_FILES "src/*.cpp")

# Executable dependencies
if(SRC_FILES)
    add_executable("${EXECUTABLE_NAME}" ${SRC_FILES}) 
endif(SRC_FILES)

# Set link libraries
# target_link_libraries($EXECUTABLE_NAME ...)

# Tests executable
###############################################################################
enable_testing()

add_executable(testall test/ExampleTest.cpp)
target_link_libraries(testall gmock gtest_main pthread)

add_test(thetest testall)

#set(TEST_EXECUTABLE_NAME "tests")
#
## Test files
#file(GLOB TEST_FILES "test/*.cpp")
#
## Don't include Main.cpp from src
#file(GLOB MAIN_SRC "src/Main.cpp")
#list(REMOVE_ITEM SRC_FILES ${MAIN_SRC})
#
#add_executable("${TEST_EXECUTABLE_NAME}" ${TEST_FILES} ${SRC_FILES})
#
## Set link libraries (order matters)
#target_link_libraries("${TEST_EXECUTABLE_NAME}" gmock gtest pthread)

# Include root directory
include_directories(BEFORE ".")
include_directories(BEFORE "src/")

