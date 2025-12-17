# Test deployment script
Write-Host "Testing Music Platform Deployment"
Write-Host "===================================="
Write-Host ""

# Test 1: Check if Java process is running
Write-Host "1. Checking Java process..." -ForegroundColor Cyan
$javaProcess = Get-Process -Name java -ErrorAction SilentlyContinue
if ($javaProcess) {
    Write-Host "   ✅ Java process is running (PID: $($javaProcess.Id))" -ForegroundColor Green
} else {
    Write-Host "   ❌ Java process not found" -ForegroundColor Red
    exit 1
}

# Test 2: Check HTTP connectivity
Write-Host ""
Write-Host "2. Testing HTTP server..." -ForegroundColor Cyan
$response = Invoke-WebRequest "http://localhost:8080/" -UseBasicParsing -ErrorAction SilentlyContinue
if ($response -and $response.StatusCode -eq 200) {
    Write-Host "   ✅ HTTP server responding (Status: 200)" -ForegroundColor Green
} else {
    Write-Host "   ❌ HTTP server not responding" -ForegroundColor Red
}

# Test 3: Test registration
Write-Host ""
Write-Host "3. Testing registration servlet..." -ForegroundColor Cyan
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$testEmail = "test_$timestamp@music.com"
$formData = @{
    name = "Test User"
    email = $testEmail
    password = "Test123!"
    role = "listener"
}

try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/register" `
        -Method POST `
        -Body $formData `
        -UseBasicParsing `
        -ErrorAction Stop
    
    Write-Host "   ✅ Registration submitted successfully!" -ForegroundColor Green
    Write-Host "   📧 Test email: $testEmail" -ForegroundColor Cyan
} catch {
    $statusCode = $_.Exception.Response.StatusCode
    if ($statusCode -eq 500) {
        Write-Host "   ❌ Server error (500) - Database connection issue" -ForegroundColor Red
    } else {
        Write-Host "   ❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Test 4: Check logs for errors
Write-Host ""
Write-Host "4. Checking Tomcat logs for errors..." -ForegroundColor Cyan
$logFile = "C:\tomcat\apache-tomcat-10.1.24\logs\localhost.2025-11-28.log"
$errors = Get-Content $logFile | Select-String "SQLException|Access denied|Public Key|ERROR" | Select-Object -Last 5

if ($errors) {
    Write-Host "   ⚠️  Found errors in logs:" -ForegroundColor Yellow
    $errors | ForEach-Object { Write-Host "   - $_" -ForegroundColor Yellow }
} else {
    Write-Host "   ✅ No SQL/JDBC errors found" -ForegroundColor Green
}

Write-Host ""
Write-Host "===================================="
Write-Host "Test Complete" -ForegroundColor Cyan
