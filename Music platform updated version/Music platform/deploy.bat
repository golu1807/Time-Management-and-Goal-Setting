@echo off
REM Comprehensive Music Platform Deployment Script
REM This script rebuilds and redeploys the application

setlocal enabledelayedexpansion

echo.
echo ================================
echo Music Platform Deployment Script
echo ================================
echo.

REM Set paths
set PROJECT_DIR=c:\Users\bipin\OneDrive\Desktop\projects\Music platform\Music platform
set TOMCAT_DIR=C:\tomcat\apache-tomcat-10.1.24
set JAVA_HOME=C:\Program Files\Java\jdk-24
set CATALINA_HOME=C:\tomcat\apache-tomcat-10.1.24

echo Step 1: Changing to project directory...
cd /d "%PROJECT_DIR%"
echo Current dir: %cd%
echo.

echo Step 2: Cleaning and building...
call mvn clean package -DskipTests
if errorlevel 1 (
    echo BUILD FAILED!
    pause
    exit /b 1
)
echo BUILD SUCCESS
echo.

echo Step 3: Stopping Tomcat...
call "%TOMCAT_DIR%\bin\shutdown.bat"
timeout /t 3 /nobreak
echo.

echo Step 4: Backing up old WAR...
if exist "%TOMCAT_DIR%\webapps\ROOT.war" (
    move "%TOMCAT_DIR%\webapps\ROOT.war" "%TOMCAT_DIR%\webapps\ROOT.war.bak"
    echo Backed up old WAR
)
echo.

echo Step 5: Deploying new WAR...
copy "%PROJECT_DIR%\target\music-streaming-platform-1.0-SNAPSHOT.war" "%TOMCAT_DIR%\webapps\ROOT.war"
echo WAR deployed
echo.

echo Step 6: Starting Tomcat...
set JAVA_HOME=C:\Program Files\Java\jdk-24
set CATALINA_HOME=C:\tomcat\apache-tomcat-10.1.24
call "%TOMCAT_DIR%\bin\startup.bat"
timeout /t 5 /nobreak
echo.

echo Step 7: Verifying deployment...
echo Testing HTTP connectivity...
powershell -Command "try { $r = Invoke-WebRequest 'http://localhost:8080/' -UseBasicParsing; Write-Host 'Server is UP!' } catch { Write-Host 'Server not responding' }"
echo.

echo ================================
echo Deployment Complete!
echo ================================
echo.
echo Access the application at: http://localhost:8080
echo.
pause
