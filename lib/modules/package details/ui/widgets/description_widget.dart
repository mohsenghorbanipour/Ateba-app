import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/package%20details/bloc/package_details_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
            child: Text(
              '${'preview_of_package'.tr()} ${context.select<PackageDetailsBloc, String>((bloc) => bloc.packageDetails?.title ?? '')}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18, left: 16),
            child: Text(
              context.select<PackageDetailsBloc, String>(
                  (bloc) => bloc.packageDetails?.description ?? ''),
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 24, left: 16),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16, left: 4),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.of(context).error,
                  ),
                ),
                Expanded(
                  child: Text(
                    'description_info'.tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: ColorPalette.of(context).background,
                      border: Border.all(
                        width: 1,
                        color: ColorPalette.of(context).primary,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.visibilityIc,
                          width: 18,
                          color: ColorPalette.of(context).textPrimary,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          TextInputFormatters.toPersianNumber(
                            context.select<PackageDetailsBloc, String>(
                                  (bloc) =>
                                      bloc.packageDetails?.views_count
                                          .toString() ??
                                      '0',
                                ) +
                                'viewed'.tr(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: ColorPalette.of(context).background,
                      border: Border.all(
                        width: 1,
                        color: ColorPalette.of(context).primary,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.copyIc,
                          width: 18,
                          color: ColorPalette.of(context).textPrimary,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          TextInputFormatters.toPersianNumber(
                            context.select<PackageDetailsBloc, String>(
                                  (bloc) =>
                                      bloc.packageDetails?.tutorials_count
                                          .toString() ??
                                      '0',
                                ) +
                                'educational_titles'.tr(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
