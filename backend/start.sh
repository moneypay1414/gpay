#!/bin/bash
# Startup verification script for Railway deployment

# Source .env file if it exists in backend or parent directory
if [ -f ".env" ]; then
    export $(cat .env | grep -v '#' | xargs)
fi

if [ -f "../.env" ]; then
    export $(cat ../.env | grep -v '#' | xargs)
fi

echo "🚀 Starting MoneyPay Backend..."
echo ""
echo "Environment Check:"
echo "==================="

if [ -z "$MONGODB_URI" ]; then
    echo ""
    echo "❌ ERROR: MONGODB_URI is not set!"
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║ How to Fix: Set MONGODB_URI Environment Variable            ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🏠 LOCAL DEVELOPMENT:"
    echo "   1. Create backend/.env file with:"
    echo "      MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0"
    echo ""
    echo "   2. Or run setup script:"
    echo "      - Windows: setup.bat"
    echo "      - macOS/Linux: chmod +x setup.sh && ./setup.sh"
    echo ""
    echo "🚀 RAILWAY DEPLOYMENT:"
    echo "   1. Go to https://railway.app"
    echo "   2. Your Backend Service → Variables tab"
    echo "   3. Add this variable:"
    echo "      MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0"
    echo "   4. Click Save & Redeploy"
    echo ""
    echo "📁 File Locations to Check:"
    echo "   ✓ backend/.env (local development)"
    echo "   ✓ Railway Variables UI (production)"
    echo ""
    exit 1
fi

echo "✓ MONGODB_URI is configured"
echo "✓ NODE_ENV=$NODE_ENV"
echo "✓ PORT=$PORT"
echo ""
echo "Starting application..."
exec node server.js
