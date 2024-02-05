/*
 *  Packages
 */
const express = require("express");
const router = express.Router();
const app = express();
const dotenv = require("dotenv").config("./.env");
const server = require("http").createServer(app);
const cors = require("cors");
const mongoose = require("mongoose");
const User = require("../Models/UserModel");

// constants variables from .env file
const port = process.env.PORT;
const mongo_url = process.env.MONGO_URL;

//database connection
const database = () => {
  mongoose.set("strictQuery", false);
  mongoose
    .connect(mongo_url)
    .then((response) => {
      console.log(`Database Connected Successfully`);
    })
    .catch((error) => {
      console.log(`Database Disconnected ${error}`);
    });
};

// exports
module.exports = {
  // packages
  express,
  app,
  server,
  cors,
  mongoose,
  router,
  User,
  // variables
  port,
  // functions
  database,
};
