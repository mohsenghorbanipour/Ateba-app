import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/file_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Attachment implements BaseModel<Attachment> {
  Attachment({
    this.title,
    this.description,
    this.type,
    this.is_singular,
    this.files,
  });

  final String? title;
  final String? description;
  final String? type;
  final bool? is_singular;
  final List<FileData>? files;

  @override
  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
