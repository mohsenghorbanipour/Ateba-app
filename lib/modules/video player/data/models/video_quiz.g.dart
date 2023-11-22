// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoQuiz _$VideoQuizFromJson(Map<String, dynamic> json) => VideoQuiz(
      id: json['id'] as int?,
      text: json['text'] as String?,
      type: json['type'] as String?,
      at_second: json['at_second'] as int?,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => QuizAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoQuizToJson(VideoQuiz instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('text', instance.text);
  writeNotNull('type', instance.type);
  writeNotNull('at_second', instance.at_second);
  writeNotNull('choices', instance.choices?.map((e) => e.toJson()).toList());
  return val;
}
