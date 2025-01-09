require("dotenv").config();
const jwt = require('jsonwebtoken');

const authenticateToken = (req, res, next) => {
  const token = req.headers['authorization'];

  if (!token) return res.status(401).json({ message: 'Access denied. No token provided.' });

  jwt.verify(token, process.env.SECRET_KEY, (err, decoded) => {
    if (err) return res.status(403).json({ message: 'Invalid token.' });

    req.user = decoded;
    console.log('decoded', decoded);
    next();
  });
};

const allowAdminOnly = (req, res, next) => {
  if (req.user.userRole !== 'admin') {
    return res.status(403).json({ message: 'Access denied. Admins only.' });
  }
  next();
};

const allowUserOnly = (req, res, next) => {
  if (req.user.userRole !== 'user') {
    return res.status(403).json({ message: 'Access denied. Users only.' });
  }
  next();
};

module.exports = { authenticateToken, allowAdminOnly, allowUserOnly };