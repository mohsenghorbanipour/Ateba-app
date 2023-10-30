// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String?,
      title: json['title'] as String?,
      duration: json['duration'] as String?,
      updated_at: json['updated_at'] as String?,
      thumbnail_url: json['thumbnail_url'] as String?,
      price: json['price'] as int?,
      link_to: json['link_to'] == null
          ? null
          : LinkTo.fromJson(json['link_to'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('duration', instance.duration);
  writeNotNull('updated_at', instance.updated_at);
  writeNotNull('thumbnail_url', instance.thumbnail_url);
  writeNotNull('price', instance.price);
  writeNotNull('link_to', instance.link_to?.toJson());
  return val;
}
