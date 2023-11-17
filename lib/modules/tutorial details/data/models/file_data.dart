import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video_link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_data.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class FileData implements BaseModel<FileData> {
  FileData({
    this.id,
    this.title,
    this.hls_url,
    this.url,
    this.description,
    this.thumbnail_url,
    this.type,
    this.size,
    this.length,
    this.duration,
    this.download_links,
  });

  final int? id;
  final String? title;
  final String? hls_url;
  final String? url;
  final String? description;
  final String? thumbnail_url;
  final String? type;
  final String? size;
  final String? length;
  final String? duration;
  final List<VideoLink>? download_links;


  @override
  factory FileData.fromJson(Map<String, dynamic> json) =>
      _$FileDataFromJson(json);

  Map<String, dynamic> toJson() => _$FileDataToJson(this);
}
