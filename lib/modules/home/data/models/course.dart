import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/home/data/models/tutorials_sample.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Course implements BaseModel<Course> {

  Course({
    this.title,
    this.slug,
    this.thumbnail_url,
    this.duration,
    this.created_at,
    this.price,
    this.tutorials_sample,
    this.tutorials_count,
  });

  final String? title;
  final String? slug;
  final String? thumbnail_url;
  final String? duration;
  final String? created_at;
  final int? price;
  final TutorialsSample? tutorials_sample;
  final int? tutorials_count;


  @override
  factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
