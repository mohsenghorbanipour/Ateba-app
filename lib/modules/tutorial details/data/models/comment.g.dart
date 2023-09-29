// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as int?,
      content: json['content'] as String?,
      parent_id: json['parent_id'] as int?,
      created_at: json['created_at'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      is_liked: json['is_liked'] as bool?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('content', instance.content);
  writeNotNull('parent_id', instance.parent_id);
  writeNotNull('created_at', instance.created_at);
  writeNotNull('user', instance.user?.toJson());
  writeNotNull('is_liked', instance.is_liked);
  return val;
}
