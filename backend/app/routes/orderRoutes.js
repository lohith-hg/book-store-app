const express = require('express');
const orderController = require('../controllers/orderController');

const router = express.Router();

// Create an order
router.post('/', orderController.createOrder);

// Get orders by user ID
router.get('/user/:userId', orderController.getOrdersByUserId);

module.exports = router;
