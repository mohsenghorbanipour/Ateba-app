import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/resources/models/cache_video_model.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:ateba_app/modules/bookmarks/data/models/bookmark.dart';
import 'package:ateba_app/modules/bookmarks/ui/dialogs/confirm_delete_dialog.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video_link.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({
    required this.index,
    required this.bookmark,
    this.isBookmark = false,
    this.isGalleryOffline = false,
    super.key,
  });

  final int index;
  final Bookmark bookmark;
  final bool isBookmark;
  final bool isGalleryOffline;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(8),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        width: 56,
                        height: 56,
                        imageUrl: bookmark.thumbnail_url ?? '',
                        fit: BoxFit.cover,
                        placeholder: (_, __) => const ShimmerContainer(
                          width: 56,
                          height: 56,
                          radius: 4,
                        ),
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
                          InkWell(
                            onTap: () {
                              if (isGalleryOffline) {
                                context.goNamed(
                                  Routes.mainPagevideoPlayer,
                                  pathParameters: {
                                    'id': bookmark.videoId.toString(),
                                  },
                                  extra: {
                                    'playFromOfflineGallery': true,
                                    'slug': '',
                                    'path': bookmark.path,
                                    'video': Video(
                                      download_links: [
                                        VideoLink(
                                          quality: bookmark.quality,
                                          size: '',
                                        ),
                                      ],
                                      id: bookmark.videoId,
                                      hls_url: '',
                                      thumbnail_url: bookmark.thumbnail_url,
                                      duration: bookmark.duration,
                                      title: bookmark.title,
                                    ),
                                  },
                                );
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.of(context).error,
                              ),
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: ColorPalette.of(context).white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookmark.title ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            if (bookmark.updated_at?.isNotEmpty ?? false)
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.refreshIc,
                                    color: ColorPalette.of(context).error,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Text(
                                      DateHelper.getDistanceWithToday(
                                        bookmark.updated_at ?? '',
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: ColorPalette.of(context)
                                                .textPrimary
                                                .withOpacity(0.8),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              width: 12,
                            ),
                            if (bookmark.duration?.isNotEmpty ?? false)
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.clockIc,
                                    color: ColorPalette.of(context).error,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Text(
                                      TextInputFormatters.toPersianNumber(
                                        bookmark.duration ?? '',
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: ColorPalette.of(context)
                                                .textPrimary
                                                .withOpacity(0.8),
                                          ),
                                    ),
                                  )
                                ],
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (isBookmark)
                  InkWell(
                    onTap: () {
                      Provider.of<BookmarksBloc>(context, listen: false)
                          .unbookmarkIc(
                        bookmark.link_to?.slug ?? '',
                        index,
                      );
                    },
                    child: SvgPicture.asset(
                      Assets.unbookmarkIc,
                    ),
                  ),
                if (isGalleryOffline)
                  InkWell(
                    onTap: () {
                      showAnimatedDialog(
                        context: context,
                        curve: Curves.easeIn,
                        animationType: DialogTransitionType.fade,
                        duration: const Duration(milliseconds: 300),
                        builder: (context) => const ConfirmDeleteDialog(),
                      );
                    },
                    child: Icon(
                      CupertinoIcons.delete,
                      size: 18,
                      color: ColorPalette.of(context).error,
                    ),
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: (bookmark.subtitle?.isNotEmpty ?? false)
                        ? Row(
                            children: [
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPalette.of(context).error,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  bookmark.subtitle ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: ColorPalette.of(context)
                                            .textPrimary
                                            .withOpacity(0.8),
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ),
                ButtonComponent(
                  width: 170,
                  height: 28,
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.transparent,
                  borderSide: BorderSide(
                      width: 1, color: ColorPalette.of(context).primary),
                  onPressed: () {
                    if (bookmark.link_to?.type == 'course') {
                      context.goNamed(Routes.courseDetails, pathParameters: {
                        'slug': bookmark.link_to?.slug ?? '',
                      });
                    } else if ((bookmark.link_to?.type == 'package')) {
                      context.goNamed(
                        Routes.packageDetails,
                        pathParameters: {
                          'slug': bookmark.link_to?.slug ?? '',
                        },
                      );
                    } else if ((bookmark.link_to?.type == 'tutorial')) {
                      context.goNamed(
                        Routes.tutorialDetails,
                        pathParameters: {
                          'slug': bookmark.link_to?.slug ?? '',
                        },
                      );
                    }
                  },
                  child: Text(
                    (isBookmark || isGalleryOffline)
                        ? 'see_details'.tr()
                        : 'see_tutorials'.tr(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorPalette.of(context).primary,
                        ),
                  ),
                )
              ],
            )
          ],
        ),
      );
}
