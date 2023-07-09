const express = require('express');
const bookController = require('../controllers/bookController');

const router = express.Router();

// Create a book
router.post('/', bookController.createBook);

// Get all books
router.get('/', bookController.getAllBooks);

// Get books by category
router.get('/category/:category', bookController.getBooksByCategory);

// Get books by author name
router.get('/author/:author', bookController.getBooksByAuthor);

module.exports = router;
