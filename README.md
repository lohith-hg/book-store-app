# book-store-app

#Project Models
##Book Schema
Description: Represents a book in the application.

Attributes:

id (String, required, unique): Unique identifier for the book.
title (String, required): Title of the book.
author (String, required): Author of the book.
description (String, optional): Description of the book.
dateAdded (Date, optional): Date the book was added (default: current date).
price (Number, required): Price of the book.
coverImageUrl (String, optional): URL of the book's cover image.
bookUrl (String, required): URL of the PDF.
category (String, required): Category of the book.

##User Schema
Description: Represents a user in the application.

Attributes:

email (String, required, unique): User's email address (lowercase, trimmed).
password (String, required): User's password (trimmed).
name (String, required): User's name (trimmed).
wishlist (Array of WishlistItem, optional): User's wishlist of books.
purchasedBooks (Array of PurchasedItem, optional): Books purchased by the user.
createdAt (Date, optional): Date the user document was created (default: current date).

##Order Schema
Description: Represents an order in the application.

Attributes:

user (User, required): Reference to the user who placed the order.
book (Book, required): Reference to the book that was ordered.
amount (Number, required): Total amount of the order.
paymentStatus (String, optional): Status of the payment for the order (enum: 'pending', 'completed', default: 'pending').
createdAt (Date, optional): Date the order was created (default: current date).
