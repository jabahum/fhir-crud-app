const ErrorResponse = require('../utils/errorResponse');
const asyncHandler = require("../middleware/async");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const fhir = require("../utils/config");
const jwt = require("jsonwebtoken");
const config = require("nconf")

// get server url
const baseURL = config.get("server:baseURL")




// @desc    Register user
// @route   POST /api/v1/auth/register
// @access  Public
exports.signup = asyncHandler(async (req, res, next) => {

    let resource = req.body;

    fhir.search("Person", { telecom: "email|" + resource.telecom.value })
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

    const { email, password } = req.body

    fhir.search("Person", { telecom: "email|" + email })
        .then((response) => {

            // check if user alreadu existssss`
            if (response.total = 1) {

                let resource = response.entry.find((resource) => resource.resource !== null).resource

                // decrypt compare  user password with hashedPassword
                let details = resource.extension.find(ext =>
                    ext.url === "http://lyecdevelopers.com/fhir/StructureDefinition/lyec-password")

                if (!details) {
                    return res.status(400).json({
                        success: false,
                        message: `Password details don't exist in user  ${resource.id}`,
                        error: "",
                        data: ""
                    })
                }
                let hash = details.extension.find(ext => ext.url === "password")

                let salt = details.extension.find(ext => ext.url === "salt")

                if (!hash || !hash.valueString || !salt || !salt.valueString) {
                    return res.status(400).json({
                        success: false,
                        message: `Hash or salt doesn't exist in user  ${resource.id}`,
                        error: "",
                        data: ""
                    })
                }

                // generate hash for provided password
                // generate hashPassword
                const newPasswordHash = crypto.pbkdf2Sync(password, salt.valueString, 1000, 64, 'sha512').toString('hex')

                if (newPasswordHash == hash.valueString) {

                    // generate Bearer Token

                    const token = jwt.sign({ id: resource.id }, "4a024d70307c5831222ac1d4b8c619ec92c9ade08f18fd1700d74bed39e9c0dfa856f4b80255f5d4cb65f8a9ba71e9658d60d528a1c61eb56256bbe08573d78c", {
                        expiresIn: "7d"
                    })

                    if (!token) {
                        log.error(`Failed to generate token for ${resource.id}`)
                        return res.status(400).json({
                            success: false,
                            message: `Failed to generate token for ${resource.id}`,
                            error: "",
                            data: ""
                        });
                    }

                    //  prepare the response with token
                    const options = {
                        expires: new Date(Number(new Date()) + 315360000000), //cookie expires in 30days from creation
                        httpOnly: true,
                    };

                    if (process.env.NODE_ENV === "production") {
                        options.secure = true;
                    }

                    // send email
                    // sendEmail(
                    //     email,
                    //     "Successfully Logged In",
                    //     {
                    //         name: resource.name[0].text,
                    //     },
                    //     "../views/welcome.handlebars"
                    // );

                    return res.status(200).cookie("token", token, options).json({
                        success: true,
                        token,
                        userId: resource.id,
                    });

                }

                return res.status(400).json({
                    success: false,
                    message: `Failed to login check your email or password`,
                    error: "",
                    data: " "
                })


            } else {
                return res.status(400).json({
                    success: true,
                    message: `Too many users with ${email}`,
                    error: "",
                    data: response
                })
            }
        });


});

// @desc    Logout user
// @route   GET /api/v1/auth/logout
// @access  Private
exports.logout = asyncHandler(async (req, res, next) => {
    res.cookie('token', null, {
        expires: new Date(Date.now()),
        httpOnly: true,
    });
    res.status(200).json({ "success": true, msg: 'user logged out!' });
});

// @desc    Get current logged in user
// @route   GET /api/v1/auth/me
// @access  Private
exports.getMe = asyncHandler(async (req, res, next) => {

    fhir.read("Person", req.user.id)
        .then((response) => {

            if (response) {
                return res.status(200).json({
                    success: true,
                    message: `successfully returned ${req.user.id} details`,
                    error: "",
                    data: response
                })
            }

            return res.status(400).json({
                success: false,
                message: `An error occured while returning your details`,
                error: "",
                data: ""
            })



        }).catch((err) => {
            return res.status(500).json({
                success: false,
                message: `Error returning ${req.user.id} details`,
                error: err.message,
                data: ""
            })
        });

});

// @desc    Update user details`
// @route   PUT /api/v1/auth/updateMe
// @access  Private
exports.updateMe = asyncHandler(async (req, res, next) => { });

// @desc    Forgot password
// @route   POST /api/v1/auth/forgotPassword
// @access  Public
exports.forgotPassword = asyncHandler(async (req, res, next) => {

    const { email } = req.body

    fhir.search("Person", { telecom: "email|" + email })
        .then((response) => {

            // checking if user exists with email provided
            if (!(response.total !== null && response.total == 1)) {
                return res.status(400).json({
                    success: false,
                    message: `User with ${email} does not exit`,
                    error: "",
                    data: ""
                })
            }

            let resource = response.entry
                .find((resource) => resource.resource !== null).resource

            // check for password reset token attached to the user object
            let passwordExtension = response.entry
                .find((resource) => resource.resource !== null).resource.extension
                .find((ext) => ext.url == "http://lyecdevelopers.com/fhir/StructureDefinition/lyec-password")

            if (passwordExtension) {
                var passwordResetToken = passwordExtension.extension.find((ext) => ext.url == "resetPasswordToken").valueString

                let token = "" || passwordResetToken  // not sure abt this but worthy a try to see what magic comes out of it 


                if (passwordResetToken == "PASS") {
                    // generate password reset  token
                    const resetSalt = crypto.randomBytes(16).toString('hex')
                    token = crypto.pbkdf2Sync(resource.id, resetSalt, 1000, 64, 'sha512').toString('hex')

                }

                const url = `${baseURL}/auth/password-reset/${resource.id}/${token}/`;

                // send email to request password reset
                sendEmail(
                    email,
                    "Password Reset",
                    {
                        name: resource.name[0].text,
                        link: url
                    },
                    "../views/requestPasswordReset.handlebars"
                );

                // return response after email sent successfully
                return res.status(200).json({
                    success: true,
                    message: "Successfully sent email to your account please verify",
                    error: "",
                    data: ""
                })



            }



        }).catch((err) => {
            return res.status(500).json({
                success: false,
                message: `An Error Occured while trying to find user with ${email}`,
                error: err.message,
                data: ""
            })
        })

});

// @desc    Reset password
// @route   GET /api/v1/auth/resetPassword/:id/:token
// @access  Public
exports.resetPassword = asyncHandler(async (req, res, next) => {

    fhir.read("Person", req.params.id)
        .then((response) => {

            // check if id is valid 
            if (!response) {
                return res.status(400).json({
                    success: false,
                    message: `User with id ${req.params.id} not found`,
                    error: "",
                    data: ""
                })
            }

            // verify token and send response

            let passwordExtension = response.extension.find((ext) => ext.url == "http://lyecdevelopers.com/fhir/StructureDefinition/lyec-password")



            // return user object after verify token and id  provided by the user
            return res.status(200).json({
                success: true,
                message: "Token was succeessfully verified",
                error: "",
                data: ""
            })

        }).catch((err) => {
            return res.status(500).json({
                success: false,
                message: `Failed to return user with id ${req.params.id} `,
                error: err.message,
                data: ""
            })
        });
});

// @desc    Change password
// @route   PUT /api/v1/auth/changePassword/:id/:token
// @access  Private
exports.changePassword = asyncHandler(async (req, res, next) => { });

//@desc    Verify user account
//@route   GET /api/v1/auth/verify/:id/:token
//@access  Public
exports.verifyUser = asyncHandler(async (req, res, next) => { });