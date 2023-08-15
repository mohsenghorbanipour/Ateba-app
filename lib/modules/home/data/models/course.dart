import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Course implements BaseModel<Course> {

  Course({
    this.attach,
    this.cover,
    this.date,
    this.id,
    this.teacher,
    this.title,
  });

  final int? id;
  final String? title;
  final String? teacher;
  final String? cover;
  final String? attach;
  final String? date;

  @override
  factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
