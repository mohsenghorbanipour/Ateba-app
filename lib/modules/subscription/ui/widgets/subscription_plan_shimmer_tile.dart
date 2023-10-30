import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class SubscriptionPlatShimmerTile extends StatelessWidget {
  const SubscriptionPlatShimmerTile({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: ColorPalette.of(context).background,
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerContainer(
              width: 120,
              height: 14,
            ),
            ShimmerContainer(
              width: 60,
              height: 14,
            )
          ],
        ),
      );
}
