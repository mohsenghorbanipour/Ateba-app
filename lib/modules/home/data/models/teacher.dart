import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Teacher implements BaseModel {
  Teacher({
    this.id,
    this.name,
    this.slug,
    this.expertise,
    this.description,
    this.picture_url,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? expertise;
  final String? description;
  final String? picture_url;

  @override
  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
