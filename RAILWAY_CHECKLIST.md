# Railway Deployment Checklist

**IMPORTANT:** This checklist MUST be completed before your app will work on Railway.

**⚠️ FIRST: Make sure to expose both Backend and Frontend services!**  
See [EXPOSE_SERVICES.md](EXPOSE_SERVICES.md) for detailed instructions on making services public and getting URLs.

## Step 1: Backend Service Variables ✓ REQUIRED

Go to Railway Dashboard → Your Backend Service → **Variables** tab

Add **ALL** of these environment variables:

```
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
FRONTEND_URL=https://your-frontend-service-name.railway.app
TWILIO_ACCOUNT_SID=your_twilio_account_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
TWILIO_PHONE_NUMBER=+1234567890
```

**CRITICAL:** `MONGODB_URI` must be set, otherwise the app will fail to start!

## Step 2: Verify MongoDB Atlas Access

Make sure MongoDB Atlas allows connections from Railway:

1. Go to MongoDB Atlas Dashboard
2. Click **Security** → **Network Access**
3. Add IP: `0.0.0.0/0` (allows Railway to connect)
   - Or add Railway's specific IP if you know it
4. Click **Confirm**

## Step 3: Deploy Backend

After setting variables:
1. Railway will automatically redeploy
2. Check **Deployments** tab for status
3. Wait for "Deployment successful" message

## Step 4: Check Backend Health

Once deployed, test your API:

```bash
curl https://your-backend-service-name.railway.app/api/health
```

Expected response:
```json
{"status":"OK","timestamp":"2026-01-20T..."}
```

If this fails, check:
- ✓ All variables are set in Railway
- ✓ `MONGODB_URI` is correct
- ✓ MongoDB Atlas network access includes Railway

## Step 5: Frontend Service Variables ✓ REQUIRED

Create a new Railway service for frontend with:

```
VITE_API_URL=https://your-backend-service-name.railway.app
```

## Step 6: Deploy Frontend

After setting VITE_API_URL:
1. Build command: `npm install && npm run build`
2. Start command: `npm run preview`
3. Wait for deployment

## Troubleshooting

### App won't start: "MONGODB_URI NOT CONFIGURED"
**Fix:** Set `MONGODB_URI` in Railway Variables (Step 1)

### "MongoDB connection error"
**Fix:** 
- Verify MongoDB Atlas IP whitelist (Step 2)
- Check `MONGODB_URI` value is correct
- Try connecting to MongoDB Atlas directly to test

### Frontend can't reach backend
**Fix:**
- Set `VITE_API_URL` in frontend Variables
- Verify backend URL is correct
- Check browser console for errors

### 502 Bad Gateway Error
**Fix:**
- Check backend service logs: Railway → Service → **Logs**
- Usually means app is crashing
- Verify all required variables are set

## Deployment Environment Variables

### Local Development (.env file)
```
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
PORT=5000
NODE_ENV=development
```

### Railway Production (Variables UI)
Same as above, but with:
```
NODE_ENV=production
```

## Quick Reference

| Variable | Backend | Frontend | Example |
|----------|---------|----------|---------|
| NODE_ENV | ✓ | | production |
| PORT | ✓ | | 5000 |
| MONGODB_URI | ✓ | | mongodb+srv://... |
| FRONTEND_URL | ✓ | | https://frontend.railway.app |
| VITE_API_URL | | ✓ | https://backend.railway.app |
| TWILIO_* | ✓ (optional) | | SMS service creds |

## Help Resources

- [Railway Documentation](https://docs.railway.app)
- [MongoDB Atlas Guide](https://docs.atlas.mongodb.com)
- [Express.js Guide](https://expressjs.com)
- This project: [RAILWAY.md](RAILWAY.md)

---

✅ **Complete this checklist and your app will deploy successfully!**

**Questions?** Check the logs in Railway dashboard → Service → **Logs** tab
