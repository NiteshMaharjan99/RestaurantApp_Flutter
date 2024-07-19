const express = require("express")

require("dotenv").config()

const bcrypt = require("bcryptjs")

const jwt = require("jsonwebtoken")

const User = require("../model/User")

const router = express.Router()

const upload = require('../middleware/upload')

const userController = require("../controllers/user")

const { verifyUser } = require('../middleware/auth')


router.post('/register', (req, res, next) => {
    User.findOne({ username: req.body.username })
        .then((user) => {
            if (user) return res.status(400).
                json({ message: "User already registered" })
            bcrypt.hash(req.body.password, 10, (err, hash) => {
                if (err) return res.status(500).json({ error: err.message })
                const newUser = new User({
                    fname: req.body.fname,
                    lname: req.body.lname,
                    phone: req.body.phone,
                    image: req.body.image,
                    username: req.body.username,
                    password: hash,
                    role:req.body.role,
                });
                newUser.save()
                    .then((user) => res.status(201).json(user))
                    .catch(next)
            })
        }).catch(next)
})

// router.route('/uploadImage')
//     .post(upload.single("profilePicture"), (req, res) => {
//         if (!req.file) {
//             return res.status(400).send({ message: "Please upload a file" });
//         }
//         req.json(req.file)
//     })
router.post('/uploadImage',upload.single("profilePicture"), (req, res) => {
        if (!req.file) {
            return res.status(400).send({ message: "Please upload a file" });
        }
        res.status(200).json({
            success: true,
            data: req.file.filename,
          });
    });


router.post('/login', (req, res, next) => {
    const { username, password } = req.body
    User.findOne({ username })
        .then(user => {
            if (!user) return res
                .status(401).json({ error: 'User is not registered' })
            bcrypt.compare(password, user.password, (err, success) => {
                if (err) return res.status(500).json({ error: err.message })
                if (!success) return res.status(401).json({ error: "Password doesn't match" })

                const payload = {
                    id: user._id,
                    username: user.username,
                    fullname: user.fullname,
                    role: user.role
                }

                jwt.sign(payload, process.env.SECRET, { expiresIn: '1d' }, (err, encoded) => {
                    if (err) res.status(500).json({ error: err.message })
                    res.json({
                        username: user.username,
                        token: encoded
                    })
                })
            })
        }).catch(next)
})

router.route("/getUserData").get(verifyUser, userController.getUserByID)

module.exports = router