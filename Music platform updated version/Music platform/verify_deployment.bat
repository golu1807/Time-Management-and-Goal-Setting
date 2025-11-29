@echo off
setlocal enabledelayedexpansion

REM Wait for Tomcat to fully start
timeout /t 3 /nobreak

REM Test HTTP connection
powershell -Command "$response = Invoke-WebRequest 'http://localhost:8080/' -UseBasicParsing -ErrorAction SilentlyContinue; if ($response) { Write-Host 'Server Status: UP (200)' } else { Write-Host 'Server Status: Not responding yet' }" > deployment_status.txt 2>&1

REM Test registration
set EMAIL=testuser_%date:~-4,4%%time:~0,2%%time:~3,2%%time:~6,2%@music.com
set EMAIL=%EMAIL: =0%

powershell -Command "$formData = @{ name='TestUser'; email='test@example.com'; password='Test@123'; role='listener' }; try { $r = Invoke-WebRequest -Uri 'http://localhost:8080/register' -Method POST -Body $formData -UseBasicParsing; Write-Host 'Registration: SUCCESS (200)' } catch { $code = $_.Exception.Response.StatusCode; Write-Host \"Registration: FAILED ($code)\" }" >> deployment_status.txt 2>&1

REM Show results
type deployment_status.txt

echo.
echo Deployment completed! Check above for results.
echo Open http://localhost:8080 in browser to test manually.
pause
