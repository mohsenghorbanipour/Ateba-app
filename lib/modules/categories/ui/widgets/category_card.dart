import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.category,
    super.key,
  });

  final Category category;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              context.goNamed(
                Routes.categoryDetials,
                pathParameters: {
                  'slug': category.slug ?? '',
                },
                extra: category,
              );
            },
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: ColorPalette.of(context).background,
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).error,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: category.thumbnail_url ?? '',
                fit: BoxFit.cover,
                placeholder: (_, __) => const ShimmerContainer(
                  width: 68,
                  height: 68,
                  radius: 8,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              category.title ?? '',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        ],
      );
}
