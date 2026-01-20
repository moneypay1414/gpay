#!/bin/bash
# Diagnostic script to check if environment is set up correctly

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║       MoneyPay Environment Diagnostic                      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check Node.js
echo "1️⃣  Checking Node.js..."
if command -v node &> /dev/null; then
    echo "   ✓ Node.js $(node --version) installed"
else
    echo "   ❌ Node.js NOT installed"
    echo "   Download from: https://nodejs.org"
    exit 1
fi

# Check npm
echo ""
echo "2️⃣  Checking npm..."
if command -v npm &> /dev/null; then
    echo "   ✓ npm $(npm --version) installed"
else
    echo "   ❌ npm NOT installed"
    exit 1
fi

# Check .env file
echo ""
echo "3️⃣  Checking backend/.env..."
if [ -f "backend/.env" ]; then
    echo "   ✓ backend/.env exists"
    
    # Check for MONGODB_URI
    if grep -q "MONGODB_URI" backend/.env; then
        echo "   ✓ MONGODB_URI found in backend/.env"
        # Show just the key, not the value for security
        MONGO_CONFIGURED=$(grep "MONGODB_URI" backend/.env | cut -d'=' -f2 | wc -c)
        if [ $MONGO_CONFIGURED -gt 10 ]; then
            echo "   ✓ MONGODB_URI appears to be configured ($(( MONGO_CONFIGURED - 1 )) characters)"
        else
            echo "   ❌ MONGODB_URI appears empty"
        fi
    else
        echo "   ❌ MONGODB_URI not found in backend/.env"
    fi
    
    # Show file size
    SIZE=$(wc -c < backend/.env)
    echo "   📄 File size: $SIZE bytes"
else
    echo "   ❌ backend/.env NOT found"
    echo ""
    echo "   Fix: Run setup.sh to create it"
    exit 1
fi

# Check node_modules
echo ""
echo "4️⃣  Checking dependencies..."
if [ -d "backend/node_modules" ]; then
    MODULE_COUNT=$(ls -1 backend/node_modules | wc -l)
    echo "   ✓ node_modules exists ($MODULE_COUNT packages)"
else
    echo "   ⚠ node_modules not found"
    echo "   Run: cd backend && npm install"
fi

# Check database connectivity (optional)
echo ""
echo "5️⃣  Environment Variables..."
if [ -f "backend/.env" ]; then
    set -a
    source backend/.env
    set +a
    
    if [ -n "$MONGODB_URI" ]; then
        echo "   ✓ MONGODB_URI loaded"
        # Just show scheme and host
        SCHEME=$(echo $MONGODB_URI | cut -d':' -f1-2)
        HOST=$(echo $MONGODB_URI | cut -d'@' -f2 | cut -d'/' -f1)
        echo "     Scheme: $SCHEME"
        echo "     Host: $HOST"
    else
        echo "   ❌ MONGODB_URI not loaded"
    fi
    
    echo "   PORT: ${PORT:-5000}"
    echo "   NODE_ENV: ${NODE_ENV:-development}"
    echo "   FRONTEND_URL: ${FRONTEND_URL:-not set}"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║              ✓ Diagnostic Complete                         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  cd backend"
echo "  npm start"
echo ""
