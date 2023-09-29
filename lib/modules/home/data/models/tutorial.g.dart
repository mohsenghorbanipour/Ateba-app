// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tutorial _$TutorialFromJson(Map<String, dynamic> json) => Tutorial(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      subtitle: json['subtitle'] as String?,
      teacher: json['teacher'] as String?,
      thumbnail_url: json['thumbnail_url'] as String?,
      duration: json['duration'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TutorialToJson(Tutorial instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('slug', instance.slug);
  writeNotNull('subtitle', instance.subtitle);
  writeNotNull('teacher', instance.teacher);
  writeNotNull('thumbnail_url', instance.thumbnail_url);
  writeNotNull('duration', instance.duration);
  writeNotNull('updated_at', instance.updated_at);
  return val;
}
