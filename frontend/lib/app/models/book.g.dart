// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      uid: json['_id'] as String?,
      id: json['id'] as String?,
      title: json['title'] as String?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      dateAdded: json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
      price: (json['price'] as num?)?.toDouble(),
      coverImageUrl: json['coverImageUrl'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'price': instance.price,
      'coverImageUrl': instance.coverImageUrl,
      'category': instance.category,
    };
