FROM node:18-alpine

WORKDIR /app

# Copy backend files and .env
COPY backend/package*.json ./backend/
COPY backend ./backend/
COPY .env .env

WORKDIR /app/backend

# Install dependencies
RUN npm ci --only=production

# Set environment variables
ENV NODE_ENV=production
ENV PORT=5000

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:5000/api/health', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Start application
CMD ["node", "server.js"]
