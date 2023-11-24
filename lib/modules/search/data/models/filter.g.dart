// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      key: json['key'] as String?,
      value: json['value'] as String?,
      label: json['label'] as String?,
      results_count: json['results_count'] as int?,
    );

Map<String, dynamic> _$FilterToJson(Filter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  writeNotNull('value', instance.value);
  writeNotNull('label', instance.label);
  writeNotNull('results_count', instance.results_count);
  return val;
}
