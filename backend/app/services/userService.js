const User = require('../models/user');

const registerUser = async (userData) => {
  const user = new User(userData);
  await User.create(user);
  return user;
};

const loginUser = async (email, password) => {
  const user = await User.findOne({ email, password });
  return user;
};

const addToWishlist = async (userId, bookId) => {
  await User.findByIdAndUpdate(userId, { $push: { wishlist: { book: bookId } } });
};

const getWishlistByUserId = async (userId) => {
  const user = await User.findById(userId).populate('wishlist.book');
  return user.wishlist;
};

const purchaseBook = async (userId, bookId) => {
  await User.findByIdAndUpdate(userId, { $push: { purchasedBooks: { book: bookId } } });
};

const getPurchasedBooksByUserId = async (userId) => {
  const user = await User.findById(userId).populate('purchasedBooks.book');
  return user.purchasedBooks;
};

const getUserById = async (userId) => {
  const user = await User.findById(userId);
  return user;
};


module.exports = {
  registerUser,
  loginUser,
  addToWishlist,
  getWishlistByUserId,
  purchaseBook,
  getPurchasedBooksByUserId,
  getUserById,
};
