const userService = require('../services/userService');

const registerUser = async (req, res) => {
  try {
    // Extract user details from request body
    const { email, password, name } = req.body;

    // Create a new user using the user service
    const user = await userService.registerUser({
      email,
      password,
      name,
    });

    res.status(201).json({ message: 'User registered successfully', user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error registering user' });
  }
};

const loginUser = async (req, res) => {
  try {
    // Extract user credentials from request body
    const { email, password } = req.body;

    // Authenticate user using the user service
    const user = await userService.loginUser(email, password);

    if (!user) {
      res.status(401).json({ message: 'Invalid email or password' });
    } else {
      res.status(200).json({ message: 'User logged in successfully', user });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error logging in user' });
  }
};

const addToWishlist = async (req, res) => {
  try {
    const { userId, bookId } = req.params;

    // Add book to user's wishlist using the user service
    await userService.addToWishlist(userId, bookId);

    res.status(200).json({ message: 'Book added to wishlist successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error adding book to wishlist' });
  }
};

const getWishlistByUserId = async (req, res) => {
  try {
    const { userId } = req.params;

    // Retrieve user's wishlist using the user service
    const wishlist = await userService.getWishlistByUserId(userId);

    res.status(200).json({ wishlist });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving wishlist' });
  }
};

const purchaseBook = async (req, res) => {
  try {
    const { userId, bookId } = req.params;

    // Purchase book for the user using the user service
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

    // Retrieve user's purchased books using the user service
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

    // Retrieve user by user ID using the user service
    const user = await userService.getUserById(userId);

    res.status(200).json({ user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving user' });
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
