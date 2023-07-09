const Order = require('../models/order');

const createOrder = async (userId, bookId, amount) => {
  const order = new Order({ user: userId, book: bookId, amount });
  await order.save();
  return order;
};

const getOrdersByUserId = async (userId) => {
  const orders = await Order.find({ user: userId }).populate('book');
  return orders;
};

module.exports = {
  createOrder,
  getOrdersByUserId,
};
