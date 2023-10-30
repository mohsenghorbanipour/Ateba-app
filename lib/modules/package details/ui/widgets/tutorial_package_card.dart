import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/ateba_router.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:ateba_app/modules/package%20details/data/models/tutorial_package.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/package_details_menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TutorialPackageCard extends StatelessWidget {
  const TutorialPackageCard({
    required this.slug,
    required this.tutorialPackage,
    super.key,
  });

  final String slug;
  final TutorialPackage tutorialPackage;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              width: 94,
                              height: 56,
                              fit: BoxFit.cover,
                              imageUrl:
                                  tutorialPackage.video?.thumbnail_url ?? '',
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorPalette.of(context).error,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: ColorPalette.of(context).white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tutorialPackage.title ?? '',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Assets.clockIc,
                                color: ColorPalette.of(context).textPrimary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  TextInputFormatters.toPersianNumber(
                                    tutorialPackage.video?.duration ?? '',
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        fontSize: 8,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              SvgPicture.asset(
                                Assets.visibilityIc,
                                color: ColorPalette.of(context).textPrimary,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  TextInputFormatters.toPersianNumber(
                                      (tutorialPackage.views_count ?? 0)
                                          .toString()),
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
                        )
                      ],
                    ),
                  ],
                ),
                const PackageDetailsMenu(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Text(
                tutorialPackage.description ?? '',
              ),
            )
          ],
        ),
      );
}
