const orderService = require('../services/orderService');

// Create a new order
const createOrder = async (req, res) => {
  try {
    const { userId, bookId, amount } = req.body;
    const order = await orderService.createOrder(userId, bookId, amount);

    res.status(201).json({ message: 'Order created successfully', order });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error creating order' });
  }
};

const getOrdersByUserId = async (req, res) => {
  try {
    const { userId } = req.params;
    const orders = await orderService.getOrdersByUserId(userId);
    res.status(200).json({ orders });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving orders by user ID' });
  }
};


module.exports = {
  createOrder,
  getOrdersByUserId,
};
