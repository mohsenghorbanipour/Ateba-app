import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/ateba_router.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/ui/widgets/teching_name_chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.package,
    this.width,
    super.key,
  });

  final Package package;
  final double? width;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          // AtebaRouter.router.navigateTo(
          //   context,
          //   Routes.packageDetails,
          // );
        },
        child: Container(
          width: width ?? 270,
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
                              imageUrl: package.icon ?? '',
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
                            '${package.title ?? ''} - ${package.teacher ?? ''}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.calendarIc),
                                Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Text(
                                    DateHelper.getShamsiData(
                                      package.date ?? '',
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontSize: 8,
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
                                    package.duration ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
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
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.bookmarkIc,
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
                  (package.subsets?.length ?? 0) > 5
                      ? 6
                      : (package.subsets?.length ?? 0),
                  (index) => ((package.subsets?.length ?? 0) > 5 && index == 5)
                      ? TechingNameChip(
                          teachingName:
                              '${(package.subsets?.length ?? 0) - 5}+',
                          isCircle: true,
                        )
                      : TechingNameChip(
                          teachingName: package.subsets?[index] ?? '',
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    package.price.toString() + 'toman'.tr(),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
