// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorials_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorialsSample _$TutorialsSampleFromJson(Map<String, dynamic> json) =>
    TutorialsSample(
      tutorials_titles: (json['tutorials_titles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tutorials_count: json['tutorials_count'] as int?,
    );

Map<String, dynamic> _$TutorialsSampleToJson(TutorialsSample instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tutorials_titles', instance.tutorials_titles);
  writeNotNull('tutorials_count', instance.tutorials_count);
  return val;
}
