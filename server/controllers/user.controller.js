const ErrorResponse = require('../utils/errorResponse');
const asyncHandler = require("../middleware/async");
const fhir = require('../utils/config');



// @desc fetch all users
// @route GET /api/v1/user
// @access Private
exports.getUsers = asyncHandler(async (req, res, next) => {
    fhir.read('Person')
        .then((resource) => {
            res.status(200).json({
                success: true,
                message: "Successfully fetched all Users",
                error: "",
                data: resource
            });
        }).catch((err) => {
            return res.status(400).json({
                success: false,
                error: err
            });
        })
});


// @desc fetch single user
// @route GET /api/v1/user/:id
// @access Private
exports.getUser = asyncHandler(async (req, res, next) => {
    fhir.read("Person", req.params.id)
        .then((resource) => {

            if (!resource) {
                return res.status(404).json({
                    success: false,
                    message: "Resource not found",
                    error: "Resource not found",
                    data: "",
                })
            }

            res.status(200).json({
                success: true,
                message: `Successfully fetched User with id: ${req.params.id}`,
                error: "",
                data: resource
            });
        }).catch((err) => {
            return res.status(400).json({
                success: false,
                message: "Failed to fetch single fhir resource",
                error: err.message,
                data: ""
            });
        });
});


// @desc create user
// @route POST /api/v1/user
// @access Private
exports.createUser = asyncHandler(async (req, res, next) => {
    fhir.create(req.body)
        .then((resource) => {

            if (!resource) {
                return res.status(404).json({
                    success: false,
                    message: "Resource not found",
                    error: "Resource not found",
                    data: "",
                });
            }

            return res.status(200).json({
                success: true,
                message: "Successfully created fhir resource",
                error: "",
                data: resource
            });

        }).catch((err) => {

            return res.status(400).json({
                success: false,
                message: "Failed to create fhir resource",
                error: err.message,
                data: ""
            });

        });
});


// @desc update user
// @route PUT /api/v1/user/:id
// @access Private
exports.updateUser = asyncHandler(async (req, res, next) => {
    fhir.update(req.body)
        .then((resource) => {

            if (!resource) {
                return res.status(404).json({
                    success: false,
                    message: "Resource not found",
                    error: "Resource not found",
                    data: "",
                });
            }

            return res.status(200).json({
                success: true,
                message: `Successfully updated User with id: ${req.params.id}`,
                error: "",
                data: resource
            });

        }).catch((err) => {

            return res.status(400).json({
                success: false,
                message: "Failed to update fhir resource",
                error: err.message,
                data: ""
            });

        });

});


// @desc delete user
// @route DELETE /api/v1/user/:id
// @access Private
exports.deleteUser = asyncHandler(async (req, res, next) => {
    let id  = req.body.id || req.params.id
    fhir.delete("Person", id).then((resource) => {

        if (!resource) {
            return res.status(404).json({
                success: false,
                message: "Resource not found",
                error: "Resource not found",
                data: "",
            });
        }

        return res.status(200).json({
            success: true,
            message: `Successfully deleted User with id: ${req.params.id}`,
            error: "",
            data: resource
        });


    }).catch((err) => {
        return res.status(400).json({
            success: false,
            message: "Failed to delete fhir resource",
            error: err.message,
            data: ""
        });

    });
});