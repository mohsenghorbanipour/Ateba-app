// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      title: json['title'] as String?,
      hls_url: json['hls_url'] as String?,
      description: json['description'] as String?,
      thumbnail_url: json['thumbnail_url'] as String?,
      type: json['type'] as String?,
      size: json['size'] as String?,
      duration: json['duration'] as String?,
      download_links: (json['download_links'] as List<dynamic>?)
          ?.map((e) => VideoLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoToJson(Video instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('hls_url', instance.hls_url);
  writeNotNull('description', instance.description);
  writeNotNull('thumbnail_url', instance.thumbnail_url);
  writeNotNull('type', instance.type);
  writeNotNull('size', instance.size);
  writeNotNull('duration', instance.duration);
  writeNotNull('download_links',
      instance.download_links?.map((e) => e.toJson()).toList());
  return val;
}
