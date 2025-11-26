cmake_minimum_required(VERSION 3.14)
project(csad2526KI409SolomchakPetro19 VERSION 1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Collect source files for the main executable (exclude tests)
file(GLOB_RECURSE PROJECT_SOURCES CONFIGURE_DEPENDS
    src/*.cpp src/*.c src/*.cc src/*.cxx
    *.cpp *.c *.cc *.cxx
)

# Main executable (if sources exist)
if(PROJECT_SOURCES)
    add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
    target_include_directories(${PROJECT_NAME} PRIVATE include)
endif()

# math_operations module (explicit source)
set(MATH_SOURCES ${CMAKE_SOURCE_DIR}/math_operations.cpp)

# Default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# Option to build tests
option(BUILD_TESTING "Build tests" ON)
if(BUILD_TESTING)
    enable_testing()
    include(FetchContent)
    FetchContent_Declare(
      googletest
      GIT_REPOSITORY https://github.com/google/googletest.git
      GIT_TAG release-1.14.0
    )
    # For Windows: Prevent overriding the parent project's compiler/linker settings
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    # Create test executable
    add_executable(unit_tests ${CMAKE_SOURCE_DIR}/tests/unit_tests.cpp ${MATH_SOURCES})
    target_include_directories(unit_tests PRIVATE ${CMAKE_SOURCE_DIR})
    target_link_libraries(unit_tests PRIVATE gtest_main)

    add_test(NAME unit_tests COMMAND unit_tests)
endif()

# Install rules (optional)
if(TARGET ${PROJECT_NAME})
    install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin OPTIONAL)
endif()