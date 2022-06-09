const express = require('express');

//import route protection with JWT TOken
const { protect } = require('../middleware/auth');

const router = express.Router();

const { getFhirResources, getFhirResource, createFhirResource, updateFhirResource, deleteFhirResource } = require('../controllers/fhir.controller');

router.route("/:resource")
    .get(getFhirResources, protect)
    .post(createFhirResource, protect);

router.route("/:resource/:id")
    .get(getFhirResource, protect)
    .put(updateFhirResource, protect)
    .delete(deleteFhirResource, protect);

module.exports = router;