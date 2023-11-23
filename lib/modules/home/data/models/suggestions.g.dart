// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suggestions _$SuggestionsFromJson(Map<String, dynamic> json) => Suggestions(
      search_placeholder: json['search_placeholder'] as String?,
      query_suggestions: (json['query_suggestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SuggestionsToJson(Suggestions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('search_placeholder', instance.search_placeholder);
  writeNotNull('query_suggestions', instance.query_suggestions);
  return val;
}
