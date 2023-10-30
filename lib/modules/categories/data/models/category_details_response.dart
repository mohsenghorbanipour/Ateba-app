import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_details_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CategoryDetailsResponse implements BaseModel<CategoryDetailsResponse>{

  CategoryDetailsResponse({
    this.title,
    this.tutorials_count,
    this.tutorials,
  });

  final String? title;
  final int? tutorials_count;
  final List<Tutorial>? tutorials;

  @override
  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDetailsResponseToJson(this);
}