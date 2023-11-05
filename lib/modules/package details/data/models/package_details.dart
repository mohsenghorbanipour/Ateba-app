import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/home/data/models/teacher.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:ateba_app/modules/package%20details/data/models/tutorial_package.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/tutorial_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package_details.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PackageDetails implements BaseModel<PackageDetails>{

  PackageDetails({
    this.title,
    this.slug,
    this.thumbnail_url,
    this.tutorials_count,
    this.updated_at,
    this.price,
    this.tutorials,
    this.description,
    this.views_count,
    this.students_count,
    this.duration,
    this.teachers,
    this.is_bookmarked,
  });

  final String? title;
  final String? slug;
  final String? thumbnail_url;
  final int? tutorials_count;
  final String? updated_at;
  final int? price;
  final List<TutorialPackage>? tutorials;
  final String? description;
  final int? views_count;
  final int? students_count;
  final String? duration;
  final List<Teacher>? teachers;
  final bool? is_bookmarked;

  @override
  factory PackageDetails.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDetailsToJson(this);
}