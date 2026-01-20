@echo off
REM Build and run MoneyPay using Node.js on Windows

echo.
echo ============================================
echo   MoneyPay - Node.js Build
echo ============================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js is not installed!
    echo Download from: https://nodejs.org
    pause
    exit /b 1
)

echo ^✓ Node.js version: 
node --version

echo ^✓ npm version:
npm --version
echo.

REM Install backend dependencies
echo Installing backend dependencies...
cd backend
call npm install

if errorlevel 1 (
    echo ERROR: Backend installation failed
    pause
    exit /b 1
)

echo ^✓ Backend dependencies installed
echo.

REM Start the server
echo Starting backend server...
call npm start
