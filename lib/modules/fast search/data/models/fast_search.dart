import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/cart/data/models/link_to.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fast_search.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class FastSearch implements BaseModel<FastSearch> {
  FastSearch({
    this.title,
    this.link_to,
  });

  final String? title;
  final LinkTo? link_to;

  @override
  factory FastSearch.fromJson(Map<String, dynamic> json) =>
      _$FastSearchFromJson(json);

  Map<String, dynamic> toJson() => _$FastSearchToJson(this);
}
