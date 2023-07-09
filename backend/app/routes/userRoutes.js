const express = require('express');
const userController = require('../controllers/userController');

const router = express.Router();

// Register a user
router.post('/register', userController.registerUser);

// User login
router.post('/login', userController.loginUser);

// Add book to user's wishlist
router.post('/:userId/wishlist/:bookId', userController.addToWishlist);

// Get user's wishlist
router.get('/:userId/wishlist', userController.getWishlistByUserId);

// Purchase a book for the user
router.post('/:userId/purchasedBooks/:bookId', userController.purchaseBook);

// Get user's purchased books
router.get('/:userId/purchasedBooks', userController.getPurchasedBooksByUserId);

// Get user by user ID
router.get('/:userId', userController.getUserById);

module.exports = router;
