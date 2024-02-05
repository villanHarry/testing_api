// packages
const router = require("express").Router();
const Auth = require("../Middleware/Authentication");
const {
  UserLogin,
  UserRegisteration,
  getProfile,
} = require("../Controllers/UserControllers");

// routes
router.get("/login", UserLogin);
router.post("/signup", UserRegisteration);
router.get("/profile", Auth, getProfile);

// exports
module.exports = router;
