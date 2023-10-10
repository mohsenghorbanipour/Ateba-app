import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_slider.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class BannerSlider implements BaseModel<BannerSlider> {
  BannerSlider({
    this.image_url,
    this.alternative_text,
    this.type,
    this.slug,
  });

  final String? image_url;
  final String? alternative_text;
  final String? type;
  final String? slug;

  @override
  factory BannerSlider.fromJson(Map<String, dynamic> json) =>
      _$BannerSliderFromJson(json);

  Map<String, dynamic> toJson() => _$BannerSliderToJson(this);
}
