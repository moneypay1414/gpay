#!/bin/bash
# Build and run MoneyPay using Node.js

echo "🚀 Building MoneyPay with Node.js..."
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "Download from: https://nodejs.org"
    exit 1
fi

echo "✓ Node.js version: $(node --version)"
echo "✓ npm version: $(npm --version)"
echo ""

# Install backend dependencies
echo "📦 Installing backend dependencies..."
cd backend
npm install

if [ $? -ne 0 ]; then
    echo "❌ Backend installation failed"
    exit 1
fi

echo "✓ Backend dependencies installed"
echo ""

# Start the server
echo "🎯 Starting backend server..."
npm start
