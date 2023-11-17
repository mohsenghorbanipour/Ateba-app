import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class TokenResponse implements BaseModel<TokenResponse> {
  TokenResponse({
    this.token,
    this.has_completed_profile,
  });

  final String? token;
  final bool? has_completed_profile;

  @override
  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
