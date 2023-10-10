import 'dart:ui';

import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TutorialCard extends StatelessWidget {
  const TutorialCard({
    required this.tutorial,
    super.key,
  });

  final Tutorial tutorial;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          context.goNamed(
            Routes.tutorialDetails,
            pathParameters: {
              'slug': tutorial.slug ?? '',
            },
          );
        },
        child: SizedBox(
          width: 150,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 36,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 48, right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorPalette.of(context).background,
                    border: Border.all(
                      width: 1.5,
                      color: ColorPalette.of(context).border,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            tutorial.title ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.checkIc,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text(
                                    tutorial.subtitle ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          fontSize: 8,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 6),
                          child: Text(
                            DateHelper.getDistanceWithToday(
                                tutorial.updated_at ?? ''),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontSize: 8,
                                  color: ColorPalette.of(context)
                                      .textPrimary
                                      .withOpacity(0.7),
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                top: 0,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: tutorial.thumbnail_url ?? '',
                        height: 80,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const ShimmerContainer(
                          width: double.infinity,
                          height: 80,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 16,
                      bottom: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: ColorPalette.of(context)
                                      .background
                                      .withOpacity(0.6),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${'name_of_teacher'.tr()}(${tutorial.teacher ?? ''})',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              fontSize: 8,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
