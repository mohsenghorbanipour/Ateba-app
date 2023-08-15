import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_slider.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class BannerSlider implements BaseModel<BannerSlider> {

  BannerSlider({
    this.id,
    this.cover,
  });

  final int? id;
  final String? cover;

  @override
  factory BannerSlider.fromJson(Map<String, dynamic> json) =>
      _$BannerSliderFromJson(json);

  Map<String, dynamic> toJson() => _$BannerSliderToJson(this);
}
