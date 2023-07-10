const userService = require('../services/userService');

const registerUser = async (req, res) => {
  try {
    const userId = await userService.registerUser(req.body);
    const token = userService.generateToken(userId);
    res.status(201).json({ token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error registering user' });
  }
};

const loginUser = async (req, res) => {
  try {
    const { email, password } = req.params;
    const userId = await userService.loginUser(email,password);
    const token = userService.generateToken(userId);
    res.status(200).json({ token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error logging in user' });
  }
};

 // Add book to user's wishlist
const addToWishlist = async (req, res) => {
  try {
    const { userId, bookId } = req.params;
    await userService.addToWishlist(userId, bookId);

    res.status(200).json({ message: 'Book added to wishlist successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error adding book to wishlist' });
  }
};

 // Retrieve user's wishlist
const getWishlistByUserId = async (req, res) => {
  try {
    const { userId } = req.params;
    const wishlist = await userService.getWishlistByUserId(userId);

    res.status(200).json({ wishlist });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving wishlist' });
  }
};

// Purchase book for the user
const purchaseBook = async (req, res) => {
  try {
    const { userId, bookId } = req.params;
    await userService.purchaseBook(userId, bookId);

    res.status(200).json({ message: 'Book purchased successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error purchasing book' });
  }
};

const getPurchasedBooksByUserId = async (req, res) => {
  try {
    const { userId } = req.params;
    const purchasedBooks = await userService.getPurchasedBooksByUserId(userId);
    res.status(200).json({ purchasedBooks });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving purchased books' });
  }
};

const getUserById = async (req, res) => {
  try {
    const { userId } = req.params;
    const user = await userService.getUserById(userId);
    res.status(200).json({ user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving user 1' });
  }
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
