import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/home/data/models/teacher.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/attachment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tutorial_details.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class TutorialDetaials implements BaseModel<TutorialDetaials> {
  TutorialDetaials({
    this.title,
    this.slug,
    this.teacher,
    this.cover_url,
    this.cover_color,
    this.views_count,
    this.duration,
    this.updated_at,
    this.description,
    this.like_count,
    this.is_liked,
    this.is_bookmarked,
    this.comment_counts,
    this.videos,
    this.attachments,
    this.comments_sample,
  });

  final String? title;
  final String? slug;
  final Teacher? teacher;
  final String? cover_url;
  final String? cover_color;
  final int? views_count;
  final String? duration;
  final String? updated_at;
  final String? description;
  final int? like_count;
  final bool? is_liked;
  final bool? is_bookmarked;
  final int? comment_counts;
  final List<Video>? videos;
  final List<Attachment>? attachments;
  final List<Comment>? comments_sample;

  @override
  factory TutorialDetaials.fromJson(Map<String, dynamic> json) =>
      _$TutorialDetaialsFromJson(json);

  Map<String, dynamic> toJson() => _$TutorialDetaialsToJson(this);
}
