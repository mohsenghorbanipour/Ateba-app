import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link_to.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class LinkTo implements BaseModel<LinkTo> {

  LinkTo({
    this.type,
    this.slug
  });

  final String? type;
  final String? slug;

  @override
  factory LinkTo.fromJson(Map<String, dynamic> json) => _$LinkToFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToToJson(this);
}