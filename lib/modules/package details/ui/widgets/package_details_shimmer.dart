import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class PackageDetailsShimmer extends StatelessWidget {
  const PackageDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          const ShimmerContainer(
            width: double.infinity,
            height: 200,
          ),
          Container(
            width: double.infinity,
            height: 38,
            color: ColorPalette.of(context).darkSilver,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                4,
                (index) => const ShimmerContainer(
                  height: 20,
                  width: 35,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              children: List.generate(
                4,
                (index) => const ShimmerContainer(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 6),
                ),
              ),
            ),
          )
        ],
      );
}
