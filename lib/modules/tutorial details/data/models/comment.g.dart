// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String?,
      content: json['content'] as String?,
      parent_id: json['parent_id'] as int?,
      created_at: json['created_at'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      is_liked: json['is_liked'] as bool?,
      is_edited: json['is_edited'] as bool?,
      is_pined: json['is_pined'] as bool?,
      likes_count: json['likes_count'] as int?,
      replies_count: json['replies_count'] as int?,
      reply_to: json['reply_to'] as String?,
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
  writeNotNull('replies_count', instance.replies_count);
  writeNotNull('likes_count', instance.likes_count);
  writeNotNull('is_edited', instance.is_edited);
  writeNotNull('is_pined', instance.is_pined);
  writeNotNull('reply_to', instance.reply_to);
  return val;
}
