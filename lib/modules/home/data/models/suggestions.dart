import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suggestions.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Suggestions implements BaseModel<Suggestions> {

  Suggestions({
    this.search_placeholder,
    this.query_suggestions,
  });

  final String? search_placeholder;
  final List<String>? query_suggestions;

  @override
  factory Suggestions.fromJson(Map<String, dynamic> json) =>
      _$SuggestionsFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestionsToJson(this);
}