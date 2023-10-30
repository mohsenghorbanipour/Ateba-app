import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/cart/data/models/link_to.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Order implements BaseModel<Order>{

  Order({
    this.id,
    this.title,
    this.duration,
    this.updated_at,
    this.thumbnail_url,
    this.price,
    this.link_to,
  });

  final String? id;
  final String? title;
  final String? duration;
  final String? updated_at;
  final String? thumbnail_url;
  final int? price;
  final LinkTo? link_to;

  @override
  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}