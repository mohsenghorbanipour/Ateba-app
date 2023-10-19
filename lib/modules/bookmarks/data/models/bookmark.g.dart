// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => Bookmark(
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      thumbnail: json['thumbnail'] as String?,
      duration: json['duration'] as int?,
      updated_at: json['updated_at'] as String?,
      type: json['type'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$BookmarkToJson(Bookmark instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('subtitle', instance.subtitle);
  writeNotNull('thumbnail', instance.thumbnail);
  writeNotNull('duration', instance.duration);
  writeNotNull('updated_at', instance.updated_at);
  writeNotNull('type', instance.type);
  writeNotNull('slug', instance.slug);
  return val;
}
