import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Filter implements BaseModel<Filter> {
  Filter({
    this.key,
    this.value,
    this.label,
    this.results_count,
  });

  final String? key;
  final String? value;
  final String? label;
  final int? results_count;

  @override
  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);
}
