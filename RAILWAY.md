# Railway Deployment Guide

Complete guide for deploying MoneyPay to Railway.

## Quick Start (5 Minutes)

### 1. Push Code to GitHub
```bash
git add .
git commit -m "Ready for Railway deployment"
git push
```

### 2. Deploy Backend on Railway
- Go to https://railway.app
- Click **"New Project"** → **"Deploy from GitHub"**
- Select `mpay` repository
- Railway auto-detects Docker build
- Click **"Deploy"**

### 3. Add Environment Variables
In Railway Dashboard → Your Project → **Variables**, add:

```env
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
FRONTEND_URL=https://your-frontend-url.railway.app
TWILIO_ACCOUNT_SID=your_twilio_sid
TWILIO_AUTH_TOKEN=your_twilio_token
TWILIO_PHONE_NUMBER=your_twilio_number
```

### 4. Deploy Frontend
- Create new Railway project for frontend
- Select same GitHub repository
- Set build: `npm install && npm run build`
- Set start: `npm run preview`
- Add variable: `VITE_API_URL=https://your-backend-url.railway.app`

### 5. Verify Deployment
```bash
curl https://your-backend-url.railway.app/api/health
```

Should return: `{"status":"OK","timestamp":"..."}`

---

## Detailed Setup

### MongoDB Configuration

**Option A: MongoDB Atlas (Recommended)**
1. Go to https://mongodb.com/cloud/atlas
2. Create a free MongoDB cluster
3. Get your connection string
4. Set `MONGODB_URI` in Railway Variables

**Option B: Railway MongoDB Plugin**
1. Railway Dashboard → Your Project
2. Click **"Add"** → **"Add Plugin"**
3. Select **"MongoDB"**
4. Railway auto-sets `MONGODB_URI`

### CORS Configuration

Frontend URL must be added to `FRONTEND_URL` env variable for CORS to work properly.

---

## Architecture

```
GitHub Repository (moneypay1414/gpay)
    ↓
Railway Backend Service (Docker)
    ├─ Dockerfile (Node.js 18 Alpine)
    ├─ server.js (Express API)
    └─ MongoDB Atlas connection
    
Railway Frontend Service
    ├─ Vite build
    └─ React app
```

---

## Project Structure for Railway

```
backend/
├── server.js              # Main Express app
├── package.json           # Dependencies
├── routes/                # API routes
├── models/                # MongoDB models
├── controllers/           # Business logic
└── middleware/            # Auth, CORS, etc.

frontend/
├── src/
│   ├── App.jsx
│   ├── pages/            # Route pages
│   ├── components/       # React components
│   └── utils/            # Helpers
├── vite.config.js
└── package.json

Dockerfile                # Docker build config (used by Railway)
railway.json              # Railway configuration
.env                      # Local env (in .gitignore)
.env.example              # Template for env vars
```

---

## Troubleshooting

### Build Failed
- Check Railway logs: **Deployments** → **View Logs**
- Verify Node version in Dockerfile (v18)
- Ensure all dependencies in package.json

### MongoDB Connection Error
- Verify `MONGODB_URI` in Railway Variables
- Check MongoDB Atlas IP whitelist:
  - MongoDB Atlas → Security → Network Access
  - Add IP: `0.0.0.0/0`
- Test connection string locally first

### Frontend Shows Blank Page
- Check `VITE_API_URL` is set correctly
- Verify backend is running: curl `/api/health`
- Check browser console for errors

### CORS Errors
- Ensure `FRONTEND_URL` is set in backend Variables
- Format: `https://your-frontend.railway.app`
- No trailing slash

---

## Deployment Checklist

- [ ] GitHub repository up-to-date
- [ ] Docker build configured (Dockerfile present)
- [ ] Environment variables in Railway:
  - [ ] `NODE_ENV=production`
  - [ ] `PORT=5000`
  - [ ] `MONGODB_URI=<connection-string>`
  - [ ] `FRONTEND_URL=<frontend-url>`
  - [ ] `TWILIO_*` (if using SMS)
- [ ] MongoDB Atlas whitelist allows Railway
- [ ] Backend deployment successful
- [ ] Frontend deployment successful
- [ ] API health check passes
- [ ] Frontend can reach backend

---

## Environment Variables Reference

### Backend Required Variables
- `MONGODB_URI` - MongoDB connection string
- `NODE_ENV` - Set to `production`
- `PORT` - Set to `5000`

### Backend Optional Variables
- `FRONTEND_URL` - Frontend URL (for CORS)
- `TWILIO_ACCOUNT_SID` - Twilio SMS service
- `TWILIO_AUTH_TOKEN` - Twilio auth
- `TWILIO_PHONE_NUMBER` - Twilio sender number

### Frontend Required Variables
- `VITE_API_URL` - Backend API URL

---

## Monitoring

### View Logs
Railway Dashboard → Your Service → **Logs** tab

### Monitor Deployments
Railway Dashboard → **Deployments** tab

### Check Health
```bash
curl https://your-backend-url/api/health
```

---

## Support

- [Railway Docs](https://docs.railway.app)
- [MongoDB Atlas Docs](https://docs.atlas.mongodb.com)
- [Express.js Docs](https://expressjs.com)
- [React Docs](https://react.dev)

---

**Last Updated:** January 20, 2026  
**Status:** Ready for Production  
**Database:** MongoDB Atlas  
**Deployment:** Railway
