import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/attachment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tutorial_package.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class TutorialPackage implements BaseModel<TutorialPackage> {
  TutorialPackage({
    this.title,
    this.slug,
    this.views_count,
    this.description,
    this.videos,
    this.attachments,
    this.is_bookmarked,
    this.has_bought,
  });

  final String? title;
  final String? slug;
  final int? views_count;
  final String? description;
  final List<Video>? videos;
  final List<Attachment>? attachments;
  bool? is_bookmarked;
  final bool? has_bought;

  @override
  factory TutorialPackage.fromJson(Map<String, dynamic> json) =>
      _$TutorialPackageFromJson(json);

  Map<String, dynamic> toJson() => _$TutorialPackageToJson(this);
}
