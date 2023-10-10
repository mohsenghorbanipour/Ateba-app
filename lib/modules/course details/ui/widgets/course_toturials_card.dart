import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:flutter/material.dart';

class CourseToturialsCard extends StatelessWidget {
  const CourseToturialsCard({
    required this.tutorial,
    super.key,
  });

  final Tutorial tutorial;

  @override
  Widget build(BuildContext context) => Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: ColorPalette.of(context).background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 0.5,
              color: ColorPalette.of(context).border,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                tutorial.title ?? '',
                style: Theme.of(context).textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              TextInputFormatters.toPersianNumber(
                tutorial.duration ?? '',
              ),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color:
                        ColorPalette.of(context).textPrimary.withOpacity(0.8),
                  ),
            )
          ],
        ),
      );
}
