const express = require('express');
const { getAllTrains, getTrainById, createTrain, updateTrainById, deleteTrainById } = require('../controllers/trainController');
const { authenticateToken, allowAdminOnly, allowUserOnly } = require('../middleware/authMiddleware');

const router = express.Router();

// Route to get all trains
router.get('/', authenticateToken, getAllTrains);

// Route to get train by ID
router.get('/:id', authenticateToken, getTrainById);

// Route to create a new train by admin
router.post('/', authenticateToken, allowAdminOnly, createTrain);

// Route to update train by ID by admin
router.put('/:id', authenticateToken, allowAdminOnly, updateTrainById);

// Route to delete train by ID by admin
router.delete('/:id', authenticateToken, allowAdminOnly, deleteTrainById);

module.exports = router;