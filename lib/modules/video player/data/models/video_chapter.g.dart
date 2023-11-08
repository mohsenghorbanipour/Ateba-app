// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoChapter _$VideoChapterFromJson(Map<String, dynamic> json) => VideoChapter(
      title: json['title'] as String?,
      beginning_second: json['beginning_second'] as int?,
    );

Map<String, dynamic> _$VideoChapterToJson(VideoChapter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('beginning_second', instance.beginning_second);
  return val;
}
