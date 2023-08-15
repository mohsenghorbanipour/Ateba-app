import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer(
      {super.key,
      this.height,
      this.width,
      this.margin = EdgeInsets.zero,
      this.radius = 10});
  final double? height;
  final double? width;
  final EdgeInsets margin;

  final double radius;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Shimmer.fromColors(
      baseColor: (brightness == Brightness.light)
          ? const Color(0x08000000)
          : const Color(0x08FFFFFF),
      highlightColor: (brightness == Brightness.light)
          ? const Color(0x12000000)
          : const Color(0x12FFFFFF),
      direction: ShimmerDirection.rtl,
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
      ),
    );
  }
}
