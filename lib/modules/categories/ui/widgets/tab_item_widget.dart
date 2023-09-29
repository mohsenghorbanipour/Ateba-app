import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    required this.title,
    required this.onTap,
    this.selected = false,
    super.key,
  });

  final String title;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: selected
                  ? ColorPalette.of(context).primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: selected ? ColorPalette.of(context).white : null,
                    ),
              ),
            ),
          ),
        ),
      );
}
