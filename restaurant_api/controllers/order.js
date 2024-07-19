// controllers/orderController.js
const Order = require('../model/Order');


// Controller actions for orders
const orderController = {
  // Get all orders
  getAllOrders: async (req, res) => {
    try {
      const orders = await Order.find();
      res.status(200).json(orders);
    } catch (err) {
      res.status(500).json({ error: 'Error fetching orders' });
    }
  },

  // Get a specific order by ID
  getOrderById: async (req, res) => {
    try {
      const order = await Order.findById(req.params.id);
      if (!order) {
        return res.status(404).json({ error: 'Order not found' });
      }
      res.status(200).json(order);
    } catch (err) {
      res.status(500).json({ error: 'Error fetching order' });
    }
  },

  // Create a new order
  createOrder: async (req, res) => {
    try {
        
      const {  menus, totalAmount } = req.body;
      const order = await Order.create({ menus, totalAmount });
      res.status(201).json(order);
    } catch (err) {
      res.status(500).json({ error: 'Error creating order' });
    }
  },

  // Update an existing order by ID
  updateOrder: async (req, res) => {
    try {
      const { menus, totalAmount } = req.body;
      const updatedOrder = await Order.findByIdAndUpdate(
        req.params.id,
        { user, menus, totalAmount },
        { new: true }
      );
      if (!updatedOrder) {
        return res.status(404).json({ error: 'Order not found' });
      }
      res.status(200).json(updatedOrder);
    } catch (err) {
      res.status(500).json({ error: 'Error updating order' });
    }
  },

  // Delete an order by ID
  deleteOrder: async (req, res) => {
    try {
      const deletedOrder = await Order.findByIdAndDelete(req.params.id);
      if (!deletedOrder) {
        return res.status(404).json({ error: 'Order not found' });
      }
      res.status(200).json({ message: 'Order deleted successfully' });
    } catch (err) {
      res.status(500).json({ error: 'Error deleting order' });
    }
  },

  updateStatusToPaid: async (req, res) => {
    try {
      const updatedOrder = await Order.findByIdAndUpdate(
        req.params.id,
        { status: 'paid' }, // Update the status to 'paid'
        { new: true }
      );

      if (!updatedOrder) {
        return res.status(404).json({ error: 'Order not found' });
      }

      res.status(200).json(updatedOrder);
    } catch (err) {
      res.status(500).json({ error: 'Error updating status to paid' });
    }
  },
};

module.exports = orderController;
