// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoLink _$VideoLinkFromJson(Map<String, dynamic> json) => VideoLink(
      url: json['url'] as String?,
      quality: json['quality'] as String?,
      size: json['size'] as String?,
    );

Map<String, dynamic> _$VideoLinkToJson(VideoLink instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  writeNotNull('quality', instance.quality);
  writeNotNull('size', instance.size);
  return val;
}
