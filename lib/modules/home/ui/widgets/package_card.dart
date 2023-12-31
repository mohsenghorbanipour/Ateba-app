import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/home/data/models/package.dart';
import 'package:ateba_app/modules/home/data/models/students_sample.dart';
import 'package:ateba_app/modules/home/ui/widgets/students_widget.dart';
import 'package:ateba_app/modules/home/ui/widgets/teching_name_chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ateba_app/core/utils/price_ext.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.package,
    this.width,
    super.key,
  });

  final Package package;
  final double? width;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          context.goNamed(
            Routes.packageDetails,
            pathParameters: {
              'slug': package.slug ?? '',
            },
          );
        },
        child: Container(
          height: 228,
          width: width ?? 270,
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
                    placeholder: (_, __) => const ShimmerContainer(
                      width: double.infinity,
                      height: 76,
                      radius: 4,
                    ),
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
                                    color: ColorPalette.of(context)
                                        .textPrimary
                                        .withOpacity(0.8),
                                  ),
                        ),
                        Text(
                          TextInputFormatters.toPersianNumber(
                            ' - ${package.duration ?? ''}',
                          ),
                          style: Theme.of(context).textTheme.labelMedium,
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
                    (package.tutorials_sample?.tutorials_titles?.length ?? 0) >=
                            4
                        ? 3
                        : (package.tutorials_sample?.tutorials_titles?.length ??
                            0),
                    (index) => (index == 3)
                        ? TechingNameChip(
                            teachingName:
                                '${TextInputFormatters.toPersianNumber(((package.tutorials_sample?.tutorials_count ?? 0) - ((package.tutorials_sample?.tutorials_titles?.length ?? 0) - 3)).toString())}+',
                            isCircle: true,
                            isPackages: true,
                          )
                        : TechingNameChip(
                            teachingName: package.tutorials_sample
                                    ?.tutorials_titles?[index] ??
                                '',
                            isPackages: true,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 12, left: 12, right: 12, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StudentsWidget(
                      students: package.students_sample ?? StudentsSample(),
                    ),
                    ButtonComponent(
                      onPressed: () {},
                      width: 140,
                      height: 24,
                      borderRadius: BorderRadius.circular(4),
                      child: Text(
                        TextInputFormatters.toPersianNumber(
                          '${package.price?.withPriceLable ?? ''} ${'toman'.tr()}',
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: ColorPalette.of(context).white,
                            ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
