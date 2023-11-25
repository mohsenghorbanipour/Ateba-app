// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayList _$PlayListFromJson(Map<String, dynamic> json) => PlayList(
      hls: json['hls'] as String?,
      download: (json['download'] as List<dynamic>?)
          ?.map((e) => VideoLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayListToJson(PlayList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('hls', instance.hls);
  writeNotNull('download', instance.download?.map((e) => e.toJson()).toList());
  return val;
}
