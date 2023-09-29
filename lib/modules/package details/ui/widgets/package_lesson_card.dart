import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/section_lesson_tile.dart';
import 'package:flutter/material.dart';

class PackageLessonCard extends StatelessWidget {
  const PackageLessonCard({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'عنوان اصلی درس (۱)',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          ListView.separated(
            padding: const EdgeInsets.only(top: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(
              height: 16,
            ),
            itemBuilder: (context, index) => const SectionLessonTile(),
          )
        ],
      );
}
