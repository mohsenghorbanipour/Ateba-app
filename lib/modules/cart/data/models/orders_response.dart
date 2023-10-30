import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/cart/data/models/order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class OrdersResponse implements BaseModel<OrdersResponse> {

  OrdersResponse({
    this.price,
    this.discounted_price,
    this.discount_code,
    this.orders,
    this.payment_link,
  });

  final int? price;
  final int? discounted_price;
  final String? discount_code;
  final List<Order>? orders;
  final String? payment_link;

  @override
  factory OrdersResponse.fromJson(Map<String, dynamic> json) => _$OrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);
} 