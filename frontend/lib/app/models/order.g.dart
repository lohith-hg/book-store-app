// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      book: json['book'] == null
          ? null
          : Book.fromJson(json['book'] as Map<String, dynamic>),
      amount: json['amount'] as int?,
      paymentStatus: json['paymentStatus'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'user': instance.user,
      'book': instance.book,
      'amount': instance.amount,
      'paymentStatus': instance.paymentStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
