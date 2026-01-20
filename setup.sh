#!/bin/bash
# Automated setup for MoneyPay development environment

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║          MoneyPay Environment Setup                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if backend/.env exists
if [ ! -f "backend/.env" ]; then
    echo "📝 Creating backend/.env file..."
    cat > backend/.env << 'EOF'
# Backend Environment Variables

# Server Configuration
PORT=5000
NODE_ENV=development

# Database - MongoDB Atlas
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0

# JWT Secret (generate a strong random string)
JWT_SECRET=your-super-secret-jwt-key-here-make-it-long-and-random

# Frontend URL (for CORS - use localhost for development)
FRONTEND_URL=http://localhost:5173

# Twilio SMS Configuration (optional)
TWILIO_ACCOUNT_SID=your-twilio-account-sid
TWILIO_AUTH_TOKEN=your-twilio-auth-token
TWILIO_PHONE_NUMBER=your-twilio-phone-number

# Socket.io Configuration
SOCKET_CORS_ORIGIN=http://localhost:5173
EOF
    echo "✓ Created backend/.env"
else
    echo "✓ backend/.env already exists"
fi

# Check if root .env exists
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file..."
    cat > .env << 'EOF'
# MongoDB Connection String
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0

# Node Environment
NODE_ENV=development

# Server Port
PORT=5000

# Frontend URL
FRONTEND_URL=http://localhost:5173

# Twilio Configuration (optional)
TWILIO_ACCOUNT_SID=your_account_sid_here
TWILIO_AUTH_TOKEN=your_auth_token_here
TWILIO_PHONE_NUMBER=+1234567890
EOF
    echo "✓ Created .env"
else
    echo "✓ .env already exists"
fi

echo ""
echo "✓ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Make sure MongoDB is running or use MongoDB Atlas"
echo "2. Run: cd backend && npm install"
echo "3. Run: npm start"
echo ""
