// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      attach: json['attach'] as String?,
      cover: json['cover'] as String?,
      date: json['date'] as String?,
      id: json['id'] as int?,
      teacher: json['teacher'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('teacher', instance.teacher);
  writeNotNull('cover', instance.cover);
  writeNotNull('attach', instance.attach);
  writeNotNull('date', instance.date);
  return val;
}
