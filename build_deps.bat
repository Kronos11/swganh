@echo off
setlocal EnableDelayedExpansion

rem Initialize environment variable defaults
call :SET_DEFAULTS

rem Build the environment and bail out if it fails
call :BUILD_ENVIRONMENT
if x%environment_built% == x goto :eof

%PROJECT_DRIVE%
mkdir %BUILD_DIR%
cd %BUILD_DIR%

echo Build Dependencies - Preparing to build

rem Uncomment once parameters are read, only delete in clean mode
rem cmd /c rd %VENDOR_DIR% /s /q

call :BUILD_BOOST
call :BUILD_TURTLE
call :BUILD_GLM
call :BUILD_ZLIB
call :BUILD_MYSQL_CONNECTOR_C
call :BUILD_MYSQL_CONNECTOR_CPP

rem ----------------------------------------------------------------------------
rem --- Start of SET_DEFAULTS --------------------------------------------------
:SET_DEFAULTS

set "PROJECT_BASE=%~dp0"
set "PROJECT_DRIVE=%~d0"
set "BUILD_DIR=%PROJECT_BASE%build-deps\"
set "VENDOR_DIR=%PROJECT_BASE%vendor\"
set MSVC_VERSION=11
set BOOST_VERSION=1.52.0
set TURTLE_VERSION=1.2.0
set GLM_VERSION=0.9.4.1
set ZLIB_VERSION=1.2.7
set MYSQL_C_VERSION=6.0.2
set "WGET=%PROJECT_BASE%tools\windows\wget.exe"
set "ZIP=%PROJECT_BASE%tools\windows\7z.exe"

goto :eof
rem --- End of SET_DEFAULTS ----------------------------------------------------
rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
rem --- Start of BUILD_ENVIRONMENT ---------------------------------------------
:BUILD_ENVIRONMENT

if not exist "%VS110COMNTOOLS%" (
    echo ***** Microsoft Visual Studio 11 required *****
    exit /b 1
)

call "%VS110COMNTOOLS%\vsvars32.bat" >NUL

set environment_built=yes

goto :eof
rem --- End of BUILD_ENVIRONMENT -----------------------------------------------
rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
rem --- Start of BUILD_BOOST ---------------------------------------------------
rem --- Builds the boost library for use with this project. ---
:BUILD_BOOST

echo BUILDING: Boost %BOOST_VERSION% - http://www.boost.org/

set BOOST_VERSION_ALT=!BOOST_VERSION:.=_!
set BOOST_FILE=boost_%BOOST_VERSION_ALT%.zip
set BOOST_URL=http://downloads.sourceforge.net/project/boost/boost/%BOOST_VERSION%/%BOOST_FILE%
set BOOST_DIR=boost_%BOOST_VERSION_ALT%

if not exist %BOOST_FILE% (
    %WGET% --no-check-certificate !BOOST_URL!
)

if not exist %BOOST_DIR% (
    %ZIP% x -y %BOOST_FILE%
)

if not exist boost-log (
    svn co https://boost-log.svn.sourceforge.net/svnroot/boost-log/trunk/boost-log/ -r 799
)

if not exist "%BOOST_DIR%\boost\log" (
    xcopy "boost-log/boost/log" "%BOOST_DIR%/boost/log" /s /i /y
    xcopy "boost-log/libs/log" "%BOOST_DIR%/libs/log" /s /i /y
)

cd "%BOOST_DIR%"

if not exist b2.exe (
    cmd /c bootstrap.bat
)

cmd /c "b2.exe" --toolset=msvc-%MSVC_VERSION%.0 --with-program_options --with-system --with-thread --with-filesystem --with-log --with-python --with-test --with-date_time variant=debug,release link=shared runtime-link=shared threading=multi define=_SCL_SECURE_NO_WARNINGS=0 define=_ITERATOR_DEBUG_LEVEL=0

if not exist %VENDOR_DIR%include\boost (
    xcopy "boost" "%VENDOR_DIR%include\boost" /s /i /y
    xcopy "stage/lib" "%VENDOR_DIR%lib" /s /i /y
)

cd "%BUILD_DIR%"

goto :eof
rem --- End of BUILD_BOOST -----------------------------------------------------
rem ----------------------------------------------------------------------------


rem ----------------------------------------------------------------------------
rem --- Start of BUILD_TURTLE --------------------------------------------------
rem --- Builds the turtle library for use with this project. ---
:BUILD_TURTLE

echo BUILDING: Turtle %TURTLE_VERSION% - http://turtle.sourceforge.net/

set TURTLE_FILE=turtle-%TURTLE_VERSION%.zip
set TURTLE_URL=http://downloads.sourceforge.net/project/turtle/turtle/%TURTLE_VERSION%/%TURTLE_FILE%
set TURTLE_DIR=turtle-%TURTLE_VERSION%

if not exist %TURTLE_FILE% (
    %WGET% --no-check-certificate !TURTLE_URL!
)

if not exist "%VENDOR_DIR%include\turtle" (
    %ZIP% x -y %TURTLE_FILE% -O%VENDOR_DIR%
    del %VENDOR_DIR%README.txt
)

cd "%BUILD_DIR%"

goto :eof
rem --- End of BUILD_TURTLE ----------------------------------------------------
rem ----------------------------------------------------------------------------


rem ----------------------------------------------------------------------------
rem --- Start of BUILD_GLM -----------------------------------------------------
rem --- Builds the glm library for use with this project. ---
:BUILD_GLM

echo BUILDING: GLM %GLM_VERSION% - http://glm.g-truc.net/

set GLM_FILE=glm-%GLM_VERSION%.zip
set GLM_URL=http://downloads.sourceforge.net/project/ogl-math/glm-%GLM_VERSION%/%GLM_FILE%
set GLM_DIR=glm-%GLM_VERSION%

if not exist %GLM_FILE% (
    %WGET% --no-check-certificate !GLM_URL!
)

if not exist "%VENDOR_DIR%include\glm" (
    %ZIP% x -y %GLM_FILE% -Oglm
    xcopy "glm\glm" "%VENDOR_DIR%include\glm" /s /i /y
)

cd "%BUILD_DIR%"

goto :eof
rem --- End of BUILD_GLM -------------------------------------------------------
rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
rem --- Start of BUILD_ZLIB ----------------------------------------------------
rem --- Builds the zlib library for use with this project.                   ---
:BUILD_ZLIB

echo BUILDING: zlib %ZLIB_VERSION% - http://www.zlib.net/

set ZLIB_VERSION_ALT=!ZLIB_VERSION:.=!
set ZLIB_FILE=zlib%ZLIB_VERSION_ALT%.zip
set ZLIB_URL=http://zlib.net/%ZLIB_FILE%
set ZLIB_DIR=zlib-%ZLIB_VERSION%

if not exist %ZLIB_FILE% (
    %WGET% --no-check-certificate !ZLIB_URL!
)

if not exist "%ZLIB_DIR%" (
    %ZIP% x -y %ZLIB_FILE%
)

cd "%ZLIB_DIR%"

cmake -G"Visual Studio 11" .
cmake --build . --target zlib --config Debug
cmake --build . --target zlib --config Release

if not exist "%VENDOR_DIR%include\zlib.h" (
    xcopy "zlib.h" "%VENDOR_DIR%include" /s /i /y
    xcopy "zconf.h" "%VENDOR_DIR%include" /s /i /y
    xcopy "Debug" "%VENDOR_DIR%lib\Debug" /s /i /y
    xcopy "Release" "%VENDOR_DIR%lib\Release" /s /i /y
)

cd "%BUILD_DIR%"

goto :eof
rem --- End of BUILD_ZLIB ------------------------------------------------------
rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
rem --- Start of BUILD_MYSQL_CONNECTOR_C ---------------------------------------
rem --- Builds the mysql connector c library for use with this project. --------
:BUILD_MYSQL_CONNECTOR_C

echo BUILDING: Mysql Connector-C %MYSQL_C_VERSION% - http://mysql.com/

set MYSQL_C_FILE=mysql-connector-c-%MYSQL_C_VERSION%.zip
set MYSQL_C_URL=http://dev.mysql.com/get/Downloads/Connector-C/%MYSQL_C_FILE%/from/http://cdn.mysql.com/
set MYSQL_C_DIR=mysql-connector-c-%MYSQL_C_VERSION%
set MYSQL_C_CMAKE=%MYSQL_C_DIR%\CMakeLists.txt
if not exist %MYSQL_C_FILE% (
    %WGET% --no-check-certificate !MYSQL_C_URL!
)

if not exist "%MYSQL_C_DIR%" (
    %ZIP% x -y %MYSQL_C_FILE%

    set search=STRING(REPLACE "/MD"
    set replacement=# STRING(REPLACE "/MD"

    for /f "tokens=* delims=," %%A in ('"type %MYSQL_C_DIR%\CMakeLists.txt"') do (
        set "str=%%A"
        set str=!str:STRING(REPLACE "/MD=# STRING(REPLACE "/MD!
        echo.!str! >> %MYSQL_C_CMAKE%.tmp
    )

    if exist %MYSQL_C_CMAKE%.tmp (
        del %MYSQL_C_CMAKE%
        move %MYSQL_C_CMAKE%.tmp %MYSQL_C_CMAKE%
    )
)

cd "%MYSQL_C_DIR%"

cmake .
cmake --build . --target mysqlclient --config Debug
cmake --build . --target libmysql --config Debug
cmake --build . --target mysqlclient --config Release
cmake --build . --target libmysql --config Release

if not exist "%VENDOR_DIR%include\mysql.h" (
    xcopy "include" "%VENDOR_DIR%include" /s /i /y
    xcopy "libmysql/Debug" "%VENDOR_DIR%lib/Debug" /s /i /y
    xcopy "libmysql/Release" "%VENDOR_DIR%lib/Release" /s /i /y
)

cd "%BUILD_DIR%"

goto :eof
rem --- End of BUILD_MYSQL_CONNECTOR_C -----------------------------------------
rem ----------------------------------------------------------------------------

rem ----------------------------------------------------------------------------
rem --- Start of BUILD_MYSQL_CONNECTOR_CPP -------------------------------------
rem --- Builds the mysql connector c++ library for use with this project. ------
:BUILD_MYSQL_CONNECTOR_CPP

echo BUILDING: Mysql Connector-C++ - http://mysql.com/

if not exist mysql-connector-cpp (
    git clone https://github.com/anhstudios/mysql-connector-cpp.git
)

cd mysql-connector-cpp

cmake -G"Visual Studio 11" -DDISABLE_ITERATOR_DEBUGGING=ON -DBOOST_ROOT=%VENDOR_DIR% -DMYSQL_INCLUDE_DIR=%VENDOR_DIR%include -DMYSQL_LIB_DIR=%VENDOR_DIR%lib/Release .
cmake --build . --target mysqlcppconn --config Debug
cmake --build . --target mysqlcppconn --config Release

if not exist "%VENDOR_DIR%include\cppconn" (
    xcopy "cppconn" "%VENDOR_DIR%include\cppconn" /s /i /y
    xcopy "driver\mysql_driver.h" "%VENDOR_DIR%include" /s /i /y
    xcopy "driver\mysql_connection.h" "%VENDOR_DIR%include" /s /i /y
    xcopy "driver\Debug" "%VENDOR_DIR%lib\Debug" /s /i /y
    xcopy "driver\Release" "%VENDOR_DIR%lib\Release" /s /i /y
)

cd "%BUILD_DIR%"

goto :eof
rem --- End of BUILD_MYSQL_CONNECTOR_CPP ---------------------------------------
rem ----------------------------------------------------------------------------
