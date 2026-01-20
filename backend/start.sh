#!/bin/bash
# Startup script for MoneyPay Backend

# Load .env file if it exists
if [ -f ".env" ]; then
    echo "📁 Loading .env file..."
    set -a
    source .env
    set +a
fi

# Verify MONGODB_URI is set
if [ -z "$MONGODB_URI" ]; then
    echo ""
    echo "❌ ERROR: MONGODB_URI is not set!"
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║ How to Fix: MONGODB_URI Environment Variable                ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "1️⃣  LOCAL DEVELOPMENT:"
    echo "   • Make sure backend/.env exists"
    echo "   • Contains line:"
    echo "     MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0"
    echo ""
    echo "2️⃣  RAILWAY PRODUCTION:"
    echo "   • Go to https://railway.app"
    echo "   • Your Backend Service → Variables"
    echo "   • Add: MONGODB_URI=..."
    echo "   • Click Save & Redeploy"
    echo ""
    echo "3️⃣  QUICK FIX:"
    echo "   • Windows: Run setup.bat"
    echo "   • macOS/Linux: Run ./setup.sh"
    echo ""
    exit 1
fi

echo "🚀 Starting MoneyPay Backend..."
echo "✓ MONGODB_URI: configured"
echo "✓ NODE_ENV: ${NODE_ENV:-development}"
echo "✓ PORT: ${PORT:-5000}"
echo ""

exec node server.js
