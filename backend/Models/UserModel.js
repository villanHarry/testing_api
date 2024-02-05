// import mongoose and validator
const mongoose = require("mongoose");
const validator = require("validator/lib/isEmail");

//Schema
const UserSchema = new mongoose.Schema(
    {
        // firstName: {
        //     type: String,
        //     required: true
        // },
        // lastName: {
        //     type: String,
        //     required: true
        // },
        email: {
            type: String,
            required: true,
            unique: true,
            lowercase: true,
            validate: [validator, 'Invalid email']
        },
        // usertype: {
        //     type: String,
        //     enum: ['admin', 'customer', 'driver'],
        //     required: true
        // },
        password: {
            type: String,
            required: true,
        },
        // mobileNumber: {
        //     type: Number,
        //     required: true
        // },
        // incomplete: {
        //     type: Boolean,
        //     default: true,
        //     required: false
        // },
        // otp: {
        //     type: Number,
        //     default: ''
        // }
    },
    { timestamps: true }
);

//exports
module.exports = mongoose.model("User", UserSchema);
