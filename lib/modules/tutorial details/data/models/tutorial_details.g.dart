// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorialDetaials _$TutorialDetaialsFromJson(Map<String, dynamic> json) =>
    TutorialDetaials(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      teacher: json['teacher'] == null
          ? null
          : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      cover_url: json['cover_url'] as String?,
      cover_color: json['cover_color'] as String?,
      views_count: json['views_count'] as int?,
      duration: json['duration'] as String?,
      updated_at: json['updated_at'] as String?,
      description: json['description'] as String?,
      likes_count: json['likes_count'] as int?,
      is_liked: json['is_liked'] as bool?,
      is_bookmarked: json['is_bookmarked'] as bool?,
      comments_count: json['comments_count'] as int?,
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      top_comments: (json['top_comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      has_access: json['has_access'] as bool?,
      share: json['share'] == null
          ? null
          : Share.fromJson(json['share'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TutorialDetaialsToJson(TutorialDetaials instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('slug', instance.slug);
  writeNotNull('teacher', instance.teacher?.toJson());
  writeNotNull('cover_url', instance.cover_url);
  writeNotNull('cover_color', instance.cover_color);
  writeNotNull('views_count', instance.views_count);
  writeNotNull('duration', instance.duration);
  writeNotNull('updated_at', instance.updated_at);
  writeNotNull('description', instance.description);
  writeNotNull('likes_count', instance.likes_count);
  writeNotNull('is_liked', instance.is_liked);
  writeNotNull('is_bookmarked', instance.is_bookmarked);
  writeNotNull('comments_count', instance.comments_count);
  writeNotNull('videos', instance.videos?.map((e) => e.toJson()).toList());
  writeNotNull(
      'attachments', instance.attachments?.map((e) => e.toJson()).toList());
  writeNotNull(
      'top_comments', instance.top_comments?.map((e) => e.toJson()).toList());
  writeNotNull('has_access', instance.has_access);
  writeNotNull('share', instance.share?.toJson());
  return val;
}
