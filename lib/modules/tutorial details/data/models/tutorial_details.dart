import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/home/data/models/teacher.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/attachment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/comment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/share.dart';
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
    this.likes_count,
    this.is_liked,
    this.is_bookmarked,
    this.comments_count,
    this.videos,
    this.attachments,
    this.top_comments,
    this.has_access,
    this.share,
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
  int? likes_count;
  bool? is_liked;
  bool? is_bookmarked;
  final int? comments_count;
  final List<Video>? videos;
  final List<Attachment>? attachments;
  final List<Comment>? top_comments;
  final bool? has_access;
  final Share? share;

  @override
  factory TutorialDetaials.fromJson(Map<String, dynamic> json) =>
      _$TutorialDetaialsFromJson(json);

  Map<String, dynamic> toJson() => _$TutorialDetaialsToJson(this);
}
