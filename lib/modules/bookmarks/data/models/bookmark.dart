import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Bookmark implements BaseModel<Bookmark>{

  Bookmark({
    this.title,
    this.subtitle,
    this.thumbnail,
    this.duration,
    this.updated_at,
    this.type,
    this.slug,
  });

  final String? title;
  final String? subtitle;
  final String? thumbnail;
  final int? duration;
  final String? updated_at;
  final String? type;
  final String? slug;

  @override
  factory Bookmark.fromJson(Map<String, dynamic> json) =>
      _$BookmarkFromJson(json);

  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}