// ignore_for_file: non_constant_identifier_names

import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Package implements BaseModel<Package> {

  Package({
    this.id,
    this.duration,
    this.icon,
    this.date,
    this.teacher,
    this.title,
    this.price,
    this.subsets,
    this.is_bookmarked,
  });

  final int? id;
  final String? title;
  final String? teacher;
  final String? icon;
  final String? duration;
  final String? date;
  final int? price;
  final List<String>? subsets;
  final bool? is_bookmarked;

  @override
  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}