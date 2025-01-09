require("dotenv").config();
const { db } = require("../models/firebase");
const jwt = require("jsonwebtoken");

// Generate JWT Token
const generateToken = (uid, userRole) => {
  return jwt.sign({ uid, userRole }, process.env.SECRET_KEY, { expiresIn: "1h" });
};

// Register a new user
const registerUser = async (req, res) => {
  const { userName, email, password, userRole } = req.body;

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
      userName,
      email,
      password,
      userRole,
    });

    res.status(201).json({
      message: "User registered successfully",
      user: { uid: userId, userName, email, userRole },
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
    const token = generateToken(userData.uid, userData.userRole);

    res.status(200).json({
      message: "Login successful",
      token,
      user: {
        uid: userData.uid,
        userName: userData.userName,
        email: userData.email,
        userRole: userData.userRole,
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
