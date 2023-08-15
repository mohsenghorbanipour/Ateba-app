// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: json['id'] as int?,
      duration: json['duration'] as String?,
      icon: json['icon'] as String?,
      date: json['date'] as String?,
      teacher: json['teacher'] as String?,
      title: json['title'] as String?,
      price: json['price'] as int?,
      subsets:
          (json['subsets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      is_bookmarked: json['is_bookmarked'] as bool?,
    );

Map<String, dynamic> _$PackageToJson(Package instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('teacher', instance.teacher);
  writeNotNull('icon', instance.icon);
  writeNotNull('duration', instance.duration);
  writeNotNull('date', instance.date);
  writeNotNull('price', instance.price);
  writeNotNull('subsets', instance.subsets);
  writeNotNull('is_bookmarked', instance.is_bookmarked);
  return val;
}
