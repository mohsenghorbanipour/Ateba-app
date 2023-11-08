import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Transaction implements BaseModel<Transaction> {
  Transaction({
    this.title,
    this.created_at,
    this.price,
  });

  final String? title;
  final String? created_at;
  final int? price;

  @override
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
