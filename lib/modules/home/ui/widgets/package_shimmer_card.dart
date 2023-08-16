import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class PackageShimmerCard extends StatelessWidget {
  const PackageShimmerCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 270,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            width: 1.5,
            color: ColorPalette.of(context).border,
          ),
          color: ColorPalette.of(context).background,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(
                  width: 48,
                  height: 48,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerContainer(
                          height: 14,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ShimmerContainer(
                          height: 10,
                          margin: EdgeInsets.only(left: 24, right: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                ShimmerContainer(
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            Wrap(
              spacing: 6,
              children: [
                ShimmerContainer(
                  width: 60,
                  height: 30,
                ),
                ShimmerContainer(
                  width: 60,
                  height: 30,
                ),
                ShimmerContainer(
                  width: 60,
                  height: 30,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ShimmerContainer(
                width: 80,
                height: 14,
              ),
            )
          ],
        ),
      );
}
