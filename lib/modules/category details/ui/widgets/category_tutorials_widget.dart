import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class CategoryTutorialsWidget extends StatelessWidget {
  const CategoryTutorialsWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
        ),
      );
}
