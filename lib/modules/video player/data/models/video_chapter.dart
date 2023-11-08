import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_chapter.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class VideoChapter implements BaseModel<VideoChapter> {
  VideoChapter({this.title, this.beginning_second});

  final String? title;
  final int? beginning_second;

  @override
  factory VideoChapter.fromJson(Map<String, dynamic> json) =>
      _$VideoChapterFromJson(json);

  Map<String, dynamic> toJson() => _$VideoChapterToJson(this);
}
