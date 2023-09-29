import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tutorial.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Tutorial implements BaseModel<Tutorial> {
  Tutorial({
    this.title,
    this.slug,
    this.subtitle,
    this.teacher,
    this.thumbnail_url,
    this.duration,
    this.updated_at,
  });

  final String? title;
  final String? slug;
  final String? subtitle;
  final String? teacher;
  final String? thumbnail_url;
  final String? duration;
  final String? updated_at;

  @override
  factory Tutorial.fromJson(Map<String, dynamic> json) =>
      _$TutorialFromJson(json);

  Map<String, dynamic> toJson() => _$TutorialToJson(this);
}
