@echo off
REM Music Platform Tomcat Control Script
REM This script starts the Tomcat server with proper Java configuration

setlocal enabledelayedexpansion

REM Set Java and Tomcat paths
set JAVA_HOME=C:\Program Files\Java\jdk-24
set CATALINA_HOME=C:\tomcat\apache-tomcat-10.1.24

REM Verify paths exist
if not exist "%JAVA_HOME%" (
    echo ERROR: JAVA_HOME not found at %JAVA_HOME%
    pause
    exit /b 1
)

if not exist "%CATALINA_HOME%" (
    echo ERROR: CATALINA_HOME not found at %CATALINA_HOME%
    pause
    exit /b 1
)

echo.
echo ========================================
echo  Music Platform Tomcat Server Control
echo ========================================
echo.
echo JAVA_HOME:     %JAVA_HOME%
echo CATALINA_HOME: %CATALINA_HOME%
echo.
echo 1. Start Tomcat
echo 2. Stop Tomcat
echo 3. Check Status
echo 4. View Logs
echo 5. Exit
echo.

set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto stop
if "%choice%"=="3" goto status
if "%choice%"=="4" goto logs
if "%choice%"=="5" goto end

echo Invalid choice!
pause
goto end

:start
echo.
echo Starting Tomcat...
call "%CATALINA_HOME%\bin\startup.bat"
timeout /t 10
echo.
echo Open browser to: http://localhost:8080
echo.
pause
goto end

:stop
echo.
echo Stopping Tomcat...
call "%CATALINA_HOME%\bin\shutdown.bat"
timeout /t 5
echo.
echo Tomcat stopped.
echo.
pause
goto end

:status
echo.
echo Checking Tomcat status...
tasklist | findstr "java.exe" >nul
if errorlevel 1 (
    echo ✗ Tomcat is NOT running
) else (
    echo ✓ Tomcat is RUNNING
)
echo.
pause
goto end

:logs
echo.
echo Latest Tomcat logs:
echo.
type "%CATALINA_HOME%\logs\catalina.log" | tail -n 20
if errorlevel 1 (
    echo Logs directory: %CATALINA_HOME%\logs
)
echo.
pause
goto end

:end
echo.
echo Goodbye!
