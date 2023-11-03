import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class BookmarkCardShimmer extends StatelessWidget {
  const BookmarkCardShimmer({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
        ),
        child: const Column(
          children: [
            Row(
              children: [
                ShimmerContainer(
                  width: 56,
                  height: 56,
                  radius: 4,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerContainer(
                        width: 140,
                        height: 20,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          ShimmerContainer(
                            width: 50,
                            height: 18,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          ShimmerContainer(
                            width: 50,
                            height: 18,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  ShimmerContainer(
                    width: 105,
                    height: 24,
                  )
                ],
              ),
            )
          ],
        ),
      );
}
