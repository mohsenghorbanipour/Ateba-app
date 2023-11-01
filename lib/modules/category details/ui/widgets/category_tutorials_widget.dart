import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:ateba_app/modules/category%20details/ui/widgets/category_tutorials_tile.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:flutter/material.dart';

class CategoryTutorialsWidget extends StatelessWidget {
  const CategoryTutorialsWidget({
    required this.slug,
    required this.category,
    required this.tutorials,
    super.key,
  });

  final String slug;
  final Category category;
  final List<Tutorial> tutorials;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
        ),
        child: ListView.separated(
          itemCount: tutorials.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => Divider(
            height: 0.5,
            color: ColorPalette.of(context).border,
            indent: 16,
            endIndent: 16,
          ),
          itemBuilder: (context, index) => CategoryTutorialsTile(
            category: category,
            slug: slug,
            index: index,
            tutorial: tutorials[index],
          ),
        ),
      );
}
