const jwt = require("jsonwebtoken");

const User_Token_Authentication = (req, res, next) => {
  const token = req.headers["authorization"].split(" ")[1];
  if (!token) {
    return res.send({
      message: "token is expired you are still un-Authorized",
      status: 0,
    });
  }
  try {
    // const SECRET_KEY = "ghfrt";
    const decoded = jwt.verify(token, process.env.JWT_TOKEN);
    req.id = decoded.id;
    next();
  } catch (err) {
    res.status(400).send({ message: "Invalid token.", status: 0 });
  }
  return next;
};
module.exports = User_Token_Authentication;
