const express = require('express');
const { registerUser, loginUser } = require('../controllers/authController');
const authenticateToken = require('../middleware/authMiddleware');

const router = express.Router();

// Route for user registration
router.post('/register', registerUser);

// Route for user login
router.post('/login', loginUser);

// Protected route example
router.get('/protected', authenticateToken, (req, res) => {
  res.status(200).json({ message: 'This is a protected route.', user: req.user });
});

module.exports = router;
