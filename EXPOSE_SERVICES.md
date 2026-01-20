# How to Expose Railway Services (Public URLs)

## Problem: "Unexposed Service" or No Public URL

Railway services are **private by default**. To make your app accessible, you need to expose them publicly.

---

## Quick Fix: Expose Service

### Step 1: Go to Railway Dashboard

1. Open https://railway.app
2. Log in to your account
3. Click on your **Project**

### Step 2: Expose Backend Service

1. Click on **Backend** service
2. Go to **Settings** tab
3. Scroll to **Visibility** section
4. Click dropdown next to "Visibility"
5. Select **Public** (not Private)
6. **Save** changes

### Step 3: Get Public URL

After setting to Public:
1. Go to **Settings** tab
2. Look for **Public URL** or **Domain** section
3. You'll see a URL like: `https://moneypay-backend-abc123.railway.app`
4. **Copy this URL**

### Step 4: Expose Frontend Service

Repeat Steps 2-3 for **Frontend** service:
1. Click on Frontend service
2. Settings → Visibility → **Public**
3. Save
4. Copy the Public URL

---

## Configure Backend with Frontend URL

### Step 1: Copy Frontend URL

From Frontend service → Settings → **Public URL**
- Example: `https://moneypay-frontend-def456.railway.app`

### Step 2: Set Backend Variables

Backend service → **Variables** tab:
1. Find or add: `FRONTEND_URL`
2. Set value to Frontend URL from Step 1
3. Click **Save & Redeploy**

Example:
```
FRONTEND_URL=https://moneypay-frontend-def456.railway.app
```

---

## Configure Frontend with Backend URL

### Step 1: Copy Backend URL

From Backend service → Settings → **Public URL**
- Example: `https://moneypay-backend-abc123.railway.app`

### Step 2: Set Frontend Variables

Frontend service → **Variables** tab:
1. Find or add: `VITE_API_URL`
2. Set value to Backend URL from Step 1
3. Click **Save & Redeploy**

Example:
```
VITE_API_URL=https://moneypay-backend-abc123.railway.app
```

---

## Visual Guide

```
Railway Dashboard
├── Your Project
│   ├── Backend Service
│   │   ├── Settings
│   │   │   ├── Visibility → Change to "Public" ← CLICK THIS
│   │   │   └── Public URL → Copy this URL
│   │   └── Variables
│   │       └── FRONTEND_URL → Paste frontend URL here
│   │
│   └── Frontend Service
│       ├── Settings
│       │   ├── Visibility → Change to "Public" ← CLICK THIS
│       │   └── Public URL → Copy this URL
│       └── Variables
│           └── VITE_API_URL → Paste backend URL here
```

---

## Complete Setup Order

1. ✅ Backend service → Settings → Visibility = **Public**
2. ✅ Backend service → Copy **Public URL**
3. ✅ Backend service → Variables → Add/Update `FRONTEND_URL`
4. ✅ Backend service → Click **Redeploy**
5. ✅ Wait for backend to deploy
6. ✅ Frontend service → Settings → Visibility = **Public**
7. ✅ Frontend service → Copy **Public URL**
8. ✅ Frontend service → Variables → Add/Update `VITE_API_URL`
9. ✅ Frontend service → Click **Redeploy**
10. ✅ Wait for frontend to deploy
11. ✅ Visit Frontend URL in browser
12. ✅ Test API connection

---

## Verify Exposed Services

### Test Backend API

```bash
curl https://your-backend-url.railway.app/api/health
```

Expected response:
```json
{"status":"OK","timestamp":"2026-01-20T..."}
```

### Test Frontend

Open in browser:
```
https://your-frontend-url.railway.app
```

Should load the React app

### Check CORS

Frontend should be able to reach backend without CORS errors in browser console

---

## Troubleshooting

### No Public URL showing

**Cause:** Service is not public
- Check Visibility is set to **Public** (not Private)
- Wait 1-2 minutes for URL to generate
- Refresh the page

### "Connection refused" error

**Cause:** Backend service not exposed
- Make sure Backend service Visibility = **Public**
- Check Backend Public URL is in Frontend `VITE_API_URL`

### CORS errors in browser

**Cause:** Frontend URL not set in Backend
- Backend service → Variables
- Make sure `FRONTEND_URL` = your actual frontend public URL
- Redeploy backend

### 404 or blank frontend

**Cause:** Frontend not built/deployed
- Frontend service should show "Deployment successful"
- Check Frontend service Deployments tab for errors
- Make sure `VITE_API_URL` is set correctly

---

## Quick Reference

| Task | Location | Action |
|------|----------|--------|
| Expose Backend | Backend → Settings | Set Visibility to "Public" |
| Get Backend URL | Backend → Settings | Copy from "Public URL" |
| Set FRONTEND_URL | Backend → Variables | Add/Update with Frontend URL |
| Expose Frontend | Frontend → Settings | Set Visibility to "Public" |
| Get Frontend URL | Frontend → Settings | Copy from "Public URL" |
| Set VITE_API_URL | Frontend → Variables | Add/Update with Backend URL |
| Redeploy Backend | Backend → Overview | Click "Redeploy" |
| Redeploy Frontend | Frontend → Overview | Click "Redeploy" |

---

## Important Notes

⚠️ **Public Service = Accessible from Internet**
- Anyone can visit your frontend URL
- Anyone can call your API endpoints
- Use rate limiting and authentication to protect

✓ **After Making Public**
- Wait 30 seconds to 2 minutes for URL to be ready
- Refresh browser and Railway dashboard
- Ports are auto-managed by Railway

✓ **Custom Domain (Optional)**
- Railway can add custom domains
- See Railway docs for CNAME setup
- Costs extra ($5/month)

---

## Still Having Issues?

1. Check [RAILWAY.md](RAILWAY.md) - Main deployment guide
2. Check [RAILWAY_CHECKLIST.md](RAILWAY_CHECKLIST.md) - Verification steps
3. Check [FIND_RAILWAY_URLS.md](FIND_RAILWAY_URLS.md) - URL configuration
4. Check Railway Logs: Service → **Logs** tab

---

**Services must be Public to get URLs!** ✓
