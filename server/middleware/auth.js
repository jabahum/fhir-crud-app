const jwt = require("jsonwebtoken");
const asyncHandler = require("./async");
const ErrorResponse = require("../utils/errorResponse.js");
// const User = require("../models/user.models");

//protect routes
exports.protect = asyncHandler(async (req, res, next) => {
  let token;

  if (req.headers.authorization && req.headers.authorization.startsWith("Bearer")) {
    // check if bearer exits in the headers
    token = req.headers.authorization.split(" ")[1];

  } else if (req.cookies.token) {
    // check if bearer exists in the cookies
    token = req.cookies.token;
  }

  //confirm that token exists
  if (!token) {

    return next(new ErrorResponse("Access Denied for this route", 401));
  }

  try {
    //verify token
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);

    // req.user = await User.findById(decodedToken.id);

    next();

  } catch (err) {

    return next(new ErrorResponse("Access Denied for this route", 401));
  }

});

//Grant Access to specific users
exports.authorize = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      return next(new ErrorResponse("Access denied for non Admin", 403));
    }
    next();
  };
};
