const express = require('express');

//import route protection with JWT TOken
const { protect } = require('../middleware/auth');

const { signup, login, logout, getMe, updateMe, forgotPassword, resetPassword, changePassword } = require('../controllers/auth.controller');

const router = express.Router();

// login user
router.post('/login', login);

// signin user
router.post('/signup', signup);

// logout user
router.get('/logout', logout);

// get current logged in user
router.get('/me', getMe);

// update user details
router.put('/updateMe', updateMe);

// forgot password
router.post('/forgotPassword', forgotPassword);

// reset password  token or verify token
router.get('/resetPassword/:id/:token', resetPassword);

// change password
router.post('/changePassword/:id/:token', changePassword);


module.exports = router;