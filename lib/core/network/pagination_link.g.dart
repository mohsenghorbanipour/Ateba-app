// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationLink _$PaginationLinkFromJson(Map<String, dynamic> json) =>
    PaginationLink(
      next: json['next'] as String?,
    );

Map<String, dynamic> _$PaginationLinkToJson(PaginationLink instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('next', instance.next);
  return val;
}
