const Menu = require('../model/Menu');
const upload = require('../middleware/upload')
const asyncHandler = require("../middleware/async");


// Get all menus
exports.getAllMenus = (req, res, next) => {
    Menu.find()
        .then((menus) => res.status(200).json({
            success: true,
            count: menus.length,
            data: menus,
        }))
        .catch(next);
};

// Create a new menu with an image
exports.createMenu = (req, res, next) => {
    const { menuName, price, image } = req.body;
    // const imagePath = req.file ? req.file.path : null; // Get the file path of the uploaded image
    Menu.create({ menuName, price, image })
        .then((menu) => res.status(201).json(menu))
        .catch(next);
};

// Get a menu by ID
// exports.getMenuById = (req, res, next) => {
//     Menu.findById(req.params.menu_id)
//         .then((menu) => {
//             if (!menu) return res.status(404).json({ error: 'Menu not found' });
//             res.json(menu);
//         })
//         .catch(next);
// };

exports.getMenuById = async (req, res, next) => {
    try {
        const menu = await Menu.findById(req.params.id);

        if (!menu) {
            return res.status(401).json({ message: "Cannot find the menu  " });
        }

        res.status(200).json({ success: true, data: menu });
    } catch (err) {
        next(err);
    }
};

// Update a menu by ID with an image
exports.updateMenu = async (req, res, next) => {
    try{
        const menu = await Menu.findById(req.params.id);
        if (!menu) {
            return res.status(401).json({ message: "Cannot find the menu  " });
        }
        const { menuName, price, image } = req.body;
        Menu.findByIdAndUpdate(
            req.params.id,
            { menuName, price, image },
            { new: true }
        )
            .then((menu) => {
                if (!menu) return res.status(404).json({ error: 'Menu not found' });
                res.json(menu);
            })
    } catch(err) {
        next(err);
    }
};

// Delete a menu by ID
exports.deleteMenu = async (req, res, next) => {
    await Menu.findByIdAndDelete(req.params.id).then((menu) => {
        if (!menu) {
            return res
                .status(404)
                .json({ message: "Menu not found with id of ${req.params.id}" });
        }
        res.status(200).json({ success: true });
    });
};

exports.menuImageUpload = upload.single("menuImage"), (req, res) => {
    // // check for the file size and send an error message
    // if (req.file.size > process.env.MAX_FILE_UPLOAD) {
    //   return res.status(400).send({
    //     message: `Please upload an image less than ${process.env.MAX_FILE_UPLOAD}`,
    //   });
    // }

    if (!req.file) {
        return res.status(400).send({ message: "Please upload a file" });
    }
    res.status(200).json({
        success: true,
        data: req.file.filename,
    });
};
