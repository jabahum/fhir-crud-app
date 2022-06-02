const express = require('express');

//import route protection with JWT TOken
const { protect } = require('../middleware/auth');

const router = express.Router();

const { getFhirResources, getFhirResource, createFhirResource, updateFhirResource, deleteFhirResource } = require('../controllers/fhir.controller');

router.route("/")
    .get(getFhirResources)
    .post(createFhirResource);

router.route("/:id")
    .get(getFhirResource)
    .put(updateFhirResource)
    .delete(deleteFhirResource);

module.exports = router;