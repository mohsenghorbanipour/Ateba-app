import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:flutter/material.dart';

class CategoryCardShimmer extends StatelessWidget {
  const CategoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) => const Column(
        children: [
          ShimmerContainer(
            width: 68,
            height: 68,
            radius: 8,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: ShimmerContainer(
              width: 50,
              height: 13,
            ),
          )
        ],
      );
}
