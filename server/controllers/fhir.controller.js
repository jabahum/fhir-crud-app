const ErrorResponse = require('../utils/errorResponse');
const asyncHandler = require("../middleware/async");


// @desc fetch all fhir
// @route GET /api/v1/fhir
// @access Private
exports.getFhirResources = asyncHandler(async (req, res, next) => { });

// @desc fetch single fhir
// @route GET /api/v1/fhir/:id
// @access Private
exports.getFhirResource = asyncHandler(async (req, res, next) => { });

// @desc create fhir
// @route POST /api/v1/fhir
// @access Private
exports.createFhirResource = asyncHandler(async (req, res, next) => { });

// @desc update fhir
// @route PUT /api/v1/fhir/:id
// @access Private
exports.updateFhirResource = asyncHandler(async (req, res, next) => { });

// @desc delete fhir
// @route DELETE /api/v1/fhir/:id
// @access Private
exports.deleteFhirResource = asyncHandler(async (req, res, next) => { });