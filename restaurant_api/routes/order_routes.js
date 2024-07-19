// routes/orderRoutes.js
const express = require('express');
const router = express.Router();

// Import the order controller
const orderController = require('../controllers/order');

// Define the routes for orders
router.get('/', orderController.getAllOrders);
router.get('/:id', orderController.getOrderById);
router.post('/', orderController.createOrder);
router.put('/:id', orderController.updateOrder);
router.delete('/:id', orderController.deleteOrder);
router.put('/:id', orderController.updateStatusToPaid);

module.exports = router;
