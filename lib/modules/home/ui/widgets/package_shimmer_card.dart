import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class PackageShimmerCard extends StatelessWidget {
  const PackageShimmerCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 220,
        width: 255,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorPalette.of(context).background,
          border: Border.all(
            width: 1.5,
            color: ColorPalette.of(context).border,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const ShimmerContainer(
                  width: 237,
                  height: 76,
                  radius: 4,
                  margin: EdgeInsets.all(8),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerContainer(
                        width: 120,
                        height: 20,
                      ),
                      ShimmerContainer(
                        width: 40,
                        height: 12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => const ShimmerContainer(
                        width: 30,
                        height: 14,
                        radius: 70,
                        margin: EdgeInsets.symmetric(horizontal: 3),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerContainer(
                    width: 80,
                    height: 18,
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
