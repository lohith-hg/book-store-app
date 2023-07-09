const mongoose = require("mongoose");

const bookSchema = new mongoose.Schema({
  id: { type: String, required: true, unique: true },
  title: { type: String, required: true },
  author: { type: String, required: true },
  description: { type: String, required: false },
  dateAdded: { type: Date, default: Date.now },
  price: { type: Number, required: true },
  coverImageUrl: { type: String, required: false },
  category: { type: String, required: true },
});

const Book = mongoose.model("Book", bookSchema);

module.exports = Book;
