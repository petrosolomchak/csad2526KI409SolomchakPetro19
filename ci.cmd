@echo off

SET CMAKE_OPTIONS=-DBUILD_TESTING=ON

REM Створення каталогу білдування та перехід до нього
mkdir build
cd build
if errorlevel 1 goto :error_cd

REM Конфігурування проекту за допомогою CMake
cmake .. %CMAKE_OPTIONS%
if errorlevel 1 goto :error_cmake_config

REM Білдування проекту (включаючи конфігурацію Release для Windows)
cmake --build . --config Release
if errorlevel 1 goto :error_cmake_build

REM Запуск тестів за допомогою CTest
ctest --output-on-failure --build-config Release
if errorlevel 1 goto :error_ctest

goto :eof

:error_cd
echo Помилка переходу в каталог build.
goto :eof

:error_cmake_config
echo Помилка конфігурування CMake.
goto :eof

:error_cmake_build
echo Помилка збірки проекту.
goto :eof

:error_ctest
echo Тести провалено.
goto :eof
