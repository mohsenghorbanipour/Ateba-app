import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/auth/data/models/config_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_config_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class ProfileConfigResponse implements BaseModel<ProfileConfigResponse> {

  ProfileConfigResponse({
    this.universities,
    this.fields,
    this.degrees,
    this.provinces,
  });

  final List<ConfigItem>? universities;
  final List<ConfigItem>? fields;
  final List<ConfigItem>? degrees;
  final List<ConfigItem>? provinces;

  @override
  factory ProfileConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileConfigResponseToJson(this);
}