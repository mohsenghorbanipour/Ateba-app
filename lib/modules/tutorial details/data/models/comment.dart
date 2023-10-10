import 'package:ateba_app/core/base/base_model.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Comment implements BaseModel<Comment> {

  Comment({
    this.id,
    this.content,
    this.parent_id,
    this.created_at,
    this.user,
    this.is_liked,
    this.is_edited,
    this.is_pined,
    this.likes_count,
    this.replies_count,
  });

  final int? id;
  final String? content;
  final int? parent_id;
  final String? created_at;
  final User? user;
  final bool? is_liked;
  final int? replies_count;
  final int? likes_count;
  final bool? is_edited;
  final bool? is_pined;


  @override
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}