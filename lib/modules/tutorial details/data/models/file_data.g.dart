// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileData _$FileDataFromJson(Map<String, dynamic> json) => FileData(
      id: json['id'] as int?,
      title: json['title'] as String?,
      hls_url: json['hls_url'] as String?,
      url: json['url'] as String?,
      description: json['description'] as String?,
      thumbnail_url: json['thumbnail_url'] as String?,
      type: json['type'] as String?,
      size: json['size'] as String?,
      length: json['length'] as String?,
      duration: json['duration'] as String?,
      download_links: (json['download_links'] as List<dynamic>?)
          ?.map((e) => VideoLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FileDataToJson(FileData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('hls_url', instance.hls_url);
  writeNotNull('url', instance.url);
  writeNotNull('description', instance.description);
  writeNotNull('thumbnail_url', instance.thumbnail_url);
  writeNotNull('type', instance.type);
  writeNotNull('size', instance.size);
  writeNotNull('length', instance.length);
  writeNotNull('duration', instance.duration);
  writeNotNull('download_links',
      instance.download_links?.map((e) => e.toJson()).toList());
  return val;
}
