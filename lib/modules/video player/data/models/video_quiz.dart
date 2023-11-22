import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/video%20player/data/models/quiz_answer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_quiz.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class VideoQuiz implements BaseModel<VideoQuiz> {

  VideoQuiz({
    this.id,
    this.text,
    this.type,
    this.at_second,
    this.choices,
  });

  final int? id;
  final String? text;
  final String? type;
  final int? at_second;
  final List<QuizAnswer>? choices;

  @override
  factory VideoQuiz.fromJson(Map<String, dynamic> json) =>
      _$VideoQuizFromJson(json);

  Map<String, dynamic> toJson() => _$VideoQuizToJson(this);
}