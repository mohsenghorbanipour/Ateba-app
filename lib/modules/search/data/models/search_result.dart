import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/cart/data/models/link_to.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_result.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class SearchResult implements BaseModel<SearchResult> {

  SearchResult({
    this.title,
    this.type,
    this.link_to,
  });

  final String? title;
  final String? type;
  final LinkTo? link_to;

  @override
  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}