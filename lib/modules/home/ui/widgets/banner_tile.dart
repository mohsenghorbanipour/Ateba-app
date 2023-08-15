import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/modules/home/data/models/banner_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerTile extends StatelessWidget {
  const BannerTile({
    super.key,
    required this.bannerSlider,
    this.borderRadius = 10,
    this.margin,
    this.aspectRatio = 642 / 300, // top slider aspect ratio
  });

  final BannerSlider bannerSlider;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  final double aspectRatio;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin:
            margin ?? const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CachedNetworkImage(
              imageUrl: bannerSlider.cover ?? '',
              placeholder: (context, url) => const ShimmerContainer(
                  width: double.infinity, height: double.infinity),
            ),
          ),
        ),
      );
}
