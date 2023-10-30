// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailsResponse _$CategoryDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailsResponse(
      title: json['title'] as String?,
      tutorials_count: json['tutorials_count'] as int?,
      tutorials: (json['tutorials'] as List<dynamic>?)
          ?.map((e) => Tutorial.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDetailsResponseToJson(
    CategoryDetailsResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('tutorials_count', instance.tutorials_count);
  writeNotNull(
      'tutorials', instance.tutorials?.map((e) => e.toJson()).toList());
  return val;
}
