import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video_link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PlayList implements BaseModel<PlayList> {
  PlayList({
    this.hls,
    this.download,
  });

  final String? hls;
  final List<VideoLink>? download;

  @override
  factory PlayList.fromJson(Map<String, dynamic> json) =>
      _$PlayListFromJson(json);

  Map<String, dynamic> toJson() => _$PlayListToJson(this);
}
