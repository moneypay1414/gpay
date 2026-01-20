# MONGODB_URI Setup Guide

## Quick Fix: Run Setup Script

### Windows:
```batch
setup.bat
```

### macOS/Linux:
```bash
chmod +x setup.sh
./setup.sh
```

This automatically creates `.env` files with the correct MongoDB URI.

---

## Manual Setup

### Step 1: Create `backend/.env`

Create file: `backend/.env`

```
# Server Configuration
PORT=5000
NODE_ENV=development

# Database - MongoDB Atlas
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0

# Frontend URL (for CORS)
FRONTEND_URL=http://localhost:5173

# JWT Secret
JWT_SECRET=your-super-secret-jwt-key-here-make-it-long-and-random

# Twilio Configuration (optional)
TWILIO_ACCOUNT_SID=your-twilio-account-sid
TWILIO_AUTH_TOKEN=your-twilio-auth-token
TWILIO_PHONE_NUMBER=your-twilio-phone-number

# Socket.io Configuration
SOCKET_CORS_ORIGIN=http://localhost:5173
```

### Step 2: Create `.env` (optional, for root directory)

Create file: `.env`

```
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
PORT=5000
NODE_ENV=development
FRONTEND_URL=http://localhost:5173
TWILIO_ACCOUNT_SID=your_account_sid_here
TWILIO_AUTH_TOKEN=your_auth_token_here
TWILIO_PHONE_NUMBER=+1234567890
```

### Step 3: Test Locally

```bash
cd backend
npm install
npm start
```

Should see:
```
✓ MONGODB_URI is configured
✓ NODE_ENV=development
✓ PORT=5000
Starting application...
```

---

## For Railway Deployment

### Step 1: Set Environment Variables

1. Go to https://railway.app
2. Your Backend Service → **Variables** tab
3. Add **exactly** these variables:

```
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
FRONTEND_URL=https://your-frontend-service-name.railway.app
```

### Step 2: MongoDB Atlas Whitelist

1. Go to MongoDB Atlas: https://cloud.mongodb.com
2. Click **Security** → **Network Access**
3. Click **Add IP Address**
4. Add IP: `0.0.0.0/0` (allows Railway to connect)
5. Click **Confirm**

### Step 3: Redeploy

In Railway:
1. Go to your Backend Service
2. Click **Redeploy** button
3. Wait for deployment to complete

### Step 4: Verify

```bash
curl https://your-backend-service.railway.app/api/health
```

Should return:
```json
{"status":"OK","timestamp":"2026-01-20T..."}
```

---

## File Locations

| Environment | File Location | Status |
|---|---|---|
| Local Dev | `backend/.env` | Must exist |
| Root (backup) | `.env` | Optional |
| Railway | Dashboard Variables | Must be set |

---

## MongoDB Connection String Breakdown

```
mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
└──┬──┘  └─────┬─────┘ └──┬──┘ └────┬──────┘ └─┬─┘ └────────┬──────────────────────────────────────────┘
   │          │           │         │          │          query parameters
protocol    username:password  domain      database      (connection options)

- Protocol: mongodb+srv (MongoDB Atlas)
- Username: G-tech
- Password: gmfdeboss988
- Cluster: cluster0.wkaui.mongodb.net
- Database: test
- Options: Retry writes enabled, write concern majority, app name for tracking
```

---

## Troubleshooting

### "MONGODB_URI is not set" Error

**Cause:** Environment variable not loaded

**Fix:**
1. Check `backend/.env` exists
2. Check `MONGODB_URI` line is there (copy exact value above)
3. Restart application
4. If on Railway: Add variable in Railway UI and redeploy

### "MongoDB connection error"

**Cause:** Can't connect to database

**Fix:**
1. Verify connection string is correct
2. Check MongoDB Atlas whitelist includes Railway IP (0.0.0.0/0)
3. Test connection locally first
4. Check if MONGODB_URI has proper format (starts with `mongodb+srv://`)

### "Failed to connect to server"

**Cause:** Network/firewall issue

**Fix:**
1. MongoDB Atlas → Network Access → Add 0.0.0.0/0
2. Wait 5 minutes for changes to take effect
3. Try again

---

## Quick Checklist

- [ ] Run `setup.bat` or `setup.sh`
- [ ] `backend/.env` file exists
- [ ] `MONGODB_URI` is in the file
- [ ] `npm install` completes successfully
- [ ] `npm start` shows "✓ MONGODB_URI is configured"
- [ ] For Railway: All variables set in Dashboard
- [ ] For Railway: MongoDB Atlas whitelist updated
- [ ] Can curl `/api/health` endpoint

---

## Need Help?

1. Check [RAILWAY.md](RAILWAY.md) for deployment guide
2. Check [RAILWAY_CHECKLIST.md](RAILWAY_CHECKLIST.md) for verification steps
3. Check [NODEJS_BUILD.md](NODEJS_BUILD.md) for build info
4. Check [FIND_RAILWAY_URLS.md](FIND_RAILWAY_URLS.md) for URL configuration

---

**Your MongoDB URI is ready to use. Just copy it to `.env` file!** ✓
