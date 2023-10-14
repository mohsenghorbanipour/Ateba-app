// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      expertise: json['expertise'] as String?,
      description: json['description'] as String?,
      picture_url: json['picture_url'] as String?,
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('slug', instance.slug);
  writeNotNull('expertise', instance.expertise);
  writeNotNull('description', instance.description);
  writeNotNull('picture_url', instance.picture_url);
  return val;
}
