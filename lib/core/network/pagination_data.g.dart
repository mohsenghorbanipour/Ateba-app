// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationData _$PaginationDataFromJson(Map<String, dynamic> json) =>
    PaginationData(
      current_page: json['current_page'] as int?,
      per_page: json['per_page'] as int?,
    );

Map<String, dynamic> _$PaginationDataToJson(PaginationData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('current_page', instance.current_page);
  writeNotNull('per_page', instance.per_page);
  return val;
}
