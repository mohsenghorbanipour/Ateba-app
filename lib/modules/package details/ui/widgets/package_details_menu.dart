import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/package%20details/bloc/package_details_bloc.dart';
import 'package:ateba_app/modules/package%20details/data/models/tutorial_package.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/dialogs/download_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PackageDetailsMenu extends StatelessWidget {
  const PackageDetailsMenu({
    required this.index,
    required this.tutorialPackage,
    super.key,
  });

  final int index;
  final TutorialPackage tutorialPackage;

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
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (Provider.of<PackageDetailsBloc>(context,
                                    listen: false)
                                .packageDetails
                                ?.has_bought ??
                            false) {
                          if (Provider.of<DownloadVideoBloc>(context,
                                      listen: false)
                                  .selectedVideoIdForDownload !=
                              null) {
                            if (Provider.of<DownloadVideoBloc>(context,
                                        listen: false)
                                    .selectedVideoIdForDownload ==
                                tutorialPackage.videos?.first.id) {
                              showAnimatedDialog(
                                context: context,
                                curve: Curves.easeIn,
                                animationType: DialogTransitionType.fade,
                                duration: const Duration(milliseconds: 300),
                                builder: (ctx) => ChangeNotifierProvider.value(
                                  value: Provider.of<PackageDetailsBloc>(
                                      context,
                                      listen: false),
                                  child: DownloadDialog(
                                    video: tutorialPackage.videos?.first ??
                                        Video(),
                                    slug: tutorialPackage.slug ?? '',
                                    type: 'tutorial',
                                    title: tutorialPackage.title ?? '',
                                    updated_at: Provider.of<PackageDetailsBloc>(
                                                context,
                                                listen: false)
                                            .packageDetails
                                            ?.updated_at ??
                                        '',
                                    currentIndex:
                                        Provider.of<DownloadVideoBloc>(context,
                                                listen: false)
                                            .selectedVideoIndexForDownload,
                                  ),
                                ),
                              );
                            } else {
                              ToastComponent.show(
                                'anuther_video_is_downloading'.tr(),
                                type: ToastType.info,
                              );
                              return;
                            }
                          } else {
                            showAnimatedDialog(
                              context: context,
                              curve: Curves.easeIn,
                              animationType: DialogTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                              builder: (ctx) => ChangeNotifierProvider.value(
                                value: Provider.of<PackageDetailsBloc>(context,
                                    listen: false),
                                child: DownloadDialog(
                                  video:
                                      tutorialPackage.videos?.first ?? Video(),
                                  slug: tutorialPackage.slug ?? '',
                                  type: 'tutorial',
                                  title: tutorialPackage.title ?? '',
                                  updated_at: Provider.of<PackageDetailsBloc>(
                                              context,
                                              listen: false)
                                          .packageDetails
                                          ?.updated_at ??
                                      '',
                                ),
                              ),
                            );
                          }
                        } else {
                          ToastComponent.show(
                            'you_are_not_access_this_package'.tr(),
                            type: ToastType.info,
                          );
                          return;
                        }
                      },
                      child: Container(
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
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (tutorialPackage.is_bookmarked ?? false) {
                          Provider.of<PackageDetailsBloc>(context,
                                  listen: false)
                              .unBookmarkTutorial(
                            tutorialPackage.slug ?? '',
                            index,
                          );
                        } else {
                          Provider.of<PackageDetailsBloc>(context,
                                  listen: false)
                              .bookmarkTutorial(
                            tutorialPackage.slug ?? '',
                            index,
                          );
                        }
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              (tutorialPackage.is_bookmarked ?? false)
                                  ? Assets.bookmarkFillIc
                                  : Assets.bookmarkIc,
                              color: (tutorialPackage.is_bookmarked ?? false)
                                  ? null
                                  : ColorPalette.of(context).textPrimary,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                (tutorialPackage.is_bookmarked ?? false)
                                    ? 'delete_from_bookmarking'.tr()
                                    : 'bookmarking'.tr(),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      );
}
