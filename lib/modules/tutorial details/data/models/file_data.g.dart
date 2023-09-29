// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileData _$FileDataFromJson(Map<String, dynamic> json) => FileData(
      title: json['title'] as String?,
      url: json['url'] as String?,
      description: json['description'] as String?,
      thumbnail_url: json['thumbnail_url'] as String?,
      type: json['type'] as String?,
      size: json['size'] as String?,
      length: json['length'] as String?,
    );

Map<String, dynamic> _$FileDataToJson(FileData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('url', instance.url);
  writeNotNull('description', instance.description);
  writeNotNull('thumbnail_url', instance.thumbnail_url);
  writeNotNull('type', instance.type);
  writeNotNull('size', instance.size);
  writeNotNull('length', instance.length);
  return val;
}
