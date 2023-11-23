import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuggestionChip extends StatelessWidget {
  const SuggestionChip({
    required this.suggestion,
    super.key,
  });

  final String suggestion;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          context.goNamed(
            Routes.fastSearchPage,
            extra: suggestion,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 1.5,
              color: ColorPalette.of(context).primary,
            ),
          ),
          child: Text(
            suggestion,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      );
}
