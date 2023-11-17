import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

@JsonSerializable(
    includeIfNull: false, explicitToJson: true, genericArgumentFactories: true)
class ApiResponseModel<T> implements BaseModel<ApiResponseModel<T>> {
  ApiResponseModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  T? data;
  String? message;
  
  @override
  factory ApiResponseModel.fromJson(
          Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$ApiResponseModelFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T)? toJsonT) =>
      _$ApiResponseModelToJson(this, toJsonT!);
}
