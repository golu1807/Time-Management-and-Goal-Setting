# Music Platform - Tomcat Control Script (PowerShell)
# Usage: .\tomcat_control.ps1

param(
    [string]$Action = "menu"
)

$JAVA_HOME = "C:\Program Files\Java\jdk-24"
$CATALINA_HOME = "C:\tomcat\apache-tomcat-10.1.24"
$WAR_SOURCE = "c:\Users\bipin\OneDrive\Desktop\projects\Music platform\Music platform\target\music-streaming-platform-1.0-SNAPSHOT.war"
$WAR_DEST = "$CATALINA_HOME\webapps\ROOT.war"
$LOG_FILE = "$CATALINA_HOME\logs\catalina.log"

# Set environment variables
$env:JAVA_HOME = $JAVA_HOME
$env:CATALINA_HOME = $CATALINA_HOME

function Show-Menu {
    Clear-Host
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host "  Music Platform Tomcat Control" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Start Tomcat" -ForegroundColor Yellow
    Write-Host "2. Stop Tomcat" -ForegroundColor Yellow
    Write-Host "3. Restart Tomcat" -ForegroundColor Yellow
    Write-Host "4. Check Status" -ForegroundColor Yellow
    Write-Host "5. View Logs (last 20 lines)" -ForegroundColor Yellow
    Write-Host "6. Build & Deploy" -ForegroundColor Yellow
    Write-Host "7. Open in Browser" -ForegroundColor Yellow
    Write-Host "8. Show Configuration" -ForegroundColor Yellow
    Write-Host "9. Exit" -ForegroundColor Yellow
    Write-Host ""
}

function Start-TomcatServer {
    Write-Host "`n▶ Starting Tomcat..." -ForegroundColor Green
    Write-Host "JAVA_HOME: $JAVA_HOME" -ForegroundColor Gray
    Write-Host "CATALINA_HOME: $CATALINA_HOME" -ForegroundColor Gray
    
    # Check if already running
    $javaProcess = Get-Process -Name java -ErrorAction SilentlyContinue
    if ($javaProcess) {
        Write-Host "⚠ Java process already running (PID: $($javaProcess.Id))" -ForegroundColor Yellow
        $response = Read-Host "Kill existing process and start fresh? (y/n)"
        if ($response -eq 'y') {
            Stop-Process -Name java -Force -ErrorAction SilentlyContinue
            Start-Sleep -Seconds 2
        } else {
            Write-Host "Aborting. Server may already be running." -ForegroundColor Yellow
            return
        }
    }
    
    & "$CATALINA_HOME\bin\startup.bat"
    Write-Host ""
    Write-Host "Waiting for server to start (10 seconds)..." -ForegroundColor Cyan
    Start-Sleep -Seconds 10
    
    Write-Host "`n✅ Tomcat started!" -ForegroundColor Green
    Write-Host "Open: http://localhost:8080" -ForegroundColor Cyan
    Write-Host ""
}

function Stop-TomcatServer {
    Write-Host "`n⏹ Stopping Tomcat..." -ForegroundColor Green
    
    $javaProcess = Get-Process -Name java -ErrorAction SilentlyContinue
    if ($javaProcess) {
        & "$CATALINA_HOME\bin\shutdown.bat"
        Start-Sleep -Seconds 3
        
        $javaProcess = Get-Process -Name java -ErrorAction SilentlyContinue
        if ($javaProcess) {
            Write-Host "⚠ Graceful shutdown didn't work. Force killing..." -ForegroundColor Yellow
            Stop-Process -Name java -Force
            Start-Sleep -Seconds 2
        }
        
        Write-Host "✅ Tomcat stopped!" -ForegroundColor Green
    } else {
        Write-Host "ℹ Tomcat not running" -ForegroundColor Gray
    }
    Write-Host ""
}

function Restart-TomcatServer {
    Stop-TomcatServer
    Start-Sleep -Seconds 3
    Start-TomcatServer
}

function Show-Status {
    Write-Host "`n📊 Tomcat Status:" -ForegroundColor Cyan
    $javaProcess = Get-Process -Name java -ErrorAction SilentlyContinue
    
    if ($javaProcess) {
        Write-Host "✅ Status: RUNNING" -ForegroundColor Green
        Write-Host "   Process ID: $($javaProcess.Id)" -ForegroundColor Gray
        Write-Host "   Memory: $([math]::Round($javaProcess.WorkingSet / 1MB, 2)) MB" -ForegroundColor Gray
    } else {
        Write-Host "❌ Status: NOT RUNNING" -ForegroundColor Red
    }
    
    # Test HTTP connection
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8080" -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop
        Write-Host "✅ HTTP Port 8080: RESPONDING (Status: $($response.StatusCode))" -ForegroundColor Green
    } catch {
        Write-Host "❌ HTTP Port 8080: NOT RESPONDING" -ForegroundColor Red
    }
    
    Write-Host ""
}

function Show-Logs {
    Write-Host "`n📜 Recent Tomcat Logs:" -ForegroundColor Cyan
    Write-Host "-----------------------------------" -ForegroundColor Gray
    
    if (Test-Path $LOG_FILE) {
        Get-Content $LOG_FILE -Tail 20 | ForEach-Object {
            if ($_ -match "ERROR|WARN") {
                Write-Host $_ -ForegroundColor Yellow
            } else {
                Write-Host $_
            }
        }
    } else {
        Write-Host "No logs found yet." -ForegroundColor Gray
    }
    Write-Host "-----------------------------------" -ForegroundColor Gray
    Write-Host ""
}

function Build-AndDeploy {
    Write-Host "`n🔨 Building and Deploying..." -ForegroundColor Cyan
    
    # Navigate to project directory
    $projectDir = "c:\Users\bipin\OneDrive\Desktop\projects\Music platform\Music platform"
    Push-Location $projectDir
    
    # Build
    Write-Host "Building with Maven..." -ForegroundColor Yellow
    mvn clean package
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Build successful!" -ForegroundColor Green
        
        # Stop server
        Write-Host "Stopping Tomcat..." -ForegroundColor Yellow
        Stop-TomcatServer
        
        # Deploy
        Write-Host "Deploying WAR file..." -ForegroundColor Yellow
        if (Test-Path $WAR_SOURCE) {
            Copy-Item $WAR_SOURCE $WAR_DEST -Force
            Write-Host "✅ WAR deployed!" -ForegroundColor Green
            
            # Start server
            Start-TomcatServer
        } else {
            Write-Host "❌ WAR file not found at: $WAR_SOURCE" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Build failed!" -ForegroundColor Red
    }
    
    Pop-Location
    Write-Host ""
}

function Open-Browser {
    Write-Host "`n🌐 Opening Music Platform in browser..." -ForegroundColor Cyan
    Start-Process "http://localhost:8080"
    Write-Host ""
}

function Show-Configuration {
    Write-Host "`n⚙️  Configuration:" -ForegroundColor Cyan
    Write-Host "-----------------------------------" -ForegroundColor Gray
    Write-Host "JAVA_HOME:    $JAVA_HOME" -ForegroundColor Yellow
    Write-Host "CATALINA_HOME: $CATALINA_HOME" -ForegroundColor Yellow
    Write-Host "WAR Location: $WAR_SOURCE" -ForegroundColor Yellow
    Write-Host "Log Location: $LOG_FILE" -ForegroundColor Yellow
    Write-Host "URL:         http://localhost:8080" -ForegroundColor Yellow
    Write-Host "-----------------------------------" -ForegroundColor Gray
    
    # Verify paths
    Write-Host "`nPath Verification:" -ForegroundColor Cyan
    Write-Host "JAVA_HOME exists: $(if (Test-Path $JAVA_HOME) { '✅ YES' } else { '❌ NO' })" -ForegroundColor Gray
    Write-Host "CATALINA_HOME exists: $(if (Test-Path $CATALINA_HOME) { '✅ YES' } else { '❌ NO' })" -ForegroundColor Gray
    Write-Host "WAR file exists: $(if (Test-Path $WAR_SOURCE) { '✅ YES' } else { '❌ NO' })" -ForegroundColor Gray
    Write-Host ""
}

# Main logic
if ($Action -eq "start") {
    Start-TomcatServer
} elseif ($Action -eq "stop") {
    Stop-TomcatServer
} elseif ($Action -eq "restart") {
    Restart-TomcatServer
} elseif ($Action -eq "status") {
    Show-Status
} elseif ($Action -eq "logs") {
    Show-Logs
} elseif ($Action -eq "build") {
    Build-AndDeploy
} elseif ($Action -eq "open") {
    Open-Browser
} elseif ($Action -eq "config") {
    Show-Configuration
} else {
    while ($true) {
        Show-Menu
        $choice = Read-Host "Enter choice"
        
        switch ($choice) {
            "1" { Start-TomcatServer }
            "2" { Stop-TomcatServer }
            "3" { Restart-TomcatServer }
            "4" { Show-Status }
            "5" { Show-Logs }
            "6" { Build-AndDeploy }
            "7" { Open-Browser }
            "8" { Show-Configuration }
            "9" { Write-Host "`nGoodbye!`n" -ForegroundColor Cyan; exit }
            default { Write-Host "Invalid choice!" -ForegroundColor Red }
        }
        
        Read-Host "Press Enter to continue"
    }
}
