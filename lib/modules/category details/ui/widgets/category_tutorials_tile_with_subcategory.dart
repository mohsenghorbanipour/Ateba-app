import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/categories/data/models/category.dart';
import 'package:ateba_app/modules/categories/data/models/category_details_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CategoryTutorialsTileWithSubCategory extends StatefulWidget {
  const CategoryTutorialsTileWithSubCategory({
    required this.slug,
    required this.category,
    required this.categoryDetailsResponse,
    super.key,
  });

  final String slug;
  final Category category;
  final CategoryDetailsResponse categoryDetailsResponse;

  @override
  State<CategoryTutorialsTileWithSubCategory> createState() =>
      _CategoryTutorialsTileWithSubCategoryState();
}

class _CategoryTutorialsTileWithSubCategoryState
    extends State<CategoryTutorialsTileWithSubCategory> {
  bool showTutorials = false;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showTutorials = !showTutorials;
              });
            },
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPalette.of(context).background,
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).border,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.categoryDetailsResponse.title ?? '',
                      ),
                      Text(
                        ' (${TextInputFormatters.toPersianNumber(
                          (widget.categoryDetailsResponse.tutorials_count ?? 0)
                              .toString(),
                        )} ${'video'.tr()})',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: ColorPalette.of(context)
                                      .textPrimary
                                      .withOpacity(0.8),
                                ),
                      ),
                    ],
                  ),
                  AnimatedRotation(
                    turns: showTutorials ? 2 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      showTutorials
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                    ),
                  )
                ],
              ),
            ),
          ),
          if (showTutorials)
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).background,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).border,
                ),
              ),
              child: ListView.builder(
                itemCount: widget.categoryDetailsResponse.tutorials?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    context.goNamed(
                      Routes.categoryTutorialsDetials,
                      pathParameters: {
                        'slug': widget.slug,
                        'path': widget.categoryDetailsResponse.tutorials?[index].slug ?? '',
                      },
                      extra: widget.category,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          fontSize: 9,
                                          color:
                                              ColorPalette.of(context).primary),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                widget.categoryDetailsResponse.tutorials?[index]
                                        .title ??
                                    '',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: ColorPalette.of(context)
                                          .textPrimary
                                          .withOpacity(0.85),
                                    ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              widget.categoryDetailsResponse.tutorials?[index]
                                      .duration ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
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
                              width: 14,
                              color: ColorPalette.of(context)
                                  .textPrimary
                                  .withOpacity(0.8),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      );
}
