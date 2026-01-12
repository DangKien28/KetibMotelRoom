const express = require('express')
const router = express.Router()
const authController = require('../controllers/authController')
const {body} = require('express-validator')

//1. Register
router.post(
    '/register',
    [
        body('full_name').trim().notEmpty().withMessage('Họ tên không được trống'),
        body('email').trim().isEmail().withMessage('Email không hợp lệ'),
        body('phone_number').trim().isNumeric().withMessage('Số điện thoại không hợp lệ'),
        body('password').isLength({min: 6}).withMessage('Mật khẩu phải có ít nhất 6 ký tự')
    ],
    authController.register
)
module.exports = router

//2. Login
router.post('/login', authController.login); // <--- Thêm dòng này

module.exports = router;