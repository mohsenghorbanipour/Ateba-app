import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CategoryTutorialsTile extends StatelessWidget {
  const CategoryTutorialsTile({
    required this.slug,
    required this.category,
    required this.index,
    required this.tutorial,
    super.key,
  });


  final String slug;
  final Category category;
  final int index;
  final Tutorial tutorial;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          context.goNamed(
            Routes.categoryTutorialsDetials,
            pathParameters: {
              'slug': slug,
              'path': tutorial.slug ?? '',
            
            },
            extra: category,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.5,
                        color: ColorPalette.of(context).primary,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        TextInputFormatters.toPersianNumber(
                          (index + 1).toString(),
                        ),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 9,
                            color: ColorPalette.of(context).primary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      tutorial.title ?? '',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    tutorial.duration ?? '',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: ColorPalette.of(context)
                              .textPrimary
                              .withOpacity(0.8),
                        ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(
                    Assets.videoIc,
                    color:
                        ColorPalette.of(context).textPrimary.withOpacity(0.8),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
