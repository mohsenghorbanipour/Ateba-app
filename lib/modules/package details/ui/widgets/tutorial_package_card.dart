import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/package%20details/bloc/package_details_bloc.dart';
import 'package:ateba_app/modules/package%20details/data/models/tutorial_package.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/package_details_menu.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/dialogs/download_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/widgets/styled_text.dart';

class TutorialPackageCard extends StatefulWidget {
  const TutorialPackageCard({
    required this.slug,
    required this.index,
    required this.tutorialPackage,
    super.key,
  });

  final String slug;
  final int index;
  final TutorialPackage tutorialPackage;

  @override
  State<TutorialPackageCard> createState() => _TutorialPackageCardState();
}

class _TutorialPackageCardState extends State<TutorialPackageCard> {
  bool showMore = false;

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
                      child: InkWell(
                        onTap: () {
                          context.goNamed(
                            Routes.packageVideoPlayer,
                            pathParameters: {
                              'slug': widget.tutorialPackage.slug ?? '',
                            },
                            extra: {
                              'show_with_path': false,
                              'slug': widget.tutorialPackage.slug ?? '',
                              'video': widget.tutorialPackage.videos?.first,
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                width: 94,
                                height: 56,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => const ShimmerContainer(
                                  width: 94,
                                  height: 56,
                                  radius: 4,
                                ),
                                imageUrl: widget.tutorialPackage.videos?.first
                                        .thumbnail_url ??
                                    '',
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
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tutorialPackage.title ?? '',
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
                                    widget.tutorialPackage.videos?.first
                                            .duration ??
                                        '',
                                  ),
                                  style: Theme.of(context).textTheme.labelSmall,
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
                                      (widget.tutorialPackage.views_count ?? 0)
                                          .toString()),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (context.select<DownloadVideoBloc, bool>((bloc) =>
                        bloc.existVideoInCache(
                            widget.tutorialPackage.videos?.first.id ?? -1,
                            widget.tutorialPackage.slug ?? '')))
                      Container(
                        height: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: ColorPalette.of(context).border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SvgPicture.asset(
                          Assets.downloadedIc,
                        ),
                      ),
                    if (context.select<DownloadVideoBloc, bool>((bloc) =>
                        bloc.downloading &&
                        bloc.selectedVideoIdForDownload ==
                            widget.tutorialPackage.videos?.first.id))
                      InkWell(
                        onTap: () {
                          if (Provider.of<DownloadVideoBloc>(context,
                                      listen: false)
                                  .selectedVideoIdForDownload ==
                              widget.tutorialPackage.videos?.first.id) {
                            showAnimatedDialog(
                              context: context,
                              curve: Curves.easeIn,
                              animationType: DialogTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                              builder: (ctx) => ChangeNotifierProvider.value(
                                value: Provider.of<PackageDetailsBloc>(context,
                                    listen: false),
                                child: DownloadDialog(
                                  video: widget.tutorialPackage.videos?.first ??
                                      Video(),
                                  slug: widget.tutorialPackage.slug ?? '',
                                  type: 'tutorial',
                                  title: widget.tutorialPackage.title ?? '',
                                  updated_at: Provider.of<PackageDetailsBloc>(
                                              context,
                                              listen: false)
                                          .packageDetails
                                          ?.updated_at ??
                                      '',
                                  currentIndex: Provider.of<DownloadVideoBloc>(
                                          context,
                                          listen: false)
                                      .selectedVideoIndexForDownload,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: ColorPalette.of(context).border,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularPercentIndicator(
                              radius: 8.0,
                              lineWidth: 1.5,
                              percent:
                                  context.select<DownloadVideoBloc, double>(
                                      (bloc) => (bloc.percentage) / 100),
                              progressColor: ColorPalette.of(context).primary,
                            ),
                          ),
                        ),
                      ),
                    PackageDetailsMenu(
                      index: widget.index,
                      tutorialPackage: widget.tutorialPackage,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: StyledText(
                text: widget.tutorialPackage.description ?? '',
                tags: {
                  'p': StyledTextTag(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.of(context).textPrimary,
                      fontSize: 14,
                    ),
                  ),
                },
                maxLines: showMore ? 1000 : 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 12, top: 4),
              child: InkWell(
                onTap: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                child: Text(
                  showMore ? 'close'.tr() : 'show_more'.tr(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: ColorPalette.of(context).primary,
                      ),
                ),
              ),
            ),
          ],
        ),
      );
}
