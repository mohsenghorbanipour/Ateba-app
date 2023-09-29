import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_data.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PaginationData implements BaseModel {

  PaginationData({
    this.current_page,
    this.per_page,
  });

  final int? current_page;
  final int? per_page;

  @override
  factory PaginationData.fromJson(Map<String, dynamic> json) =>
      _$PaginationDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationDataToJson(this);
}