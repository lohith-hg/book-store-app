// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      wishlist: (json['wishlist'] as List<dynamic>?)
          ?.map((e) => WishlistItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      purchasedBooks: (json['purchasedBooks'] as List<dynamic>?)
          ?.map((e) => PurchasedBook.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'wishlist': instance.wishlist,
      'purchasedBooks': instance.purchasedBooks,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

WishlistItem _$WishlistItemFromJson(Map<String, dynamic> json) => WishlistItem(
      book: json['book'] == null
          ? null
          : Book.fromJson(json['book'] as Map<String, dynamic>),
      addedAt: json['addedAt'] == null
          ? null
          : DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$WishlistItemToJson(WishlistItem instance) =>
    <String, dynamic>{
      'book': instance.book,
      'addedAt': instance.addedAt?.toIso8601String(),
    };

PurchasedBook _$PurchasedBookFromJson(Map<String, dynamic> json) =>
    PurchasedBook(
      book: json['book'] == null
          ? null
          : Book.fromJson(json['book'] as Map<String, dynamic>),
      purchasedAt: json['purchasedAt'] == null
          ? null
          : DateTime.parse(json['purchasedAt'] as String),
    );

Map<String, dynamic> _$PurchasedBookToJson(PurchasedBook instance) =>
    <String, dynamic>{
      'book': instance.book,
      'purchasedAt': instance.purchasedAt?.toIso8601String(),
    };
