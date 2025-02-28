const { db } = require("../models/firebase");

// Get all trains
const getAllTrains = async (req, res) => {
  try {
    const trainsRef = db.ref("trains");
    const snapshot = await trainsRef.once("value");
    const trains = snapshot.val();

    if (!trains) {
      return res.status(404).json({ message: "No trains found." });
    }

    res.status(200).json({ trains });
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error getting trains", error: error.message });
  }
};

// Get train by ID
const getTrainById = async (req, res) => {
  const { id } = req.params;

  try {
    const trainRef = db.ref(`trains/${id}`);
    const snapshot = await trainRef.once("value");
    const train = snapshot.val();

    if (!train) {
      return res.status(404).json({ message: "Train not found." });
    }

    res.status(200).json({ train });
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error getting train", error: error.message });
  }
};

// Create a new train
const createTrain = async (req, res) => {
  const {
    name,
    origin,
    destination,
    departureTime,
    distance,
    delayed,
    delay_time,
  } = req.body;

  try {
    const trainsRef = db.ref("trains");
    const newTrainRef = trainsRef.push();
    const trainId = newTrainRef.key;

    newTrainRef.set({
      id: trainId,
      name,
      origin,
      destination,
      departureTime,
      distance,
      delayed,
      delay_time,
    });

    console.log("sucess");
    res.status(201).json({ message: "Train created successfully." });
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error creating train", error: error.message });
  }
};

// Update train by ID
const updateTrainById = async (req, res) => {
  const { id } = req.params;
  const {
    name,
    origin,
    destination,
    departureTime,
    distance,
    delayed,
    delay_time,
  } = req.body;

  try {
    const trainRef = db.ref(`trains/${id}`);
    const snapshot = await trainRef.once("value");

    if (!snapshot.exists()) {
      return res.status(404).json({ message: "Train not found." });
    }

    const currentData = snapshot.val();

    // Check if delay_time has changed
    if (currentData.delay_time !== delay_time) {
      // Create a notification
      const notificationsRef = db.ref("notifications");
      await notificationsRef.push({
        trainId: id,
        trainName: currentData.name,
        previousDelayTime: currentData.delay_time,
        newDelayTime: delay_time,
        timestamp: new Date().toISOString(),
      });

      console.log(`Notification created for train ID: ${id}`);
    }

    // Update train details
    await trainRef.update({
      name,
      origin,
      destination,
      departureTime,
      distance,
      delayed,
      delay_time,
    });

    res.status(200).json({
      message: "Train updated successfully.",
      train: {
        id,
        name,
        origin,
        destination,
        departureTime,
        distance,
        delayed,
        delay_time,
      },
    });
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error updating train", error: error.message });
  }
};

// get all notifications
const getAllNotifications = async (req, res) => {
  try {
    const notificationsRef = db.ref("notifications");
    const snapshot = await notificationsRef.once("value");
    const notifications = snapshot.val();

    if (!notifications) {
      return res.status(404).json({ message: "No notifications found." });
    }

    res.status(200).json({ notifications });
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error getting notifications", error: error.message });
  }
};

// Delete train by ID
const deleteTrainById = async (req, res) => {
  const { id } = req.params;

  try {
    const trainRef = db.ref(`trains/${id}`);
    const snapshot = await trainRef.once("value");

    if (!snapshot.exists()) {
      return res.status(404).json({ message: "Train not found." });
    }

    await trainRef.remove();

    res.status(200).json({ message: "Train deleted successfully." });
  } catch (error) {
    res
      .status(400)
      .json({ message: "Error deleting train", error: error.message });
  }
};

module.exports = {
  getAllTrains,
  getTrainById,
  createTrain,
  updateTrainById,
  deleteTrainById,
  getAllNotifications,
};
