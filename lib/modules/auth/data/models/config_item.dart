import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_item.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class ConfigItem implements BaseModel<ConfigItem> {
  ConfigItem({
    this.id,
    this.name,
    this.title,
    this.slug,
  });

  final int? id;
  final String? title;
  final String? name;
  final String? slug;
  

  @override
  factory ConfigItem.fromJson(Map<String, dynamic> json) =>
      _$ConfigItemFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigItemToJson(this);
}
