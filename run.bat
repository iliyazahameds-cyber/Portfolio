@echo off
TITLE Portfolio App Runner
echo ==========================================
echo    PERSONAL PORTFOLIO APP RUNNER
echo ==========================================
echo.

:: Set local node path
set LOCAL_NODE_PATH=%~dp0nodejs\node-v24.15.0-win-x64
set PATH=%LOCAL_NODE_PATH%;%PATH%

:: Check for Node.js (prefer local, then system)
if exist "%LOCAL_NODE_PATH%\node.exe" (
    echo [INFO] Using local Node.js runtime.
) else (
    where node >nul 2>nul
    if %ERRORLEVEL% neq 0 (
        echo [ERROR] Node.js is not installed and local runtime not found.
        echo Please install Node.js from https://nodejs.org/
        pause
        exit /b
    )
    echo [INFO] Using system Node.js.
)

echo [INFO] Starting Backend Setup...
echo.

cd backend

:: Check if node_modules exists
if not exist node_modules (
    echo [INFO] Installing backend dependencies...
    call npm install
)

echo [INFO] Starting backend server on http://localhost:5000...
start /B node server.js

echo [INFO] Opening frontend...
start ../portfolio/index.html

echo.
echo ==========================================
echo    APP IS RUNNING!
echo    Backend: http://localhost:5000
echo    Frontend: Opened in your browser
echo ==========================================
echo.
echo Press any key to stop the backend server and exit.
pause >nul

:: Kill the node process on exit
taskkill /F /IM node.exe >nul 2>nul
echo Done.
