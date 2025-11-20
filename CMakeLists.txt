cmake_minimum_required(VERSION 3.10)
project(csad2526KI409SolomchakPetro19 VERSION 1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Collect source files from src/ and project root
file(GLOB_RECURSE PROJECT_SOURCES CONFIGURE_DEPENDS
    src/*.cpp src/*.c src/*.cc src/*.cxx
    *.cpp *.c *.cc *.cxx
)

if(NOT PROJECT_SOURCES)
    message(WARNING "No source files found in src/ or project root. Add sources or update CMakeLists.txt")
endif()

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})

target_include_directories(${PROJECT_NAME} PRIVATE include)

# Default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

option(BUILD_TESTING "Build tests" OFF)
if(BUILD_TESTING)
    enable_testing()
    add_subdirectory(test)
endif()
