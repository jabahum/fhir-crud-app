const ErrorResponse = require('../utils/errorResponse');
const asyncHandler = require("../middleware/async");
const bcrypt = require("bcrypt");
const crypto = require("crypto");

// @desc    Register user
// @route   POST /api/v1/auth/register
// @access  Public
exports.signup = asyncHandler(async (req, res, next) => { });

// @desc    Login user
// @route   POST /api/v1/auth/login
// @access  Public
exports.login = asyncHandler(async (req, res, next) => { });

// @desc    Logout user
// @route   GET /api/v1/auth/logout
// @access  Private
exports.logout = asyncHandler(async (req, res, next) => { });

// @desc    Get current logged in user
// @route   GET /api/v1/auth/me
// @access  Private
exports.getMe = asyncHandler(async (req, res, next) => { });

// @desc    Update user details`
// @route   PUT /api/v1/auth/updateMe
// @access  Private
exports.updateMe = asyncHandler(async (req, res, next) => { });

// @desc    Forgot password
// @route   POST /api/v1/auth/forgotPassword
// @access  Public
exports.forgotPassword = asyncHandler(async (req, res, next) => { });

// @desc    Reset password
// @route   GET /api/v1/auth/resetPassword/:id/:token
// @access  Public
exports.resetPassword = asyncHandler(async (req, res, next) => { });

// @desc    Change password
// @route   PUT /api/v1/auth/changePassword/:id/:token
// @access  Private
exports.changePassword = asyncHandler(async (req, res, next) => { });