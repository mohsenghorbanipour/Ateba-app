// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      cover_url: json['cover_url'] as String?,
      duration: json['duration'] as String?,
      updated_at: json['updated_at'] as String?,
      price: json['price'] as int?,
      tutorials_sample: (json['tutorials_sample'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      students_count: json['students_count'] as int?,
      tutorials_count: json['tutorials_count'] as int?,
    );

Map<String, dynamic> _$PackageToJson(Package instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('slug', instance.slug);
  writeNotNull('cover_url', instance.cover_url);
  writeNotNull('duration', instance.duration);
  writeNotNull('updated_at', instance.updated_at);
  writeNotNull('price', instance.price);
  writeNotNull('tutorials_sample', instance.tutorials_sample);
  writeNotNull('tutorials_count', instance.tutorials_count);
  writeNotNull('students_count', instance.students_count);
  return val;
}
