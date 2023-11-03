import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PackageDetailsMenu extends StatelessWidget {
  const PackageDetailsMenu({super.key});

  @override
  Widget build(BuildContext context) => PopupMenuButton(
        color: ColorPalette.of(context).background,
        elevation: 0,
        padding: EdgeInsets.zero,
        offset: const Offset(
          20,
          28,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              width: 1,
              color: ColorPalette.of(context).border,
            )),
        icon: Icon(
          Icons.more_vert,
          size: 22,
          color: ColorPalette.of(context).textPrimary,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            padding: EdgeInsets.zero,
            onTap: null,
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.downloadIc,
                            color: ColorPalette.of(context).textPrimary,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              'add_to_gallery_offline'.tr(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 35,
                    //   padding: const EdgeInsets.symmetric(horizontal: 12),
                    //   child: Row(
                    //     children: [
                    //       SvgPicture.asset(
                    //         Assets.bookmarkIc,
                    //         color: ColorPalette.of(context).textPrimary,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 4),
                    //         child: Text(
                    //           'bookmarking'.tr(),
                    //           style: Theme.of(context).textTheme.labelSmall,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          )
        ],
      );
}
