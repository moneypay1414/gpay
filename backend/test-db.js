import dotenv from 'dotenv';
import mongoose from 'mongoose';

dotenv.config();

const mongoURI = process.env.MONGODB_URI || 'your-mongodb-connection-string-here';

async function testConnection() {
  try {
    await mongoose.connect(mongoURI);
    console.log('Connected to MongoDB successfully!');
    await mongoose.connection.close();
    console.log('Connection closed.');
  } catch (error) {
    console.error('Error connecting to MongoDB:', error);
  }
}

testConnection();