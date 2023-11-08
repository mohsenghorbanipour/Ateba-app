// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      picture_url: json['picture_url'] as String?,
      email: json['email'] as String?,
      field: json['field'] as String?,
      degree: json['degree'] as String?,
      university: json['university'] as String?,
      country: json['country'] as String?,
      province: json['province'] as String?,
      city: json['city'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('picture_url', instance.picture_url);
  writeNotNull('email', instance.email);
  writeNotNull('field', instance.field);
  writeNotNull('degree', instance.degree);
  writeNotNull('university', instance.university);
  writeNotNull('country', instance.country);
  writeNotNull('province', instance.province);
  writeNotNull('city', instance.city);
  writeNotNull('gender', instance.gender);
  return val;
}
