const jwt = require("jsonwebtoken");
const asyncHandler = require("./async");
const ErrorResponse = require("../utils/errorResponse.js");
const fhir = require("../utils/config");

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
    const decodedToken = jwt.verify(token, "4a024d70307c5831222ac1d4b8c619ec92c9ade08f18fd1700d74bed39e9c0dfa856f4b80255f5d4cb65f8a9ba71e9658d60d528a1c61eb56256bbe08573d78c");

    fhir.read("Person", decodedToken.id)
      .then((resource) => {
        req.user = resource
        next();

      }).catch((err) => {
        return next(new ErrorResponse(`An error occured ${err.message}`))
      })

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
