// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsSample _$StudentsSampleFromJson(Map<String, dynamic> json) =>
    StudentsSample(
      pictures_sample: (json['pictures_sample'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      students_count: json['students_count'] as int?,
    );

Map<String, dynamic> _$StudentsSampleToJson(StudentsSample instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pictures_sample', instance.pictures_sample);
  writeNotNull('students_count', instance.students_count);
  return val;
}
