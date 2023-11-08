import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class BookmarksTile extends StatelessWidget {
  const BookmarksTile({
    required this.title,
    required this.onTap,
    this.selected = false,
    this.subTitle,
    super.key,
  });

  final String title;
  final Function() onTap;
  final bool selected;
  final String? subTitle;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).black,
                ),
              ),
              child: selected
                  ? Container(
                      margin: const EdgeInsets.all(1.8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.of(context).primary,
                      ),
                    )
                  : null,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              subTitle ?? '',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color:
                        ColorPalette.of(context).textPrimary.withOpacity(0.85),
                  ),
            )
          ],
        ),
      );
}
