import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoadMoreComponent extends StatelessWidget {
  const LoadMoreComponent({
    this.showText = true,
    super.key,
  });

  final bool showText;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showText)
            Text(
              'loading'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          LinearProgressIndicator(
            color: ColorPalette.of(context).primary,
          ),
        ],
      );
}
