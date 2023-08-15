// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_slider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerSlider _$BannerSliderFromJson(Map<String, dynamic> json) => BannerSlider(
      id: json['id'] as int?,
      cover: json['cover'] as String?,
    );

Map<String, dynamic> _$BannerSliderToJson(BannerSlider instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('cover', instance.cover);
  return val;
}
