// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDetails _$PackageDetailsFromJson(Map<String, dynamic> json) =>
    PackageDetails(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      thumbnail_url: json['thumbnail_url'] as String?,
      tutorials_count: json['tutorials_count'] as int?,
      updated_at: json['updated_at'] as String?,
      price: json['price'] as int?,
      tutorials: (json['tutorials'] as List<dynamic>?)
          ?.map((e) => TutorialPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      views_count: json['views_count'] as int?,
      students_count: json['students_count'] as int?,
      duration: json['duration'] as String?,
      teachers: (json['teachers'] as List<dynamic>?)
          ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageDetailsToJson(PackageDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('slug', instance.slug);
  writeNotNull('thumbnail_url', instance.thumbnail_url);
  writeNotNull('tutorials_count', instance.tutorials_count);
  writeNotNull('updated_at', instance.updated_at);
  writeNotNull('price', instance.price);
  writeNotNull(
      'tutorials', instance.tutorials?.map((e) => e.toJson()).toList());
  writeNotNull('description', instance.description);
  writeNotNull('views_count', instance.views_count);
  writeNotNull('students_count', instance.students_count);
  writeNotNull('duration', instance.duration);
  writeNotNull('teachers', instance.teachers?.map((e) => e.toJson()).toList());
  return val;
}
