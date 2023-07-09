const Book = require('../models/book');

const createBook = async (bookData) => {
  const book = new Book(bookData);
  await book.save();

  return book;
};

const getAllBooks = async () => {
  const books = await Book.find();
  return books;
};

const getBooksByCategory = async (category) => {
  const books = await Book.find({ category });
  return books;
};

const getBooksByAuthor = async (author) => {
  const books = await Book.find({ author });
  return books;
};

module.exports = {
  createBook,
  getAllBooks,
  getBooksByCategory,
  getBooksByAuthor,
};
