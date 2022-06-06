const express = require('express');
//import route protection with JWT TOken
const { protect, authorize } = require("../middleware/auth");

const router = express.Router();

const { getUsers, getUser, createUser, updateUser, deleteUser } = require("../controllers/user.controller");


router.route("/Person")
    .get(getUsers)
    .post(createUser);

router.route("/Person/:id")
    .get(getUser)
    .put(updateUser)
    .delete(deleteUser);


module.exports = router;