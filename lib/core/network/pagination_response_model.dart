import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/core/network/pagination_data.dart';
import 'package:ateba_app/core/network/pagination_link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_response_model.g.dart';

@JsonSerializable(
    includeIfNull: false, explicitToJson: true, genericArgumentFactories: true)
class PaginationResponseModel<T> implements BaseModel {

  PaginationResponseModel({
    this.data,
    this.meta,
    this.links,
  });

  final T? data;
  final PaginationData? meta;
  final PaginationLink? links;

  @override
  factory PaginationResponseModel.fromJson(
          Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$PaginationResponseModelFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T)? toJsonT) =>
      _$PaginationResponseModelToJson(this, toJsonT!);
}
