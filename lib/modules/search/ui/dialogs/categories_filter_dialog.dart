import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesFilterDialog extends StatelessWidget {
  const CategoriesFilterDialog({super.key});

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: ColorPalette.of(context).background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    'ateba_categories'.tr(),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset(
                    Assets.closeIc,
                  ),
                )
              ],
            ),
            // GridView.builder(
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 16,
            //     mainAxisExtent: 36,
            //     mainAxisSpacing: 16,
            //   ),
            //   itemBuilder: itemBuilder,
            // )
          ],
        ),
      );
}
