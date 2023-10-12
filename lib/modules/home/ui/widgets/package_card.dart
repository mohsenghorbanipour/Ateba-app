import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/ui/widgets/teching_name_chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.package,
    super.key,
  });

  final Package package;

  @override
  Widget build(BuildContext context) => Container(
        height: 220,
        width: 255,
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: package.cover_url ?? '',
                  width: double.infinity,
                  height: 76,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    package.title ?? '',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        TextInputFormatters.toPersianNumber(
                          DateHelper.getShamsiData(
                            package.updated_at ?? '',
                          ),
                        ),
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 8,
                                  color: ColorPalette.of(context)
                                      .textPrimary
                                      .withOpacity(0.8),
                                ),
                      ),
                      Text(
                        TextInputFormatters.toPersianNumber(
                          ' - ${package.duration ?? ''}',
                        ),
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 8,
                                ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 5,
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                children: List.generate(
                  (package.tutorials_sample?.length ?? 0) > 4
                      ? 5
                      : (package.tutorials_sample?.length ?? 0),
                  (index) => ((package.tutorials_sample?.length ?? 0) > 4 &&
                          index == 4)
                      ? TechingNameChip(
                          teachingName:
                              '${(package.tutorials_sample?.length ?? 0) - 4 + (package.tutorials_count ?? 0)}+',
                          isCircle: true,
                          isPackages: true,
                        )
                      : TechingNameChip(
                          teachingName: package.tutorials_sample?[index] ?? '',
                          isPackages: true,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 12, right: 12, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonComponent(
                    onPressed: () {},
                    width: 125,
                    height: 22,
                    borderRadius: BorderRadius.circular(4),
                    child: Text(
                      TextInputFormatters.toPersianNumber(
                        '${package.price} ${'toman'.tr()}',
                      ),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: ColorPalette.of(context).white,
                          ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
