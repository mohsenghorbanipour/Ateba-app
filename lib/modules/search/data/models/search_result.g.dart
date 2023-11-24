// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      title: json['title'] as String?,
      type: json['type'] as String?,
      link_to: json['link_to'] == null
          ? null
          : LinkTo.fromJson(json['link_to'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('type', instance.type);
  writeNotNull('link_to', instance.link_to?.toJson());
  return val;
}
