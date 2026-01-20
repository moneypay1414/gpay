# Quick Deploy to Railway

## 5-Minute Setup

### Step 1: Prepare Your Code
```bash
git add .
git commit -m "Prepare for Railway deployment"
git push
```

### Step 2: Create Railway Project
1. Go to https://railway.app
2. Click **"New Project"**
3. Select **"Deploy from GitHub"**
4. Choose your `mpay` repository
5. Click **"Deploy"**

### Step 3: Set Environment Variables

In Railway Dashboard → Your Project → **Variables**, add:

```
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://user:password@cluster.mongodb.net/moneypay
FRONTEND_URL=https://mpay-frontend-production.up.railway.app
TWILIO_ACCOUNT_SID=your_sid
TWILIO_AUTH_TOKEN=your_token
TWILIO_PHONE_NUMBER=your_number
```

### Step 4: Configure MongoDB

**Option A - MongoDB Atlas (Recommended):**
1. Sign up at https://mongodb.com/cloud/atlas
2. Create a free cluster
3. Get connection string from Atlas
4. Copy to `MONGODB_URI` above

**Option B - Railway MongoDB Plugin:**
1. In Railway dashboard, click **"Add"** → **"Add Plugin"**
2. Select **"MongoDB"**
3. Railway auto-sets the `MONGODB_URI`

### Step 5: Deploy Frontend

Create a new Railway project for frontend:

1. **New Project** → **Deploy from GitHub**
2. Same repo, but select **`frontend`** as root directory
3. Set variables:
   ```
   VITE_API_URL=https://your-backend-railway-url.up.railway.app
   ```
4. Build command: `npm install && npm run build`
5. Start command: `npm run preview`

### Step 6: Update Backend CORS

Your `server.js` already supports this, but verify the `FRONTEND_URL` env var is used.

### Done! 🎉

Your app is now live on Railway!

- **Backend URL:** https://your-backend-service.up.railway.app
- **Frontend URL:** https://your-frontend-service.up.railway.app

## Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| "MongoDB connection failed" | Verify `MONGODB_URI` and IP whitelist in MongoDB Atlas |
| "Frontend shows blank page" | Check `VITE_API_URL` and browser console for errors |
| "API 502 error" | Check Railway backend logs, ensure `PORT=5000` |
| "CORS errors" | Add frontend URL to `FRONTEND_URL` environment variable |

## Useful Railway Commands

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login to Railway
railway login

# Link local project to Railway
railway link

# Deploy
railway up

# View logs
railway logs

# Set environment variables
railway variables set MONGODB_URI=<connection_string>
```

## Next Steps

1. ✅ Configure Twilio SMS notifications
2. ✅ Set up SSL/HTTPS (Railway handles this automatically)
3. ✅ Configure custom domain (optional)
4. ✅ Set up monitoring and alerts
5. ✅ Configure backups for MongoDB

---

**Need help?** Check [RAILWAY_DEPLOYMENT.md](RAILWAY_DEPLOYMENT.md) for detailed guide.
