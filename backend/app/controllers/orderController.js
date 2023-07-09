const orderService = require('../services/orderService');

const createOrder = async (req, res) => {
  try {
    const { userId, bookId, amount } = req.body;

    // Create a new order using the order service
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

    // Retrieve orders by user ID using the order service
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
