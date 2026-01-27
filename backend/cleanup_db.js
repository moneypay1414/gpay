import mongoose from 'mongoose';
import User from './models/User.js';
import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';

// Load environment variables
const envPath = path.resolve(process.cwd(), '.env');
if (fs.existsSync(envPath)) {
  dotenv.config({ path: envPath });
}

async function cleanupDatabase() {
  try {
    console.log('Connecting to MongoDB...');
    await mongoose.connect(process.env.MONGODB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    console.log('✓ Connected to MongoDB');

    // Find and delete documents with null adminId
    console.log('\nCleaning up null adminId values...');
    const result1 = await User.deleteMany({ 
      adminId: null, 
      role: { $ne: 'admin' } 
    });
    console.log(`Deleted ${result1.deletedCount} documents with null adminId (non-admin users)`);

    // Update any remaining documents to remove null adminId
    const result2 = await User.updateMany(
      { adminId: null },
      { $unset: { adminId: "" } }
    );
    console.log(`Updated ${result2.modifiedCount} documents to remove null adminId`);

    // Update any remaining documents to remove null agentId
    const result3 = await User.updateMany(
      { agentId: null },
      { $unset: { agentId: "" } }
    );
    console.log(`Updated ${result3.modifiedCount} documents to remove null agentId`);

    console.log('\n✓ Database cleanup complete');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error during cleanup:', error.message);
    process.exit(1);
  }
}

cleanupDatabase();
