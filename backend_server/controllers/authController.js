//1. Register
const User = require('../models/User')
const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const {validationResult} = require('express-validator')
const { where } = require('sequelize')

exports.register = async (req, res)=> {
    //1. check lỗi validation
    const errors = validationResult(req)
    if (!errors.isEmpty())
    {
        return res.status(400).json(
            {
                errors: errors.array()
            }
        )
    }

    const {full_name, email, phone_number, password, role, tax_code} = req.body

    try
    {
        let user = await  User.findOne({where: {email}})
        if (user)
        {
            return res.status(400).json({message: 'Email đã được sử dụng'})
        }

        const salt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(password, salt)

        user = await User.create(
            {
                full_name,
                email,
                phone_number,
                password_hash: hashedPassword,
                role: role || 'renter',
                tax_code
            }
        )

        const payload = {user: {id: user.id}}
        jwt.sign(
            payload,
            process.env.JWT_SECRET,
            {expiresIn: '30d'},
            (err, token) => {
                if (err) throw err
                res.status(201).json(
                    {
                        message: 'Đăng ký thành công',
                        token: token
                    }
                )
            }
        )
    }
    catch (err)
    {
        console.error(err.message)
        res.status(500).json({message: 'Lỗi server'})
    }
}

//2. Login
exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;

        // 1. Tìm User theo email
        const user = await User.findOne({ where: { email: email } });
        if (!user) {
            return res.status(404).json({ message: "Email không tồn tại" });
        }

        // 2. SO SÁNH MẬT KHẨU BẰNG BCRYPT
        // bcrypt sẽ tự động lấy password nhập vào, hash nó theo thuật toán
        // và so sánh với chuỗi hash trong user.password_hash
        const isMatch = await bcrypt.compare(password, user.password_hash);

        if (!isMatch) {
            // Nếu không khớp
            return res.status(401).json({ message: "Mật khẩu không chính xác" });
        }

        // 3. Đăng nhập thành công
        const { password_hash, ...userInfo } = user.dataValues;
        return res.status(200).json({
            message: "Đăng nhập thành công",
            user: userInfo,
        });

    } catch (error) {
        console.error("Lỗi server:", error);
        return res.status(500).json({ message: "Lỗi server" });
    }
};