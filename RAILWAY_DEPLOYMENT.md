# Railway Deployment Guide for MoneyPay

This guide will help you deploy the MoneyPay full-stack application to Railway.

## Prerequisites

- Railway account (sign up at https://railway.app)
- Git repository with your code pushed to GitHub/GitLab
- Environment variables configured

## Deployment Steps

### 1. Connect Your Repository to Railway

1. Visit [railway.app](https://railway.app) and log in to your account
2. Click "New Project" → "Deploy from GitHub"
3. Connect your GitHub account if not already connected
4. Select the repository containing MoneyPay
5. Click "Deploy"

### 2. Configure Environment Variables

Railway will automatically detect your project structure. Configure the following environment variables in the Railway UI:

#### Backend Variables:
```
NODE_ENV=production
PORT=5000
MONGODB_URI=your_mongodb_connection_string
FRONTEND_URL=https://your-frontend-railway-url.up.railway.app
TWILIO_ACCOUNT_SID=your_twilio_account_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
TWILIO_PHONE_NUMBER=your_twilio_phone_number
```

#### Frontend Variables:
```
VITE_API_URL=https://your-backend-railway-url.up.railway.app
```

### 3. MongoDB Setup

#### Option A: Using MongoDB Atlas (Recommended)

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a free MongoDB cluster
3. Get your connection string: `mongodb+srv://username:password@cluster.mongodb.net/moneypay`
4. Set this as `MONGODB_URI` in Railway environment variables

#### Option B: Using Railway MongoDB Plugin

1. In Railway dashboard, go to your project
2. Click "Add Plugin" → "Add MongoDB"
3. Railway will automatically set `MONGODB_URI` environment variable

### 4. Deploy Services Separately (Optional but Recommended)

For better control and scalability, deploy backend and frontend as separate services:

#### Backend Service:

1. Create new Railway project for backend
2. Deploy from GitHub (select the `backend/` directory as root)
3. Set start command: `npm install && npm start`
4. Add environment variables (see step 2)

#### Frontend Service:

1. Create new Railway project for frontend
2. Deploy from GitHub (select the `frontend/` directory as root)
3. Set build command: `npm install && npm run build`
4. Set start command: `npm run preview`
5. Add `VITE_API_URL` pointing to your backend Railway URL

### 5. Configure CORS

Update your backend server.js to include Railway frontend URL:

```javascript
const allowedOrigins = [
  'http://localhost:5173',
  'http://localhost:5174',
  process.env.FRONTEND_URL || 'http://localhost:3000'
];
```

This is already configured in the current server.js file.

### 6. Database Migration (If Needed)

If you have existing data in MongoDB, it will migrate automatically when the backend connects.

## Monitoring & Logs

1. View logs in Railway dashboard under "Logs" tab
2. Check deployment status in "Deployments" section
3. Monitor API health at: `https://your-backend-url/api/health`

## Troubleshooting

### Build Failures
- Check Railway logs for errors
- Ensure all dependencies are in `package.json`
- Verify Node version compatibility (v16+)

### Connection Errors
- Verify `MONGODB_URI` is correct
- Check MongoDB Atlas IP whitelist includes Railway IPs
- Ensure environment variables are set correctly

### Frontend Not Loading
- Check `VITE_API_URL` points to correct backend URL
- Verify CORS is properly configured
- Check browser console for errors

### API Not Working
- Verify backend is running (check `/api/health`)
- Check MongoDB connection string
- Review server logs in Railway dashboard

## Environment Variables Checklist

- [ ] `NODE_ENV=production`
- [ ] `PORT=5000`
- [ ] `MONGODB_URI=<your_mongodb_connection_string>`
- [ ] `FRONTEND_URL=<your_frontend_railway_url>`
- [ ] `TWILIO_ACCOUNT_SID=<your_twilio_sid>`
- [ ] `TWILIO_AUTH_TOKEN=<your_twilio_token>`
- [ ] `TWILIO_PHONE_NUMBER=<your_twilio_number>`

## File Structure for Railway

The following files have been added to support Railway deployment:

- `railway.json` - Railway build configuration
- `Procfile` - Process file for app startup
- `.railway` - Environment variables template
- `RAILWAY_DEPLOYMENT.md` - This guide

## Additional Resources

- [Railway Documentation](https://docs.railway.app)
- [Railway Environment Variables](https://docs.railway.app/reference/environment-variables)
- [Railway Build Configuration](https://docs.railway.app/reference/nixpacks)
- [MongoDB Atlas Docs](https://docs.atlas.mongodb.com)

## Getting Help

If you encounter issues:
1. Check Railway documentation
2. Review deployment logs in Railway UI
3. Verify all environment variables are set
4. Ensure MongoDB connection string is valid
5. Check CORS configuration for frontend URL

## Quick Commands for Local Testing

Before deploying, test locally:

```bash
# Backend
cd backend
npm install
NODE_ENV=production PORT=5000 npm start

# Frontend (in another terminal)
cd frontend
npm install
VITE_API_URL=http://localhost:5000 npm run build
npm run preview
```

---

**Last Updated:** January 20, 2026
