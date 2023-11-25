// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetails _$CourseDetailsFromJson(Map<String, dynamic> json) =>
    CourseDetails(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      cover_url: json['cover_url'] as String?,
      cover_color: json['cover_color'] as String?,
      duration: json['duration'] as String?,
      created_at: json['created_at'] as String?,
      price: json['price'] as int?,
      tutorials: (json['tutorials'] as List<dynamic>?)
          ?.map((e) => Tutorial.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      views_count: json['views_count'] as int?,
      tutorials_count: json['tutorials_count'] as int?,
      teachers: (json['teachers'] as List<dynamic>?)
          ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
          .toList(),
      has_bought: json['has_bought'] as bool?,
      share: json['share'] == null
          ? null
          : Share.fromJson(json['share'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseDetailsToJson(CourseDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('slug', instance.slug);
  writeNotNull('cover_url', instance.cover_url);
  writeNotNull('cover_color', instance.cover_color);
  writeNotNull('duration', instance.duration);
  writeNotNull('created_at', instance.created_at);
  writeNotNull('price', instance.price);
  writeNotNull(
      'tutorials', instance.tutorials?.map((e) => e.toJson()).toList());
  writeNotNull('description', instance.description);
  writeNotNull('views_count', instance.views_count);
  writeNotNull('tutorials_count', instance.tutorials_count);
  writeNotNull('teachers', instance.teachers?.map((e) => e.toJson()).toList());
  writeNotNull('has_bought', instance.has_bought);
  writeNotNull('share', instance.share?.toJson());
  return val;
}
