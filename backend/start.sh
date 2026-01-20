#!/bin/bash
# Startup verification script for Railway deployment

echo "🚀 Starting MoneyPay Backend..."
echo ""
echo "Environment Check:"
echo "==================="

if [ -z "$MONGODB_URI" ]; then
    echo "❌ ERROR: MONGODB_URI is not set!"
    echo ""
    echo "How to fix this in Railway:"
    echo "1. Go to your Railway project dashboard"
    echo "2. Click on your Backend service"
    echo "3. Go to the 'Variables' tab"
    echo "4. Add these variables:"
    echo ""
    echo "   NODE_ENV=production"
    echo "   PORT=5000"
    echo "   MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0"
    echo "   FRONTEND_URL=https://your-frontend-url.railway.app"
    echo ""
    echo "5. Redeploy your service"
    echo ""
    exit 1
fi

echo "✓ MONGODB_URI is configured"
echo "✓ NODE_ENV=$NODE_ENV"
echo "✓ PORT=$PORT"
echo ""
echo "Starting application..."
exec node server.js
