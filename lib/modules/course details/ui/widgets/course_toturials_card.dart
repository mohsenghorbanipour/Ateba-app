import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CourseToturialsCard extends StatelessWidget {
  const CourseToturialsCard({
    required this.slug,
    required this.tutorial,
    super.key,
  });

  final String slug;
  final Tutorial tutorial;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          context.goNamed(
            Routes.courseTutorialDetails,
            pathParameters: {
              'slug': slug,
              'link': tutorial.slug ?? '',
            },
          );
        },
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: ColorPalette.of(context).background,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 0.5,
                color: ColorPalette.of(context).border,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  tutorial.title ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Text(
                    TextInputFormatters.toPersianNumber(
                      tutorial.duration ?? '',
                    ),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorPalette.of(context)
                              .textPrimary
                              .withOpacity(0.8),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset(
                      Assets.videoIc,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
