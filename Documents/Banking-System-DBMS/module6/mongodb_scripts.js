// ==========================================
// MONGODB SCRIPTS - HYBRID SQL-NOSQL INTEGRATION
// ==========================================

// Connect to MongoDB
// mongosh "mongodb://localhost:27017/banking_logs"

// 1. Create Collection for Transaction Logs
db.createCollection("transaction_logs", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: ["transaction_id", "account_id", "type", "amount", "timestamp"],
         properties: {
            transaction_id: { bsonType: "int" },
            account_id: { bsonType: "int" },
            type: { enum: ["DEPOSIT", "WITHDRAWAL", "TRANSFER"] },
            amount: { bsonType: "double" },
            timestamp: { bsonType: "date" },
            metadata: { bsonType: "object" }
         }
      }
   }
});

// 2. Insert Sample Log
db.transaction_logs.insertOne({
   transaction_id: 1001,
   account_id: 1001,
   type: "TRANSFER",
   amount: 500.00,
   timestamp: new Date(),
   metadata: {
      from_account: 1001,
      to_account: 1002,
      ip_address: "192.168.1.1",
      device: "mobile"
   }
});

// 3. Aggregation Pipeline - Daily Transaction Summary
db.transaction_logs.aggregate([
   {
      $group: {
         _id: {
            date: { $dateToString: { format: "%Y-%m-%d", date: "$timestamp" } },
            type: "$type"
         },
         count: { $sum: 1 },
         total_amount: { $sum: "$amount" }
      }
   },
   { $sort: { "_id.date": -1 } }
]);

// 4. Find Suspicious Transactions (above threshold)
db.transaction_logs.find({
   amount: { $gt: 50000.00 }
}).sort({ timestamp: -1 });

print("MongoDB scripts executed successfully");
