import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_data.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class FileData implements BaseModel<FileData> {
  FileData({
    this.title,
    this.url,
    this.description,
    this.thumbnail_url,
    this.type,
    this.size,
    this.length,
  });

  final String? title;
  final String? url;
  final String? description;
  final String? thumbnail_url;
  final String? type;
  final String? size;
  final String? length;

  @override
  factory FileData.fromJson(Map<String, dynamic> json) =>
      _$FileDataFromJson(json);

  Map<String, dynamic> toJson() => _$FileDataToJson(this);
}
