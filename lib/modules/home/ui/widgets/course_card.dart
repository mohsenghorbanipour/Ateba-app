import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/home/data/models/course.dart';
import 'package:ateba_app/modules/home/ui/widgets/teching_name_chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ateba_app/core/utils/price_ext.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.course,
    this.width,
    super.key,
  });

  final Course course;
  final double? width;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          context.goNamed(
            Routes.courseDetails,
            pathParameters: {
              'slug': course.slug ?? '',
            },
          );
        },
        child: Container(
          width: width ?? 280,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 1.5,
              color: ColorPalette.of(context).border,
            ),
            color: ColorPalette.of(context).background,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Stack(
                      children: [
                        Container(
                          color: ColorPalette.of(context).darkWhite,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: course.thumbnail_url ?? '',
                              placeholder: (_, __) => const ShimmerContainer(
                                width: 48,
                                height: 48,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.refreshIc),
                                Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Text(
                                    DateHelper.getShamsiData(
                                      course.created_at ?? '',
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontSize: 8,
                                          color: ColorPalette.of(context)
                                              .textPrimary
                                              .withOpacity(0.8),
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                SvgPicture.asset(Assets.clockIc),
                                Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Text(
                                    course.duration ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontSize: 8,
                                          color: ColorPalette.of(context)
                                              .textPrimary
                                              .withOpacity(0.8),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'includes_training'.tr(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Wrap(
                spacing: 5,
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                children: List.generate(
                  (course.tutorials_sample?.tutorials_titles?.length ?? 0),
                  (index) => (index ==
                              ((course.tutorials_sample?.tutorials_titles
                                          ?.length ??
                                      0) -
                                  1) &&
                          (course.tutorials_sample?.tutorials_titles?.length ??
                                  0) >
                              4)
                      ? TechingNameChip(
                          teachingName:
                              '${TextInputFormatters.toPersianNumber(((course.tutorials_sample?.tutorials_count ?? 0) - ((course.tutorials_sample?.tutorials_titles?.length ?? 0) - 1)).toString())}+',
                          isCircle: true,
                          isPackages: true,
                        )
                      : TechingNameChip(
                          teachingName: course
                                  .tutorials_sample?.tutorials_titles?[index] ??
                              '',
                          isPackages: true,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      TextInputFormatters.toPersianNumber(
                        course.price?.withPriceLable ?? '',
                      ),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      ' ${'toman'.tr()}',
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
