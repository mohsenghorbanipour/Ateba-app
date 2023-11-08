import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class TechingNameChip extends StatelessWidget {
  const TechingNameChip({
    required this.teachingName,
    this.isCircle = false,
    this.isPackages = false,
    super.key,
  });

  final String teachingName;
  final bool isCircle;
  final bool isPackages;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 9),
            margin: const EdgeInsets.only(top: 8),
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              color: isPackages ? ColorPalette.of(context).grey : null,
              border: Border.all(
                width: 1,
                color: ColorPalette.of(context).primary,
              ),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isCircle
                  ? null
                  : isPackages
                      ? BorderRadius.circular(70)
                      : BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                teachingName,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ],
      );
}
