import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class User implements BaseModel<User> {

  User({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;
  // final profile;

  @override
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}