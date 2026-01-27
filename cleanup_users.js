// Clean up duplicate null adminId values
db.users.deleteMany({ adminId: null, role: { $ne: 'admin' } });
db.users.updateMany({ adminId: null }, { $unset: { adminId: "" } });
db.users.updateMany({ agentId: null }, { $unset: { agentId: "" } });

// Drop and recreate indexes
db.users.dropIndex("adminId_1");
db.users.dropIndex("agentId_1");

// Recreate with sparse index
db.users.createIndex({ adminId: 1 }, { unique: true, sparse: true });
db.users.createIndex({ agentId: 1 }, { unique: true, sparse: true });
