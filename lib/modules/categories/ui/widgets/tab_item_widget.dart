import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    required this.title,
    required this.onTap,
    this.selected = false,
    this.disableOnTap = false,
    this.showMenu = false,
    this.showArrowIcon,
    super.key,
  });

  final String title;
  final Function() onTap;
  final bool selected;
  final bool disableOnTap;
  final bool showMenu;
  final bool? showArrowIcon;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: disableOnTap ? null : onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: selected
                ? ColorPalette.of(context).primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: selected ? ColorPalette.of(context).white : null,
                      ),
                ),
              ),
              if (showArrowIcon ?? false)
                AnimatedRotation(
                  turns: showMenu ? 1 : 2,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    showMenu
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: selected ? ColorPalette.of(context).white : null,
                  ),
                )
            ],
          ),
        ),
      );
}
