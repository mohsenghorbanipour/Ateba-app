// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_to.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkTo _$LinkToFromJson(Map<String, dynamic> json) => LinkTo(
      type: json['type'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$LinkToToJson(LinkTo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('slug', instance.slug);
  return val;
}
