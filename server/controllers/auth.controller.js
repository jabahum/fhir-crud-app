const ErrorResponse = require('../utils/errorResponse');
const asyncHandler = require("../middleware/async");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const fhir = require("../utils/config");

// @desc    Register user
// @route   POST /api/v1/auth/register
// @access  Public
exports.signup = asyncHandler(async (req, res, next) => {

    let resource = req.body;

    fhir.search("Person", resource.telecom.value)
        .then((response) => {

            // check if user alreadu existssss`
            if (response.total > 1) {
                return res.status(400).json({
                    success: false,
                    message: `User already exists`,
                    error: "",
                    data: ""
                })
            }


            // do the rest here 
            const password = resource.extension.find((ext) => ext.url == "http://lyecdevelopers.com/fhir/StructureDefinition/lyec-password").valueString

            // generate hashPassword
            const salt = crypto.randomBytes(16).toString('hex')
            const passwordHash = crypto.pbkdf2Sync(password, salt, 1000, 64, 'sha512').toString('hex')


            var passwordExtension = {
                "url": "http://lyecdevelopers.com/fhir/StructureDefinition/lyec-password",
                "extension": [
                    {
                        "url": "password",
                        "valueString": passwordHash
                    },
                    {
                        "url": "salt",
                        "valueString": salt
                    }
                ]
            }

            resource.extension.push(passwordExtension)


            // user creation 
            fhir.create(resource)
                .then((newUser) => {
                    if (newUser) {
                        return res.status(200).json({
                            success: true,
                            message: "Successfully SignUp User",
                            error: "",
                            data: newUser
                        })
                    }

                }).catch((err) => {
                    res.status(500).json({
                        success: false,
                        message: "Failed to SignUp user",
                        error: err.message,
                        data: ""

                    })

                })

        }).catch((err) => {
            return res.status(500).json({
                success: false,
                message: "An error occured while  search for users with the same email",
                error: err.message,
                data: ""
            })

        })

});

// @desc    Login user
// @route   POST /api/v1/auth/login
// @access  Public
exports.login = asyncHandler(async (req, res, next) => {



});

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

//@desc    Verify user account
//@route   GET /api/v1/auth/verify/:id/:token
//@access  Public
exports.verifyUser = asyncHandler(async (req, res, next) => { });