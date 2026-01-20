# Node.js Deployment Guide

Building and deploying MoneyPay using Node.js directly (no Docker).

## Local Development with Node.js

### Prerequisites
- Node.js v18+ ([Download](https://nodejs.org))
- MongoDB running locally or MongoDB Atlas connection
- Git

### Setup & Run Locally

**On Windows:**
```batch
build.bat
```

**On macOS/Linux:**
```bash
chmod +x build.sh
./build.sh
```

**Or manually:**
```bash
cd backend
npm install
npm start
```

Server starts on `http://localhost:5000`

---

## Railway Deployment with Node.js

### How It Works

Railway automatically:
1. Detects Node.js project (package.json)
2. Uses nixpacks to build environment
3. Installs dependencies: `npm install` in backend/
4. Starts server: `npm start` in backend/

**No Docker needed!** ✓

### Configuration Files

- **`nixpacks.toml`** - Build and start commands
- **`railway.json`** - Railway project config (uses nixpacks builder)
- **`backend/start.sh`** - Startup verification script

### Deploy to Railway

#### Step 1: Push to GitHub
```bash
git add .
git commit -m "Configure for Node.js deployment"
git push
```

#### Step 2: Create Railway Project
1. Go to https://railway.app
2. New Project → Deploy from GitHub
3. Select `mpay` repository
4. Railway auto-detects Node.js (nixpacks)

#### Step 3: Set Environment Variables

Backend Service → Variables:
```
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
FRONTEND_URL=https://your-frontend-railway-url.railway.app
TWILIO_ACCOUNT_SID=your_sid
TWILIO_AUTH_TOKEN=your_token
TWILIO_PHONE_NUMBER=your_number
```

#### Step 4: Deploy Frontend

Create new Railway service for frontend:
- GitHub repo: same `mpay` repo
- Build: `npm install && npm run build`
- Start: `npm run preview`

Frontend Service → Variables:
```
VITE_API_URL=https://your-backend-railway-url.railway.app
```

#### Step 5: Verify

Test API health:
```bash
curl https://your-backend-url.railway.app/api/health
```

Response:
```json
{"status":"OK","timestamp":"2026-01-20T..."}
```

---

## File Structure for Node.js Build

```
backend/
├── server.js              # Entry point
├── package.json           # Dependencies (read by Railway)
├── start.sh               # Startup verification
├── routes/
├── models/
└── controllers/

frontend/
├── src/
├── vite.config.js
└── package.json

nixpacks.toml             # Build config (used by Railway)
railway.json              # Railway project config
build.sh                  # Local build script (Unix)
build.bat                 # Local build script (Windows)
```

---

## Build Process

### What Railway Does:

1. **Detect** → Sees Node.js (package.json)
2. **Install** → Runs `npm install` in backend/
3. **Build** → Uses commands from nixpacks.toml
4. **Start** → Runs `npm start` in backend/
5. **Verify** → Health check endpoint `/api/health`

### What Gets Installed:

From `backend/package.json`:
- express (web framework)
- mongoose (MongoDB)
- socket.io (real-time)
- jwt (authentication)
- cors (CORS handling)
- twilio (SMS)
- And all other dependencies

---

## Troubleshooting

### Build Failed: "npm not found"
- Railway couldn't find npm
- Make sure `backend/package.json` exists
- Check nixpacks.toml is in root directory

### App won't start: "MONGODB_URI NOT CONFIGURED"
- Set all variables in Railway UI
- See [RAILWAY_CHECKLIST.md](RAILWAY_CHECKLIST.md)

### Can't connect to MongoDB
- Verify MongoDB Atlas IP whitelist
- Test connection string locally first

### Frontend can't reach backend
- Check `VITE_API_URL` in frontend Variables
- Verify backend is running: `curl /api/health`
- Check CORS is configured with correct frontend URL

---

## Local vs Production

| Setting | Local | Production (Railway) |
|---------|-------|----------------------|
| NODE_ENV | development | production |
| MONGODB_URI | mongodb://localhost:27017/moneypay | mongodb+srv://... (MongoDB Atlas) |
| PORT | 5000 | 5000 |
| FRONTEND_URL | http://localhost:5173 | https://your-frontend.railway.app |

---

## Performance Notes

**Node.js on Railway:**
- ✓ No Docker overhead
- ✓ Faster builds
- ✓ Direct Node.js execution
- ✓ Good for small/medium apps
- ✓ Scales automatically with Railway

---

## Next Steps

1. ✅ Test locally: `build.bat` or `build.sh`
2. ✅ Push to GitHub
3. ✅ Deploy on Railway
4. ✅ Add environment variables
5. ✅ Monitor logs in Railway dashboard

---

## Support

- [Railway Docs](https://docs.railway.app)
- [Node.js Docs](https://nodejs.org/docs)
- [Express.js Docs](https://expressjs.com)
- [nixpacks Docs](https://nixpacks.com)

---

**Status:** Ready for Node.js deployment  
**Build Method:** nixpacks (Node.js native)  
**Deployment:** Railway  
**Date:** January 20, 2026
