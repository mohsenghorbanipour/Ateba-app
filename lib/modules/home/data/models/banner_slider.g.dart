// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_slider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerSlider _$BannerSliderFromJson(Map<String, dynamic> json) => BannerSlider(
      image_url: json['image_url'] as String?,
      alternative_text: json['alternative_text'] as String?,
      type: json['type'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$BannerSliderToJson(BannerSlider instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image_url', instance.image_url);
  writeNotNull('alternative_text', instance.alternative_text);
  writeNotNull('type', instance.type);
  writeNotNull('slug', instance.slug);
  return val;
}
