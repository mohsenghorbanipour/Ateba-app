// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      thumbnail_url: json['thumbnail_url'] as String?,
      duration: json['duration'] as String?,
      created_at: json['created_at'] as String?,
      price: json['price'] as int?,
      tutorials_sample: (json['tutorials_sample'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tutorials_count: json['tutorials_count'] as int?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('slug', instance.slug);
  writeNotNull('thumbnail_url', instance.thumbnail_url);
  writeNotNull('duration', instance.duration);
  writeNotNull('created_at', instance.created_at);
  writeNotNull('price', instance.price);
  writeNotNull('tutorials_sample', instance.tutorials_sample);
  writeNotNull('tutorials_count', instance.tutorials_count);
  return val;
}
