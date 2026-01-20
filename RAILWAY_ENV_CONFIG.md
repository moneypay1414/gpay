# Railway Deployment Configuration Guide

## Environment Variables to Set in Railway

Copy and paste these environment variables into your Railway project dashboard under **Variables**:

### Backend Service Environment Variables:

```
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
FRONTEND_URL=https://your-moneypay-frontend.railway.app
TWILIO_ACCOUNT_SID=your_twilio_account_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
TWILIO_PHONE_NUMBER=your_twilio_phone_number
```

### Frontend Service Environment Variables:

```
VITE_API_URL=https://your-moneypay-backend.railway.app
```

## Steps to Deploy:

### 1. Backend Deployment

1. Go to [Railway](https://railway.app)
2. Create new project or select existing
3. Click **"Deploy from GitHub"**
4. Select your `mpay` repository
5. Select directory: `/backend` (or leave root if deploying whole project)
6. Go to **Variables** tab
7. Add the Backend Environment Variables above
8. Wait for deployment

### 2. Frontend Deployment

1. Create another Railway project for frontend
2. Click **"Deploy from GitHub"**
3. Same repository
4. Select directory: `/frontend`
5. Go to **Variables** tab
6. Add `VITE_API_URL=https://your-backend-railway-url.up.railway.app`
7. Set build command: `npm install && npm run build`
8. Set start command: `npm run preview`

### 3. Verify Deployment

After deployment, test your API:
```bash
curl https://your-backend-railway-url.up.railway.app/api/health
```

Should return:
```json
{"status":"OK","timestamp":"2026-01-20T..."}
```

## MongoDB Connection Details

**Current Connection String:**
```
mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
```

**Cluster:** Cluster0 (MongoDB Atlas)
**Database:** test
**Username:** G-tech
**Status:** ✓ Configured and ready

## Important Notes

⚠️ **Never commit .env files** - They contain sensitive credentials
- .env files are in .gitignore
- Use Railway's Variables UI to set production values
- Keep MongoDB credentials secure

✓ **Local Development:**
- Use `.env` file in backend directory
- Already configured with MongoDB Atlas connection

✓ **Production (Railway):**
- Set variables in Railway dashboard
- Docker build doesn't include .env
- Environment variables are loaded at runtime

## Troubleshooting

### MongoDB Connection Failed
- Verify `MONGODB_URI` is correct in Railway Variables
- Check MongoDB Atlas IP whitelist includes Railway's IP ranges
- Try connecting directly to MongoDB Atlas to confirm credentials

### Frontend Not Loading API Requests
- Verify `VITE_API_URL` is set correctly in frontend Variables
- Check backend is running: curl `/api/health`
- Check browser console for CORS errors

### Build Failed
- Check build logs in Railway Deployments tab
- Verify all dependencies in package.json
- Check Node version compatibility (v16+)

## MongoDB Atlas IP Whitelist

To ensure Railway can connect, add Railway's IP range to MongoDB Atlas:

1. Go to MongoDB Atlas Dashboard
2. Navigate to **Security** → **Network Access**
3. Click **"Add IP Address"**
4. For Railway: Add `0.0.0.0/0` (allows any IP)
   - Or use Railway's specific IP if known
5. Click Confirm

## Next Steps

1. ✅ Set all environment variables in Railway
2. ✅ Verify MongoDB connection
3. ✅ Deploy backend
4. ✅ Deploy frontend
5. ✅ Test API endpoints
6. ✅ Monitor logs in Railway dashboard

---

**Deployment Date:** January 20, 2026
**MongoDB Status:** Connected
**Backend Ready:** ✓
**Frontend Ready:** ✓
