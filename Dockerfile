# NOTE: This Dockerfile is NOT being used for Railway deployment
# Railway is configured to use nixpacks.toml for direct Node.js building
# This file is kept for reference only if you want to use Docker locally
#
# If you want to use this Dockerfile:
# 1. Update railway.json to use builder: "dockerfile"
# 2. Run locally: docker build -t moneypay . && docker run -p 5000:5000 moneypay

FROM node:18-alpine

WORKDIR /app

# Update npm to latest
RUN npm install -g npm@latest

# Copy backend files
COPY backend/package*.json ./backend/
COPY backend ./backend/

WORKDIR /app/backend

# Install dependencies
RUN npm install --production

# Make startup script executable
RUN chmod +x start.sh

# Set environment variables
ENV NODE_ENV=production
ENV PORT=5000

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:5000/api/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Start application with verification script
CMD ["sh", "start.sh"]
