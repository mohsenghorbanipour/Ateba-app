import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_link.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class VideoLink implements BaseModel<VideoLink> {
  VideoLink({
    this.url,
    this.quality,
  });

  final String? url;
  final String? quality;

  @override
  factory VideoLink.fromJson(Map<String, dynamic> json) =>
      _$VideoLinkFromJson(json);

  Map<String, dynamic> toJson() => _$VideoLinkToJson(this);
}
