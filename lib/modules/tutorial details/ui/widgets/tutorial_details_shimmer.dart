import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TutorialDetailsShimmer extends StatelessWidget {
  const TutorialDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.of(context).background,
                        border: Border.all(
                          width: 1,
                          color: ColorPalette.of(context).border,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16,
                        color: ColorPalette.of(context).primary,
                      ),
                    ),
                  ),
                  const ShimmerContainer(
                    width: 113,
                    height: 24,
                  )
                ],
              ),
            ),
            const ShimmerContainer(
              width: double.infinity,
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 16),
              radius: 8,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerContainer(
                    width: 150,
                    height: 20,
                  ),
                  Row(
                    children: [
                      ShimmerContainer(
                        width: 43,
                        height: 20,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      ShimmerContainer(
                        width: 24,
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ShimmerContainer(
                    height: 14,
                    width: 24,
                  ),
                  ShimmerContainer(
                    height: 14,
                    width: 24,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  ShimmerContainer(
                    height: 14,
                    width: 24,
                  ),
                ],
              ),
            ),
            const ShimmerContainer(
              width: 150,
              height: 24,
              margin: EdgeInsets.fromLTRB(16, 24, 16, 6),
            ),
            const ShimmerContainer(
              width: double.infinity,
              height: 12,
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            ShimmerContainer(
              width: MediaQuery.of(context).size.width / 2,
              height: 12,
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 26),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ShimmerContainer(
                    width: double.infinity,
                    height: 24,
                  ),
                  ShimmerContainer(
                    width: double.infinity,
                    height: 24,
                    margin: EdgeInsets.symmetric(vertical: 16),
                  ),
                  ShimmerContainer(
                    width: double.infinity,
                    height: 24,
                  ),
                ],
              ),
            ),
            const ShimmerContainer(
              width: 150,
              height: 24,
              margin: EdgeInsets.fromLTRB(16, 24, 16, 6),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ShimmerContainer(
                    width: double.infinity,
                    height: 120,
                  ),
                  ShimmerContainer(
                    width: double.infinity,
                    height: 120,
                    margin: EdgeInsets.symmetric(vertical: 12),
                  ),
                  ShimmerContainer(
                    width: double.infinity,
                    height: 120,
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
