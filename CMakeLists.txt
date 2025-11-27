cmake_minimum_required(VERSION 3.14)
project(csad2526KI409SolomchakPetro19 VERSION 1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 1. Створення бібліотеки для функціоналу (math_operations)
set(MATH_SOURCES ${CMAKE_SOURCE_DIR}/math_operations.cpp)
add_library(MathOperationsLib STATIC ${MATH_SOURCES})
# math_operations.h знаходиться в корені, тому додаємо кореневий каталог як include path
target_include_directories(MathOperationsLib PUBLIC ${CMAKE_SOURCE_DIR})

# 2. Основний виконуваний файл
# Цей список повинен містити лише основні файли, якщо вони є (наприклад, main.cpp)
set(PROJECT_SOURCES ) 
# Якщо у вас є файл main.cpp або інші джерела програми, додайте їх:
# set(PROJECT_SOURCES main.cpp) 

if(PROJECT_SOURCES)
    add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
    target_link_libraries(${PROJECT_NAME} PRIVATE MathOperationsLib)
    target_include_directories(${PROJECT_NAME} PRIVATE include)
endif()

# Default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# 3. Налаштування тестів
option(BUILD_TESTING "Build tests" ON)
if(BUILD_TESTING)
    enable_testing()
    include(FetchContent)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG v1.14.0
    )
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    # Створення тестового виконуваного файлу
    add_executable(unit_tests ${CMAKE_SOURCE_DIR}/tests/unit_tests.cpp)
    
    # Лінкуємо до MathOperationsLib (для функціоналу) та GTest::gtest_main (для фреймворку)
    target_link_libraries(unit_tests PRIVATE MathOperationsLib GTest::gtest_main)

    # Додаємо шлях до заголовків, де компілятор шукатиме math_operations.h
    target_include_directories(unit_tests PRIVATE ${CMAKE_SOURCE_DIR})

    add_test(NAME unit_tests COMMAND unit_tests)
endif()

# Install rules (optional)
if(TARGET ${PROJECT_NAME})
    install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin OPTIONAL)
endif()
