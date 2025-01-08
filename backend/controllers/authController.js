require("dotenv").config();
const { db } = require("../models/firebase");
const jwt = require("jsonwebtoken");

// Generate JWT Token
const generateToken = (uid) => {
  return jwt.sign({ uid }, process.env.SECRET_KEY, { expiresIn: "1h" });
};

// Register a new user
const registerUser = async (req, res) => {
  const { username, email, password } = req.body;

  try {
    // Check if email already exists
    const usersRef = db.ref("users");
    const snapshot = await usersRef
      .orderByChild("email")
      .equalTo(email)
      .once("value");

    if (snapshot.exists()) {
      return res.status(400).json({
        message: "Error registering user",
        error: "The email address is already in use by another account.",
      });
    }

    // Save user data to the database
    const newUserRef = usersRef.push();
    const userId = newUserRef.key;
    await newUserRef.set({
      uid: userId,
      username,
      email,
      password,
    });

    res.status(201).json({
      message: "User registered successfully",
      user: { uid: userId, username, email },
    });
  } catch (error) {
    res.status(400).json({
      message: "Error registering user",
      error: error.message,
    });
  }
};

// Login user
const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    // Find user by email
    const usersRef = db.ref("users");
    const snapshot = await usersRef
      .orderByChild("email")
      .equalTo(email)
      .once("value");

    if (!snapshot.exists()) {
      return res.status(400).json({
        message: "Error logging in",
        error: "Invalid email",
      });
    }

    // Verify password
    const userData = Object.values(snapshot.val())[0];
    if (userData.password !== password) {
      return res.status(400).json({
        message: "Error logging in",
        error: "Invalid password",
      });
    }

    // Generate token
    const token = generateToken(userData.uid);

    res.status(200).json({
      message: "Login successful",
      token,
      user: {
        uid: userData.uid,
        username: userData.username,
        email: userData.email,
      },
    });
  } catch (error) {
    res.status(400).json({
      message: "Error logging in",
      error: error.message,
    });
  }
};

module.exports = { registerUser, loginUser };
