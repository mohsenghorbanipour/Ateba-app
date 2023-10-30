import 'package:ateba_app/core/constants/hive_types.dart';
import 'package:hive/hive.dart';

part 'cache_video_model.g.dart';

@HiveType(typeId: HiveTypes.cacheVideoModel)
class CacheVideoModel extends HiveObject {
  CacheVideoModel({
    this.path,
    this.slug,
    this.url,
    this.type,
    this.size,
    this.qality,
    this.title,
    this.thumbnail_url,
  });

  @HiveField(0)
  String? path;
  @HiveField(1)
  final String? slug;
  @HiveField(2)
  final String? url;
  @HiveField(3)
  final String? type;
  @HiveField(4)
  final String? size;
  @HiveField(5)
  final String? qality;
  @HiveField(6)
  final String? title;
  @HiveField(7)
  final String? thumbnail_url;
}
