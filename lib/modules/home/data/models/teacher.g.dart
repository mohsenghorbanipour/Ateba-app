// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      id: json['id'] as int?,
      name: json['name'] as String?,
      expertise: json['expertise'] as String?,
      description: json['description'] as String?,
      image_path: json['image_path'] as String?,
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
  writeNotNull('expertise', instance.expertise);
  writeNotNull('description', instance.description);
  writeNotNull('image_path', instance.image_path);
  return val;
}
