const mongoose = require('mongoose');

const restaurantSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },

  orders: [
    {
      tableNumber: {
        type: Number,
        required: true,
      },
      items: [
        {
          name: {
            type: String,
            required: true,
          },
          price: {
            type: Number,
            required: true,
          },
          quantity: {
            type: Number,
            required: true,
          },
        },
      ],
      totalAmount: {
        type: Number,
        required: true,
      },
      createdAt: {
        type: Date,
        default: Date.now,
      },
      completed: {
        type: Boolean,
        default: false,
      },
      user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
      },

    },
  ],
});

const Restaurant = mongoose.model('Restaurant', restaurantSchema);

module.exports = Restaurant;
