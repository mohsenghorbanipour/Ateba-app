import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class TutorialPackageVideoTile extends StatelessWidget {
  const TutorialPackageVideoTile({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: ColorPalette.of(context).scaffoldBackground,
          borderRadius: BorderRadius.circular(6),
        ),
      );
}
