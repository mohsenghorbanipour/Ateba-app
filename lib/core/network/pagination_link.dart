import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_link.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PaginationLink implements BaseModel {
  PaginationLink({
    this.next
  });

  final String? next;

  @override
  factory PaginationLink.fromJson(Map<String, dynamic> json) =>
      _$PaginationLinkFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationLinkToJson(this);
}
