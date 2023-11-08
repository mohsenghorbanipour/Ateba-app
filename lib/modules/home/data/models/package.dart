// ignore_for_file: non_constant_identifier_names

import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/home/data/models/students_sample.dart';
import 'package:ateba_app/modules/home/data/models/tutorials_sample.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Package implements BaseModel<Package> {

  Package({
    this.title,
    this.slug,
    this.cover_url,
    this.duration,
    this.updated_at,
    this.price,
    this.tutorials_sample,
    this.students_count,
    this.tutorials_count,
    this.students_sample,
  });

  final String? title;
  final String? slug;
  final String? cover_url;
  final String? duration;
  final String? updated_at;
  final int? price;
  final TutorialsSample? tutorials_sample;
  final int? tutorials_count;
  final int? students_count;
  final StudentsSample? students_sample;

  @override
  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}