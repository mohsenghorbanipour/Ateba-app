import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/modules/home/data/models/teacher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TeacherTile extends StatelessWidget {
  const TeacherTile({
    required this.teacher,
    super.key,
  });

  final Teacher teacher;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              width: 80,
              height: 80,
              imageUrl: teacher.picture_url ?? '',
              fit: BoxFit.cover,
              placeholder: (_, __) => const ShimmerContainer(
                width: 80,
                height: 80,
                radius: 8,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Text(
                    '${teacher.name ?? ''} - ${teacher.expertise ?? ''}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    teacher.description ?? '',
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
