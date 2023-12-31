// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorialPackage _$TutorialPackageFromJson(Map<String, dynamic> json) =>
    TutorialPackage(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      views_count: json['views_count'] as int?,
      description: json['description'] as String?,
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_bookmarked: json['is_bookmarked'] as bool?,
      has_bought: json['has_bought'] as bool?,
    );

Map<String, dynamic> _$TutorialPackageToJson(TutorialPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('slug', instance.slug);
  writeNotNull('views_count', instance.views_count);
  writeNotNull('description', instance.description);
  writeNotNull('videos', instance.videos?.map((e) => e.toJson()).toList());
  writeNotNull(
      'attachments', instance.attachments?.map((e) => e.toJson()).toList());
  writeNotNull('is_bookmarked', instance.is_bookmarked);
  writeNotNull('has_bought', instance.has_bought);
  return val;
}
