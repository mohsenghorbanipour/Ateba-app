import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class ViewMoreWidget extends StatelessWidget {
  const ViewMoreWidget({
    required this.title,
    required this.onTap,
    super.key,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.3,
                  color: ColorPalette.of(context).error,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: ColorPalette.of(context).error,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          ],
        ),
  );
}
