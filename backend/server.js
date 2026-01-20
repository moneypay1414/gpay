import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';
import { createServer } from 'http';
import { Server as SocketIOServer } from 'socket.io';
import { setIO } from './utils/socket.js';

// Load environment variables
const envPath = path.resolve(process.cwd(), '.env');
if (fs.existsSync(envPath)) {
  dotenv.config({ path: envPath });
} else {
  const parentPath = path.resolve(process.cwd(), '..', '.env');
  if (fs.existsSync(parentPath)) {
    dotenv.config({ path: parentPath });
  }
}

// Validate required environment variables
if (!process.env.MONGODB_URI) {
  console.error('❌ ERROR: MONGODB_URI is not set!');
  console.error('Please set MONGODB_URI in your environment.');
  process.exit(1);
}

console.log('🚀 Starting MoneyPay Backend...');

import authRoutes from './routes/authRoutes.js';
import transactionRoutes from './routes/transactionRoutes.js';
import adminRoutes from './routes/adminRoutes.js';
import notificationRoutes from './routes/notificationRoutes.js';
import withdrawalRoutes from './routes/withdrawalRoutes.js';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const flash = require('connect-flash');

const app = express();
const httpServer = createServer(app);// Allow both common frontend ports for development (5173, 5174)
// and also read from FRONTEND_URL env var if set
const allowedOrigins = [
  'http://localhost:5173',
  'http://localhost:5174'
];
if (process.env.FRONTEND_URL && !allowedOrigins.includes(process.env.FRONTEND_URL)) {
  allowedOrigins.push(process.env.FRONTEND_URL);
}

const io = new SocketIOServer(httpServer, {
  cors: {
    origin: allowedOrigins,
    methods: ['GET', 'POST']
  }
});

// expose io to controllers via utils/socket.js to avoid circular imports
setIO(io);

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ limit: '50mb', extended: true }));

// MongoDB Connection
const mongoUri = process.env.MONGODB_URI;

// Validate MongoDB URI is set (required for all environments)
if (!mongoUri) {
  console.error('❌ ERROR: MONGODB_URI is not set!');
  console.error('See MONGODB_SETUP.md or run setup.sh for configuration instructions.');
  process.exit(1);
}

mongoose.connect(mongoUri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  maxPoolSize: 10,
  serverSelectionTimeoutMS: 5000,
  socketTimeoutMS: 45000,
  retryWrites: true
})
  .then(() => console.log('✓ MongoDB connected'))
  .catch(err => {
    console.error('❌ MongoDB connection error:', err.message);
    process.exit(1);
  });

// Routes
app.get('/', (req, res) => {
  res.json({
    message: 'MoneyPay API Server',
    status: 'Running',
    version: '1.0.0',
    endpoints: {
      auth: '/api/auth',
      transactions: '/api/transactions',
      admin: '/api/admin',
      notifications: '/api/notifications',
      withdrawals: '/api/withdrawals',
      health: '/api/health'
    }
  });
});

app.use('/api/auth', authRoutes);
app.use('/api/transactions', transactionRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/notifications', notificationRoutes);
app.use('/api/withdrawals', withdrawalRoutes);

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date() });
});

// Socket.io Real-time notifications
io.on('connection', (socket) => {
  socket.on('join-user', (userId) => {
    socket.join(`user-${userId}`);
  });

  socket.on('send-notification', (data) => {
    io.to(`user-${data.userId}`).emit('new-notification', data);
  });
});

// Middleware for flash messages
app.use(flash());

// Route for admin verification
app.post('/api/admin/verify', (req, res) => {
  const isVerified = true; // Replace with actual verification logic
  if (isVerified) {
    req.flash('success_msg', 'Admin verified successfully!');
    return res.redirect('/admin/login');
  } else {
    req.flash('error_msg', 'Verification failed. Please try again.');
    return res.redirect('/admin/verify');
  }
});

const PORT = process.env.PORT || 5000;
httpServer.listen(PORT, () => {
  console.log(`✓ Server running on port ${PORT}`);
});

export { io };
