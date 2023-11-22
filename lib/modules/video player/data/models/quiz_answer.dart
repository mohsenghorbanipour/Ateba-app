import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_answer.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class QuizAnswer implements BaseModel<QuizAnswer> {

  QuizAnswer({
    this.id,
    this.text,
  });

  final int? id;
  final String? text; 

  @override
  factory QuizAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$QuizAnswerToJson(this);
}