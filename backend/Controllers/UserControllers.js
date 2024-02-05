// Description: This file contains all the functions related to user
// package imports
const { User, ProfileSetup, Notification } = require("../Constants/Imports");
const CryptoJS = require("crypto-js");
const jwt = require("jsonwebtoken");

/**
 * @description: This function is used to register a new user
 */
const UserRegisteration = async (req, res, next) => {
  try {
    const newUser = new User({
      // firstName: req.body.firstName,
      // lastName: req.body.lastName,
      email: req.body.email,
      // usertype: req.body.usertype,
      password: CryptoJS.AES.encrypt(
        req.body.password,
        process.env.SECRET_PASSWORD
      ).toString(),
      // mobileNumber: req.body.mobileNumber,
    });

    const savedUser = await newUser.save();
    const access_token = jwt.sign(
      {
        id: savedUser._id,
      },
      process.env.JWT_TOKEN,
      { expiresIn: "30d" }
    );

    res.send({
      message: "Your Data Saved Successfully",
      status: 1,
      data: { access_token, savedUser },
    });
  } catch (err) {
    if (err.toString().includes("MongoServerError: E11000 duplicate key")) {
      res.send({
        message: "User Already Registered",
        status: 0,
      });
    } else {
      res.send({
        message: "Data not Saved",
        status: 0,
      });
    }
  }
};

const getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.id);
    res.send({
      message: "Profile Fetched",
      status: 1,
      data: {
        user: {
          email: user.email,
          id: user._id,
        },
      },
    });
  } catch (e) {
    res.send({
      message: "Profile not Found",
      status: 0,
    });
  }
};

/**
 * @description: This function is used to login a user
 */
const UserLogin = async (req, res) => {
  try {
    const user = await User.findOne({ email: req.body.email });
    const originalpassword = CryptoJS.AES.decrypt(
      user.password,
      process.env.SECRET_PASSWORD
    ).toString(CryptoJS.enc.Utf8);
    if (!user) {
      res.send({
        message: "Invalid Email",
        status: 0,
      });
    } else if (originalpassword !== req.body.password) {
      res.send({
        message: "Invalid Password",
        status: 0,
      });
    } else {
      // if (user.incomplete === false) {
      // const profile = await ProfileSetup.findOne({ user: user._id }).populate('user');
      const access_token = jwt.sign(
        {
          id: user._id,
        },
        process.env.JWT_TOKEN,
        { expiresIn: "30d" }
      );

      //   const { token } = user;
      res.send({
        message: "Loggedin Successfully",
        status: 1,
        data: {
          access_token,
          user: {
            email: user.email,
            id: user._id,
          },
        },
      });
      // } else {
      //     res.send({
      //         message: "Complete Your Profile",
      //         status: 200,
      //         data: {},

      //     });
      // }
    }
  } catch (error) {
    res.send({
      message: "Invalid Credentails",
      status: 0,
    });
  }
};

// exports
module.exports = {
  UserLogin,
  getProfile,
  UserRegisteration,
};
