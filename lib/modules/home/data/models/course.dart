import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/home/data/models/teacher.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Course implements BaseModel<Course> {

  Course({
    this.id,
    this.title,
    this.subtitle,
    this.teacher,
    this.thumbnail_url,
    this.duration,
    this.created_at,
  });

  final int? id;
  final String? title;
  final String? subtitle;
  final Teacher? teacher;
  final String? thumbnail_url;
  final String? duration;
  final String? created_at;


  @override
  factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
