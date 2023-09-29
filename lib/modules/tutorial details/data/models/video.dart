import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video_link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Video implements BaseModel<Video> {
  Video({
    this.title,
    this.hls_url,
    this.description,
    this.thumbnail_url,
    this.type,
    this.size,
    this.duration,
    this.download_links,
  });

  final String? title;
  final String? hls_url;
  final String? description;
  final String? thumbnail_url;
  final String? type;
  final String? size;
  final String? duration;
  final List<VideoLink>? download_links;

  @override
  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
