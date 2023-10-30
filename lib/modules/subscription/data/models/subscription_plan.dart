import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_plan.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class SubscriptionPlan implements BaseModel<SubscriptionPlan> {

  SubscriptionPlan({
    this.id,
    this.title,
    this.price,
  });

  final int? id;
  final String? title;
  final int? price;

  @override
  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionPlanToJson(this);
}