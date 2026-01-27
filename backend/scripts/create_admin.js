import mongoose from 'mongoose';
import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';

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

import User from '../models/User.js';
import { hashPassword } from '../utils/helpers.js';

async function createAdmin() {
  try {
    // Connect to MongoDB
    await mongoose.connect(process.env.MONGODB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    console.log('✓ MongoDB connected');

    // Admin credentials for testing
    const adminEmail = 'admin@moneypay.com';
    const adminPassword = 'Admin@12345';
    const adminPhone = '+211123456789';
    const adminName = 'Admin User';

    // Check if admin already exists
    const existingAdmin = await User.findOne({ email: adminEmail });
    if (existingAdmin) {
      console.log('✓ Admin account already exists!');
      console.log('Email:', adminEmail);
      console.log('Password:', adminPassword);
      console.log('Phone:', adminPhone);
      await mongoose.connection.close();
      process.exit(0);
    }

    // Hash password
    const hashedPassword = await hashPassword(adminPassword);

    // Create admin user
    const admin = new User({
      name: adminName,
      email: adminEmail,
      phone: adminPhone,
      password: hashedPassword,
      role: 'admin',
      isVerified: true,
      balance: 100000, // Give admin some balance for testing
      isSuspended: false
    });

    await admin.save();
    console.log('✓ Admin account created successfully!');
    console.log('\n📝 Admin Credentials:');
    console.log('Email:', adminEmail);
    console.log('Password:', adminPassword);
    console.log('Phone:', adminPhone);
    console.log('\n💰 Initial Balance: 100,000');
    console.log('\nYou can now login with these credentials at:');
    console.log('http://ssswwkk4gso4ooog0scw4g8o.127.0.0.1.sslip.io/api/auth/login');

    await mongoose.connection.close();
    process.exit(0);
  } catch (error) {
    console.error('❌ Error creating admin:', error.message);
    await mongoose.connection.close();
    process.exit(1);
  }
}

createAdmin();
