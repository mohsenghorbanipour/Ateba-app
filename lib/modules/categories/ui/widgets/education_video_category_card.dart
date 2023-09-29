import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class EducationalVideoCategoryCard extends StatelessWidget {
  const EducationalVideoCategoryCard({super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: ColorPalette.of(context).background,
              border: Border.all(
                width: 1,
                color: ColorPalette.of(context).error,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              Assets.testIc,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'زنان ، زایمان',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          )
        ],
      );
}
