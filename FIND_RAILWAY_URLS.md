# How to Get Your Railway URLs

## Getting FRONTEND_URL from Railway

### Step 1: Go to Railway Dashboard
1. Open https://railway.app
2. Log in to your account
3. Click on your project

### Step 2: Find Your Frontend Service URL

**Method A: From Services View**
1. In your project, you should see multiple services listed:
   - Backend service
   - Frontend service
2. Click on the **Frontend** service
3. Go to the **Settings** tab
4. Look for **Public URL** or **Domain** section
5. Copy the URL (will look like: `https://moneypay-frontend-production.railway.app`)
6. This is your `FRONTEND_URL`

**Method B: From Deployments**
1. In Frontend service, click **Deployments**
2. Click on the latest deployment
3. You'll see a green **Public URL** badge
4. Click to copy it

### Step 3: Use This URL for Backend

Now go to your **Backend** service:
1. Click on Backend service
2. Go to **Variables** tab
3. Add: `FRONTEND_URL=https://your-frontend-service-name.railway.app`
4. Replace with actual URL from Step 2

---

## Complete Railway URLs Reference

### Backend Service
- **What it is:** Your API server (Node.js/Express)
- **Where to find:** Backend service → Settings → Public URL
- **Example:** `https://moneypay-backend-production.railway.app`
- **Used in:** Frontend's `VITE_API_URL` variable
- **Set in Backend Variables:** `FRONTEND_URL` (for CORS)

### Frontend Service
- **What it is:** Your React app (Vite)
- **Where to find:** Frontend service → Settings → Public URL
- **Example:** `https://moneypay-frontend-production.railway.app`
- **Used in:** Browser to access the app
- **Set in Backend Variables:** `FRONTEND_URL` (for CORS)

---

## Setting Up Both Services

### Backend Service Variables
```
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://G-tech:gmfdeboss988@cluster0.wkaui.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0
FRONTEND_URL=https://your-frontend-url-from-railway.railway.app
```

### Frontend Service Variables
```
VITE_API_URL=https://your-backend-url-from-railway.railway.app
```

---

## Visual Guide: Finding URLs in Railway

```
Railway Dashboard
├── Your Project
│   ├── Backend Service
│   │   ├── Settings
│   │   │   └── Public URL → Copy this → Use as VITE_API_URL in Frontend
│   │   └── Variables
│   │       └── FRONTEND_URL → Paste frontend URL here
│   │
│   └── Frontend Service
│       ├── Settings
│       │   └── Public URL → Copy this → Use as FRONTEND_URL in Backend
│       └── Variables
│           └── VITE_API_URL → Paste backend URL here
```

---

## Example URLs

**Your actual Railway URLs will look like:**

- Backend: `https://moneypay-backend-abc123.railway.app`
- Frontend: `https://moneypay-frontend-def456.railway.app`

**Names depend on your service names in Railway**

---

## Troubleshooting: Can't Find Public URL?

**If Public URL doesn't show:**
1. Make sure deployment is successful (green checkmark)
2. Wait 2-3 minutes for Railway to generate the URL
3. Go to **Deployments** tab
4. Click latest successful deployment
5. Look for green **Public URL** link

**If still not showing:**
1. Go to service **Settings**
2. Look for **Visibility** - should be set to "Public"
3. Save and redeploy

---

## After Getting URLs

1. ✅ Copy Backend URL
2. ✅ Paste in Frontend Variables as `VITE_API_URL`
3. ✅ Copy Frontend URL
4. ✅ Paste in Backend Variables as `FRONTEND_URL`
5. ✅ Redeploy both services
6. ✅ Test: Visit frontend URL in browser

---

## Quick Reference

| Need to find | Go to | Look for |
|---|---|---|
| Backend URL | Backend Service → Settings | Public URL |
| Frontend URL | Frontend Service → Settings | Public URL |
| Set Backend Variables | Backend Service → Variables | Add FRONTEND_URL here |
| Set Frontend Variables | Frontend Service → Variables | Add VITE_API_URL here |

---

**Your service names in Railway determine the URL format.**
**Example: `moneypay-backend` → `https://moneypay-backend-xxx.railway.app`**
