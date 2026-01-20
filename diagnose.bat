@echo off
REM Diagnostic script to check if environment is set up correctly

echo.
echo ============================================================
echo        MoneyPay Environment Diagnostic
echo ============================================================
echo.

REM Check Node.js
echo Checking Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js NOT installed
    echo Download from: https://nodejs.org
    pause
    exit /b 1
) else (
    echo ✓ Node.js is installed
    node --version
)

REM Check npm
echo.
echo Checking npm...
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ npm NOT installed
    pause
    exit /b 1
) else (
    echo ✓ npm is installed
    npm --version
)

REM Check .env file
echo.
echo Checking backend\.env...
if exist "backend\.env" (
    echo ✓ backend\.env exists
    
    REM Check for MONGODB_URI
    findstr /M "MONGODB_URI" backend\.env >nul 2>&1
    if errorlevel 1 (
        echo ❌ MONGODB_URI not found in backend\.env
    ) else (
        echo ✓ MONGODB_URI found in backend\.env
    )
    
    REM Show file size
    for %%A in (backend\.env) do (
        echo 📄 File size: %%~zA bytes
    )
) else (
    echo ❌ backend\.env NOT found
    echo.
    echo Fix: Run setup.bat to create it
    pause
    exit /b 1
)

REM Check node_modules
echo.
echo Checking dependencies...
if exist "backend\node_modules" (
    echo ✓ node_modules exists
) else (
    echo ⚠ node_modules not found
    echo Run: cd backend ^&^& npm install
)

echo.
echo ============================================================
echo              ✓ Diagnostic Complete
echo ============================================================
echo.
echo Next steps:
echo   cd backend
echo   npm start
echo.
pause
