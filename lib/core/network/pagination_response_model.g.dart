// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResponseModel<T> _$PaginationResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationResponseModel<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      meta: json['meta'] == null
          ? null
          : PaginationData.fromJson(json['meta'] as Map<String, dynamic>),
      links: json['links'] == null
          ? null
          : PaginationLink.fromJson(json['links'] as Map<String, dynamic>),
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => Filter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginationResponseModelToJson<T>(
  PaginationResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', _$nullableGenericToJson(instance.data, toJsonT));
  writeNotNull('meta', instance.meta?.toJson());
  writeNotNull('links', instance.links?.toJson());
  writeNotNull('filters', instance.filters?.map((e) => e.toJson()).toList());
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
