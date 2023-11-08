import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'students_sample.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class StudentsSample implements BaseModel<StudentsSample> {
  StudentsSample({
    this.pictures_sample,
    this.students_count,
  });

  final List<String>? pictures_sample;
  final int? students_count;

  @override
  factory StudentsSample.fromJson(Map<String, dynamic> json) =>
      _$StudentsSampleFromJson(json);

  Map<String, dynamic> toJson() => _$StudentsSampleToJson(this);
}
