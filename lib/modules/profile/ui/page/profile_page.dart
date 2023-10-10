import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorPalette.of(context).background,
              border: Border.all(
                width: 1,
                color: ColorPalette.of(context).border,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.squarespace-cdn.com/content/v1/5a1c2452268b96d901cd3471/1546637246803-H5RMXRRU7TN92M7PJAE5/beautiful-boy1.jpg?format=2500w',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'محسن قربانی پور',
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          TextInputFormatters.toPersianNumber(
                            '989135023614+',
                          ),
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      ],
                    ),
                  ),
                ),
                SvgPicture.asset(
                  Assets.editWriteIc,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorPalette.of(context).background,
              border: Border.all(
                width: 1,
                color: ColorPalette.of(context).border,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.starIc,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        'buy_a_subscription'.tr(),
                      ),
                    )
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: ColorPalette.of(context).lightGrey,
                  ),
                  child: Text(
                    'اشتراک فعلی وجود ندارد',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 48),
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
                
              ],
            ),
          )
        ],
      );
}
