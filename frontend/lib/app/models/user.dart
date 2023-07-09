import 'package:json_annotation/json_annotation.dart';

import 'book.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String? email;
  String? password;
  String? name;
  List<WishlistItem>? wishlist;
  List<PurchasedBook>? purchasedBooks;
  DateTime? createdAt;

  User({
    this.email,
    this.password,
    this.name,
    this.wishlist,
    this.purchasedBooks,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class WishlistItem {
  Book? book;
  DateTime? addedAt;

  WishlistItem({
    this.book,
    this.addedAt,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) => _$WishlistItemFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistItemToJson(this);
}

@JsonSerializable()
class PurchasedBook {
  Book? book;
  DateTime? purchasedAt;

  PurchasedBook({
    this.book,
    this.purchasedAt,
  });

  factory PurchasedBook.fromJson(Map<String, dynamic> json) => _$PurchasedBookFromJson(json);
  Map<String, dynamic> toJson() => _$PurchasedBookToJson(this);
}