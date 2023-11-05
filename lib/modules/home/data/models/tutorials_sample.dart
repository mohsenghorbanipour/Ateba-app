import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tutorials_sample.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class TutorialsSample implements BaseModel<TutorialsSample> {

  TutorialsSample({
    this.tutorials_titles,
    this.tutorials_count,
  });

  final List<String>? tutorials_titles;
  final int? tutorials_count;

  @override
  factory TutorialsSample.fromJson(Map<String, dynamic> json) =>
      _$TutorialsSampleFromJson(json);

  Map<String, dynamic> toJson() => _$TutorialsSampleToJson(this);
}