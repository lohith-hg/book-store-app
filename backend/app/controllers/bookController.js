const bookService = require('../services/bookService');
const Book = require('../models/book');

 // Create a new book
const createBook = async (req, res) => {
  try {
    const { id, title, author, description, price, coverImageUrl, category } = req.body;
    const book = await bookService.createBook({
      id,
      title,
      author,
      description,
      price,
      coverImageUrl,
      category,
    });

    res.status(201).json({ message: 'Book created successfully', book });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error creating book' });
  }
};

const getAllBooks = async (req, res) => {
  try {
    const books = await bookService.getAllBooks();
    res.status(200).json({ books });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving books' });
  }
};

const getBooksByCategory = async (req, res) => {
  try {
    const { category } = req.params;
    const books = await bookService.getBooksByCategory(category);
    res.status(200).json({ books });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving books by category' });
  }
};

const getBooksByAuthor = async (req, res) => {
  try {
    const { author } = req.params;
    const books = await bookService.getBooksByAuthor(author);
    res.status(200).json({ books });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving books by author' });
  }
};

// Search books by title
const searchBooksByTitle = async (req, res) => {
  try {
    const { title } = req.query;
    const books = await bookService.searchBooksByTitle(title);
    res.status(200).json({ books });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error searching books' });
  }
};

module.exports = {
  createBook,
  getAllBooks,
  getBooksByCategory,
  getBooksByAuthor,
  searchBooksByTitle
};
