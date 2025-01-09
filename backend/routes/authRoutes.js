const express = require('express');
const { registerUser, loginUser } = require('../controllers/authController');
const { authenticateToken, allowAdminOnly, allowUserOnly } = require('../middleware/authMiddleware');

const router = express.Router();

// Route for user registration
router.post('/register', registerUser);

// Route for user login
router.post('/login', loginUser);

// Example route for admins only
router.get('/admin-dashboard', authenticateToken, allowAdminOnly, (req, res) => {
  res.status(200).json({ message: 'Welcome to the admin dashboard.' });
});

// Example route for users only
router.get('/user-dashboard', authenticateToken, allowUserOnly, (req, res) => {
  res.status(200).json({ message: 'Welcome to the user dashboard.' });
});

// Example route for both roles
router.get('/common-route', authenticateToken, (req, res) => {
  res.status(200).json({ message: 'Welcome to the common route.', user: req.user });
});

module.exports = router;
