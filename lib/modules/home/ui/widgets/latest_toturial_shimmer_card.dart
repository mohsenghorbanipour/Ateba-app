import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class LatestTutorialShimmerCard extends StatelessWidget {
  const LatestTutorialShimmerCard({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 150,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 36,
              bottom: 0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 48, right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorPalette.of(context).background,
                  border: Border.all(
                    width: 1.5,
                    color: ColorPalette.of(context).border,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ShimmerContainer(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 24),
                          height: 16,
                        ),
                        ShimmerContainer(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 48, top: 6),
                          height: 10,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ShimmerContainer(
                        width: 40,
                        margin: EdgeInsets.only(left: 8, bottom: 8),
                        height: 10,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 8,
              right: 8,
              top: 0,
              child: ShimmerContainer(
                height: 80,
                width: double.infinity,
              ),
            ),
          ],
        ),
      );
}
