// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CacheVideoModelAdapter extends TypeAdapter<CacheVideoModel> {
  @override
  final int typeId = 1;

  @override
  CacheVideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheVideoModel(
      id: fields[0] as int?,
      path: fields[1] as String?,
      slug: fields[2] as String?,
      url: fields[3] as String?,
      size: fields[4] as String?,
      qality: fields[5] as String?,
      title: fields[6] as String?,
      thumbnail_url: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CacheVideoModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.qality)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.thumbnail_url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheVideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
