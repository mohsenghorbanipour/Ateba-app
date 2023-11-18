// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileConfigResponse _$ProfileConfigResponseFromJson(
        Map<String, dynamic> json) =>
    ProfileConfigResponse(
      universities: (json['universities'] as List<dynamic>?)
          ?.map((e) => ConfigItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => ConfigItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      degrees: (json['degrees'] as List<dynamic>?)
          ?.map((e) => ConfigItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      provinces: (json['provinces'] as List<dynamic>?)
          ?.map((e) => ConfigItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileConfigResponseToJson(
    ProfileConfigResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'universities', instance.universities?.map((e) => e.toJson()).toList());
  writeNotNull('fields', instance.fields?.map((e) => e.toJson()).toList());
  writeNotNull('degrees', instance.degrees?.map((e) => e.toJson()).toList());
  writeNotNull(
      'provinces', instance.provinces?.map((e) => e.toJson()).toList());
  return val;
}
