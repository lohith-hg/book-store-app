import 'package:json_annotation/json_annotation.dart';
part 'book.g.dart';

@JsonSerializable()
class Book {
  String? id;
  String? title;
  String? author;
  String? description;
  DateTime? dateAdded;
  double? price;
  String? coverImageUrl;
  String? category;

  Book({
    this.id,
    this.title,
    this.author,
    this.description,
    this.dateAdded,
    this.price,
    this.coverImageUrl,
    this.category,
  });

     factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}