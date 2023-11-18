import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/cart/data/models/link_to.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Bookmark implements BaseModel<Bookmark>{

  Bookmark({
    this.title,
    this.subtitle,
    this.thumbnail_url,
    this.duration,
    this.updated_at,
    this.video,
    this.link_to,
    this.path,
    this.quality,
    this.videoId,
  });

  final String? title;
  final String? subtitle;
  final String? thumbnail_url;
  final String? duration;
  final String? updated_at;
  final String? video;
  final LinkTo? link_to;
  final String? path;
  final String? quality;
  final int? videoId;


  @override
  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}