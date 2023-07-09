import 'package:book_store_app/app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'book.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  User? user;
  Book? book;
  int? amount;
  String? paymentStatus;
  DateTime? createdAt;

  Order({
    this.user,
    this.book,
    this.amount,
    this.paymentStatus,
    this.createdAt,
  });

      factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}