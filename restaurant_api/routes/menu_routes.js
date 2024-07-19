const express = require("express");

const router = express.Router();

const { verifyAdmin, verifyUser } = require('../middleware/auth')


const {
    getAllMenus,
    getMenuById,
    createMenu,
    updateMenu,
    deleteMenu,
    menuImageUpload
} = require("../controllers/menu")

router.get("/getAllMenus", getAllMenus);
router.get("/:id", getMenuById);
router.post("/menuImageUpload", menuImageUpload);

router.post("/createMenu", createMenu);
router.put("/:id", verifyUser, updateMenu);
router.delete("/:id", verifyUser, deleteMenu);

module.exports = router;

// // Routes for managing menu
// router.route('/getAllMenus')
//     .get((req, res, next) => {
//         Menu.find()
//             .then((menus) =>  res.status(200).json({
//                 success: true,
//                 count: menus.length,
//                 data: menus,
//               }))
//             .catch(next)
//     })

// router.route('/')
//     .post(verifyAdmin, (req, res, next) => {
//         Menu.create(req.body)
//             .then((menu) => res.status(201).json(menu))
//             .catch(err => next(err))
//     })
//     .put((req, res) => {
//         res.status(405).json({ error: "PUT request is not allowed" })
//     })
//     .delete(verifyAdmin, (req, res, next) => {
//         Menu.deleteMany()
//         .then(reply => res.json(reply))
//         .catch(next)
//     })


// router.route('/:menu_id')
//     .get((req, res, next) => {
//         Menu.findById(req.params.menu_id)
//             .then((menu) => {
//                 if (!menu) return res.status(404).json({ error: 'Menu not found ' })
//                 // const Menu_1 = menu.id(req.params.menu_id)
//                 res.json(menu)
//             }).catch(next)
//     })
//     .post(verifyAdmin, (req, res) => {
//         res.status(405).json({ error: 'POST request is not allowed' })
//     })
//     .put(verifyAdmin, (req, res, next) => {
//         Menu.findById(req.params.menu_id)
//             .then((menu) => {
//                 if (!menu) return res.status(404).json({ error: 'Menu not found ' })

//                 menu = menu.map((r) => {
//                     if (r._id == req.params.menu_id) {
//                         r.menuName = req.body.menuName
//                         r.price = req.body.price
//                     }
//                     return r
//                 })
//                 menu.save()
//                     .then(menu => {
//                         res.json(menu.id(req.params.menu_id))
//                     }).catch(next)

//             }).catch(next)
//     })
//     .delete(verifyAdmin, (req, res, next) => {
//         Menu.findByIdAndDelete(req.params.menu_id)
//         .then(reply => res.status(204).end())
//         .catch(next)
//     })

