const ErrorResponse = require('../utils/errorResponse');
const asyncHandler = require("../middleware/async");
const fhir = require('../utils/config');


// @desc fetch all fhir
// @route GET /api/v1/fhir
// @access Private
exports.getFhirResources = asyncHandler(async (req, res, next) => {
    fhir.read(req.params.resource)
        .then((resource) => {
            res.status(200).json({
                success: true,
                message: "Successfully fetched all fhir resources",
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

// @desc fetch single fhir
// @route GET /api/v1/fhir/:id
// @access Private
exports.getFhirResource = asyncHandler(async (req, res, next) => {
    fhir.read(req.params.resource, req.params.id)
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
                message: "Successfully fetched single fhir resource",
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

// @desc create fhir
// @route POST /api/v1/fhir
// @access Private
exports.createFhirResource = asyncHandler(async (req, res, next) => {
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

// @desc update fhir
// @route PUT /api/v1/fhir/:id
// @access Private
exports.updateFhirResource = asyncHandler(async (req, res, next) => {
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
                message: "Successfully updated fhir resource",
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

// @desc delete fhir
// @route DELETE /api/v1/fhir/:id
// @access Private
exports.deleteFhirResource = asyncHandler(async (req, res, next) => {
    fhir.delete(req.params.resource, req.body.id).then((resource) => {

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
            message: "Successfully deleted fhir resource",
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