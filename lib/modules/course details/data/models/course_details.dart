import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/home/data/models/teacher.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/share.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_details.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CourseDetails implements BaseModel<CourseDetails> {
  CourseDetails({
    this.title,
    this.slug,
    this.cover_url,
    this.cover_color,
    this.duration,
    this.created_at,
    this.price,
    this.tutorials,
    this.description,
    this.views_count,
    this.tutorials_count,
    this.teachers,
    this.has_bought,
    this.share,
  });

  final String? title;
  final String? slug;
  final String? cover_url;
  final String? cover_color;
  final String? duration;
  final String? created_at;
  final int? price;
  final List<Tutorial>? tutorials;
  final String? description;
  final int? views_count;
  final int? tutorials_count;
  final List<Teacher>? teachers;
  final bool? has_bought;
  final Share? share;

  @override
  factory CourseDetails.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailsToJson(this);
}
