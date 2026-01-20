@echo off
REM Automated setup for MoneyPay development environment

echo.
echo ============================================================
echo           MoneyPay Environment Setup
echo ============================================================
echo.

REM Check if backend\.env exists
if exist "backend\.env" (
    echo ^✓ backend\.env already exists
) else (
    echo Creating backend\.env file...
    (
        echo # Backend Environment Variables
        echo.
        echo # Server Configuration
        echo PORT=5000
        echo NODE_ENV=development
        echo.
        echo # Database - MongoDB Atlas
        echo MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true^&w=majority^&appName=Cluster0
        echo.
        echo # JWT Secret
        echo JWT_SECRET=your-super-secret-jwt-key-here-make-it-long-and-random
        echo.
        echo # Frontend URL
        echo FRONTEND_URL=http://localhost:5173
        echo.
        echo # Twilio Configuration ^(optional^)
        echo TWILIO_ACCOUNT_SID=your-twilio-account-sid
        echo TWILIO_AUTH_TOKEN=your-twilio-auth-token
        echo TWILIO_PHONE_NUMBER=your-twilio-phone-number
        echo.
        echo # Socket.io Configuration
        echo SOCKET_CORS_ORIGIN=http://localhost:5173
    ) > backend\.env
    echo ^✓ Created backend\.env
)

REM Check if .env exists
if exist ".env" (
    echo ^✓ .env already exists
) else (
    echo Creating .env file...
    (
        echo # MongoDB Connection String
        echo MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true^&w=majority^&appName=Cluster0
        echo.
        echo # Node Environment
        echo NODE_ENV=development
        echo.
        echo # Server Port
        echo PORT=5000
        echo.
        echo # Frontend URL
        echo FRONTEND_URL=http://localhost:5173
        echo.
        echo # Twilio Configuration ^(optional^)
        echo TWILIO_ACCOUNT_SID=your_account_sid_here
        echo TWILIO_AUTH_TOKEN=your_auth_token_here
        echo TWILIO_PHONE_NUMBER=+1234567890
    ) > .env
    echo ^✓ Created .env
)

echo.
echo ^✓ Setup complete!
echo.
echo Next steps:
echo 1. Make sure MongoDB is running or use MongoDB Atlas
echo 2. Run: cd backend ^&^& npm install
echo 3. Run: npm start
echo.
pause
