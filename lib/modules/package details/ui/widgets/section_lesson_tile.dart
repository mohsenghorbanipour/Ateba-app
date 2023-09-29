import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SectionLessonTile extends StatelessWidget {
  const SectionLessonTile({super.key});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: ColorPalette.of(context).error),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                'بخش آموزشی درس',
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '۲۲:۲۶',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SvgPicture.asset(
            Assets.playIc,
          )
        ],
      );
}
