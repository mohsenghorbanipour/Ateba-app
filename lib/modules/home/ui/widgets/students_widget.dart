import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/modules/home/data/models/students_sample.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StudentsWidget extends StatelessWidget {
  const StudentsWidget({
    required this.students,
    super.key,
  });

  final StudentsSample students;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 18,
        width: 80,
        child: Stack(
          children: List.generate(
            (students.pictures_sample?.length ?? 0) >= 3
                ? 3
                : (students.pictures_sample?.length ?? 0),
            (index) => Positioned(
              right: index * 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CachedNetworkImage(
                  width: 18,
                  height: 18,
                  imageUrl: students.pictures_sample?[0] ?? '',
                  placeholder: (_, __) => const ShimmerContainer(
                    width: 18,
                    height: 18,
                    radius: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
