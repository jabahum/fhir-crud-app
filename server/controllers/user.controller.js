const ErrorResponse = require('../utils/errorResponse');
const asyncHandler = require("../middleware/async");


// @desc fetch all users
// @route GET /api/v1/user
// @access Private
exports.getUsers = asyncHandler(async (req, res, next) => { });


// @desc fetch single user
// @route GET /api/v1/user/:id
// @access Private
exports.getUser = asyncHandler(async (req, res, next) => { });


// @desc create user
// @route POST /api/v1/user
// @access Private
exports.createUser = asyncHandler(async (req, res, next) => { });


// @desc update user
// @route PUT /api/v1/user/:id
// @access Private
exports.updateUser = asyncHandler(async (req, res, next) => { });


// @desc delete user
// @route DELETE /api/v1/user/:id
// @access Private
exports.deleteUser = asyncHandler(async (req, res, next) => { });