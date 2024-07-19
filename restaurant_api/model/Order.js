const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema(
  {
    // Array of products in the order
    menus: {
      type: [mongoose.Schema.Types.Mixed], 
      required: true,
    },
    // Total order amount
    totalAmount: {
      type: Number,
      required: true,
    },
    status: {
      type: String,
      required: true,
      default: 'pending',
    },
    Date: {
      type: Date,
      default: Date.now
    }
  },
  {
    // Setting the "timestamps" option to true will automatically add "createdAt" and "updatedAt" fields
    timestamps: true,
  }
);

const Order = mongoose.model('Order', orderSchema);

module.exports = Order;
