// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      title: json['title'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      is_singular: json['is_singular'] as bool?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => FileData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('type', instance.type);
  writeNotNull('is_singular', instance.is_singular);
  writeNotNull('files', instance.files?.map((e) => e.toJson()).toList());
  return val;
}
