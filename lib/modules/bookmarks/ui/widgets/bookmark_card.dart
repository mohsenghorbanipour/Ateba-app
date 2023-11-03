import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/bookmarks/data/models/bookmark.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({
    required this.bookmark,
    super.key,
  });

  final Bookmark bookmark;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    width: 56,
                    height: 56,
                    imageUrl: bookmark.thumbnail ?? '',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookmark.title ?? '',
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.calendarIc,
                              color: ColorPalette.of(context).error,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Text(
                                DateHelper.getDistanceWithToday(
                                  bookmark.updated_at ?? '',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: ColorPalette.of(context)
                                          .textPrimary
                                          .withOpacity(0.8),
                                      fontSize: 8,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SvgPicture.asset(
                              Assets.clockIc,
                              color: ColorPalette.of(context).error,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Text(
                                TextInputFormatters.toPersianNumber(
                                  bookmark.duration ?? '',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: ColorPalette.of(context)
                                          .textPrimary
                                          .withOpacity(0.8),
                                      fontSize: 8,
                                    ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonComponent(
                  width: 140,
                  height: 24,
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.transparent,
                  borderSide: BorderSide(
                      width: 1, color: ColorPalette.of(context).primary),
                  onPressed: () {
                    if (bookmark.link_to?.type == 'course') {
                      context.goNamed(Routes.courseDetails, pathParameters: {
                        'slug': bookmark.link_to?.slug ?? '',
                      });
                    } else if ((bookmark.link_to?.type == 'package')) {
                      context.goNamed(
                        Routes.packageDetails,
                        pathParameters: {
                          'slug': bookmark.link_to?.slug ?? '',
                        },
                      );
                    } else if ((bookmark.link_to?.type == 'tutorial')) {
                      context.goNamed(
                        Routes.tutorialDetails,
                        pathParameters: {
                          'slug': bookmark.link_to?.slug ?? '',
                        },
                      );
                    }
                  },
                  child: Text(
                    'see_tutorials'.tr(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: ColorPalette.of(context).primary,
                        ),
                  ),
                )
              ],
            )
          ],
        ),
      );
}
