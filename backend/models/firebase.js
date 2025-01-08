require("dotenv").config();
const admin = require('firebase-admin');
const serviceAccount = require('../service-account-key.json');

// Initialize Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: process.env.FIREBASE_DATABASE_URL,
});

console.log("Firebase Admin SDK initialized");

const db = admin.database();

module.exports = { db };
