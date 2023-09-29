import 'package:ateba_app/modules/package%20details/ui/widgets/package_lesson_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LessonsWidget extends StatelessWidget {
  const LessonsWidget({super.key});

  @override
  Widget build(BuildContext context) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(
          height: 28,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) => const PackageLessonCard(),
      );
}
