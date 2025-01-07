const authRoutes = require("./routes/authRoutes");
require("dotenv").config();
const express = require("express");
const cors = require("cors");
const PORT = process.env.PORT || 5000;
const app = express();
app.use(express.json());

app.use((req, res, next) => {
  console.log(`${req.method} ${req.path}`);
  next();
});

app.use(cors());

app.use("/api/v1", authRoutes);

app.get("/", (req, res) => {
  res.send("Welcome to the Express Firebase Auth API");
});

app.listen(PORT, () => {
  console.log(`${process.env.DB_NAME} running on port ${PORT}`);
});

module.exports = app;
