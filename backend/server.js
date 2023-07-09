const express = require('express');
const app = express();

const mongoose = require('mongoose');
const bookRoutes = require('./app/routes/bookRoutes');
const userRoutes = require('./app/routes/userRoutes');
const orderRoutes = require('./app/routes/orderRoutes');

const bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const mongoDbPath = "mongodb+srv://lohith_hg:Axr3IevsTU5ITEgc@cluster0.1jqfxb4.mongodb.net/bookStoreDb";

mongoose.connect(mongoDbPath).then(function() {

});


// Routes
app.use('/books', bookRoutes);
app.use('/users', userRoutes);
app.use('/orders', orderRoutes);


app.get('/', (req, res) => {
  res.send('Welcome to the Bookstore API');
});


const PORT = process.env.PORT || 5000;
app.listen(PORT, function (req, res) {
  console.log("Server started on " + PORT);
});
