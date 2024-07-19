const mongoose = require('mongoose');

const menuSchema = new mongoose.Schema({
    menuName: {
        type: String,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    image: {
        type: String,
        required: true,
    },
})

module.exports = mongoose.model("Menu", menuSchema);
