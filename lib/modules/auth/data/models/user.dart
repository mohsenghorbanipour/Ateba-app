import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class User implements BaseModel<User> {

  User({
    this.id,
    this.name,
    this.phone,
    this.picture_url,
    this.email,
    this.field,
    this.degree,
    this.university,
    this.country,
    this.province,
    this.city,
    this.gender,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? picture_url;
  final String? email;
  final String? field;
  final String? degree;
  final String? university;
  final String? country;
  final String? province;
  final String? city;
  final String? gender;

  @override
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}