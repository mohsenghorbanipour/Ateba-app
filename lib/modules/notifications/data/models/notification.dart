import 'package:ateba_app/core/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Notification implements BaseModel<Notification> {
  Notification({
    this.title,
    this.text,
    this.link,
    this.created_at,
  });

  final String? title;
  final String? text;
  final String? link;
  final String? created_at;

  @override
  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
