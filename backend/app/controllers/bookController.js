const bookService = require('../services/bookService');

const createBook = async (req, res) => {
  try {
    const { id, title, author, description, price, coverImageUrl, category } = req.body;

    // Create a new book using the book service
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

module.exports = {
  createBook,
  getAllBooks,
  getBooksByCategory,
  getBooksByAuthor,
};
