// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fast_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FastSearch _$FastSearchFromJson(Map<String, dynamic> json) => FastSearch(
      title: json['title'] as String?,
      link_to: json['link_to'] == null
          ? null
          : LinkTo.fromJson(json['link_to'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FastSearchToJson(FastSearch instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('link_to', instance.link_to?.toJson());
  return val;
}
