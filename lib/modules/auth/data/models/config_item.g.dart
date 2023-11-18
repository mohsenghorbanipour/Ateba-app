// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigItem _$ConfigItemFromJson(Map<String, dynamic> json) => ConfigItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$ConfigItemToJson(ConfigItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('name', instance.name);
  writeNotNull('slug', instance.slug);
  return val;
}
