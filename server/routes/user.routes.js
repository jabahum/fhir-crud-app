const express = require('express');
//import route protection with JWT TOken
const { protect, authorize } = require("../middleware/auth");

const router = express.Router();

const { getUsers, getUser, createUser, updateUser, deleteUser } = require("../controllers/user.controller");


router.route("/Person")
    .get(getUsers, protect)
    .post(createUser, protect);

router.route("/Person/:id")
    .get(getUser, protect)
    .put(updateUser, protect)
    .delete(deleteUser, protect);


module.exports = router;