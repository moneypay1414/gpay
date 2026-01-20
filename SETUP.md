# Complete Setup & Deployment Guide

Quick reference for setting up MoneyPay locally or deploying to Railway.

## 📋 Quick Links

- **Local Development**: [Local Setup](#local-setup)
- **Railway Deployment**: [Railway Deployment](#railway-deployment)
- **Troubleshooting**: [Common Issues](#common-issues)

---

## 🏠 Local Setup

### Prerequisites
- Node.js v18+ ([Download](https://nodejs.org))
- MongoDB (local or MongoDB Atlas)
- Git

### Step 1: Clone Repository
```bash
git clone https://github.com/moneypay1414/gpay.git
cd mpay
```

### Step 2: Create Environment File
Run the setup script:

**Windows:**
```bash
setup.bat
```

**macOS/Linux:**
```bash
chmod +x setup.sh
./setup.sh
```

This creates `backend/.env` with MongoDB connection.

### Step 3: Install Dependencies
```bash
cd backend
npm install
```

### Step 4: Start Server
```bash
npm start
```

Server starts on: `http://localhost:5000`

### Step 5: Start Frontend (New Terminal)
```bash
cd frontend
npm install
npm run dev
```

Frontend starts on: `http://localhost:5173`

---

## 🚀 Railway Deployment

### Prerequisites
- Railway account: https://railway.app
- GitHub repository pushed
- MongoDB Atlas account

### Step 1: Make Services Public

**Backend Service:**
1. Go to https://railway.app
2. Your Project → Backend Service
3. Settings → Visibility = **Public**
4. Save & note the Public URL

**Frontend Service:**
1. Your Project → Frontend Service
2. Settings → Visibility = **Public**
3. Save & note the Public URL

### Step 2: Set Environment Variables

**Backend Service → Variables:**
```
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
FRONTEND_URL=https://your-frontend-url.railway.app
TWILIO_ACCOUNT_SID=your_sid
TWILIO_AUTH_TOKEN=your_token
TWILIO_PHONE_NUMBER=your_number
```

**Frontend Service → Variables:**
```
VITE_API_URL=https://your-backend-url.railway.app
```

### Step 3: Configure MongoDB
1. Go to MongoDB Atlas: https://cloud.mongodb.com
2. Security → Network Access
3. Add IP: `0.0.0.0/0`
4. Confirm

### Step 4: Deploy
- Backend redeploys automatically after variables are set
- Frontend: Click Redeploy after setting VITE_API_URL
- Wait for both to show "Deployment successful"

### Step 5: Verify
Test backend API:
```bash
curl https://your-backend-url.railway.app/api/health
```

Should return:
```json
{"status":"OK","timestamp":"..."}
```

---

## 🔧 Troubleshooting

### "MONGODB_URI is not set"

**Locally:**
- Run: `setup.bat` or `setup.sh`
- Check: `backend/.env` exists
- Restart: `npm start`

**On Railway:**
- Go to Backend Service → Variables
- Add `MONGODB_URI=...`
- Click Save & Redeploy

### "MongoDB connection error"

**Fix:**
1. Verify connection string is correct
2. MongoDB Atlas → Network Access → Add `0.0.0.0/0`
3. Wait 2-3 minutes
4. Try again

### "Frontend can't reach backend"

**Fix:**
- Frontend Service → Variables
- Check `VITE_API_URL` = backend URL
- Backend Service → Variables
- Check `FRONTEND_URL` = frontend URL
- Redeploy both

### "No Public URL showing"

**Fix:**
- Service → Settings → Visibility = **Public**
- Wait 2 minutes
- Refresh page

---

## 📁 Project Structure

```
mpay/
├── backend/              # Node.js/Express API
│   ├── server.js
│   ├── package.json
│   ├── routes/
│   ├── models/
│   └── .env              # Local env config
├── frontend/             # React/Vite app
│   ├── src/
│   └── package.json
├── .env                  # Root env (optional)
├── railway.json          # Railway config
└── README.md
```

---

## 🛠️ Useful Commands

### Local Development
```bash
# Backend
cd backend
npm start              # Start server
npm run dev           # Start with nodemon (auto-reload)

# Frontend
cd frontend
npm run dev           # Start dev server
npm run build         # Build for production
```

### Setup & Diagnostic
```bash
# Create environment files
setup.bat             # Windows
./setup.sh           # macOS/Linux

# Check environment
diagnose.bat         # Windows
./diagnose.sh       # macOS/Linux
```

### Git & Deployment
```bash
# Push changes
git add .
git commit -m "message"
git push

# Railway CLI
railway login
railway link
railway up
```

---

## 📚 Additional Resources

- [API Documentation](API_DOCUMENTATION.md)
- [MongoDB Setup](MONGODB_SETUP.md)
- [Railway URLs Guide](FIND_RAILWAY_URLS.md)
- [Exposing Services](EXPOSE_SERVICES.md)
- [Node.js Build Info](NODEJS_BUILD.md)
- [Railway Checklist](RAILWAY_CHECKLIST.md)

---

## ✅ Deployment Checklist

- [ ] Services set to Public visibility
- [ ] Backend variables: NODE_ENV, PORT, MONGODB_URI, FRONTEND_URL
- [ ] Frontend variables: VITE_API_URL
- [ ] MongoDB Atlas whitelist includes Railway
- [ ] Both services deployed successfully
- [ ] Backend health check passes
- [ ] Frontend loads in browser
- [ ] Frontend can reach backend (no CORS errors)

---

## 🆘 Need Help?

1. Check [MONGODB_SETUP.md](MONGODB_SETUP.md) for MongoDB configuration
2. Run diagnostic: `diagnose.bat` or `./diagnose.sh`
3. Check Railway logs: Service → Logs tab
4. Review [RAILWAY_CHECKLIST.md](RAILWAY_CHECKLIST.md)

---

**Last Updated:** January 20, 2026  
**Status:** Production Ready
