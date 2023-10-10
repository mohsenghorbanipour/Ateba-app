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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              if (selected)
                Container(
                  height: 2,
                  width: 12,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: ColorPalette.of(context).primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            ],
          ),
        ),
      );
}
