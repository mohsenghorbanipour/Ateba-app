import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'share.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Share implements BaseModel<Share> {
  Share({
    this.text,
    this.link,
  });

  final String? text;
  final String? link;

  @override
  factory Share.fromJson(Map<String, dynamic> json) => _$ShareFromJson(json);

  Map<String, dynamic> toJson() => _$ShareToJson(this);
}
