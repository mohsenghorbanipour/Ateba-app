import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Category implements BaseModel<Category> {
  Category({
    this.title,
    this.slug,
    this.thumbnail_url,
  });

  final String? title;
  final String? slug;
  final String? thumbnail_url;

  @override
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
