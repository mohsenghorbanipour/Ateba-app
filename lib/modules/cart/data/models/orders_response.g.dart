// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersResponse _$OrdersResponseFromJson(Map<String, dynamic> json) =>
    OrdersResponse(
      price: json['price'] as int?,
      discounted_price: json['discounted_price'] as int?,
      discount_code: json['discount_code'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      payment_link: json['payment_link'] as String?,
    );

Map<String, dynamic> _$OrdersResponseToJson(OrdersResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('price', instance.price);
  writeNotNull('discounted_price', instance.discounted_price);
  writeNotNull('discount_code', instance.discount_code);
  writeNotNull('orders', instance.orders?.map((e) => e.toJson()).toList());
  writeNotNull('payment_link', instance.payment_link);
  return val;
}
