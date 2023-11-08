import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/core/widgets/no_active_subscription_dialog.dart';
import 'package:ateba_app/modules/tutorial%20details/bloc/tutorial_details_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/dialogs/download_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class TutorialDownloadWidget extends StatelessWidget {
  const TutorialDownloadWidget({
    required this.slug,
    required this.video,
    super.key,
  });

  final String slug;
  final Video video;

  @override
  Widget build(BuildContext context) {
    return context.select<DownloadVideoBloc, int>(
                (bloc) => bloc.selectedVideoIdForDownload ?? -1) ==
            video.id
        ? InkWell(
            onTap: () {
              if (Provider.of<DownloadVideoBloc>(context, listen: false)
                      .selectedVideoIdForDownload ==
                  video.id) {
                
                showAnimatedDialog(
                  context: context,
                  curve: Curves.easeIn,
                  animationType: DialogTransitionType.fade,
                  duration: const Duration(milliseconds: 300),
                  builder: (ctx) => ChangeNotifierProvider.value(
                    value: Provider.of<TutorialDetaialsBloc>(context,
                        listen: false),
                    child: DownloadDialog(
                      video: video,
                      slug: slug,
                      type: 'tutorial',
                      title: Provider.of<TutorialDetaialsBloc>(context,
                                  listen: false)
                              .tutorialDetaials
                              ?.title ??
                          '',
                      updated_at: Provider.of<TutorialDetaialsBloc>(context,
                                  listen: false)
                              .tutorialDetaials
                              ?.updated_at ??
                          '',
                      currentIndex:
                          Provider.of<DownloadVideoBloc>(context, listen: false)
                              .selectedVideoIndexForDownload,
                    ),
                  ),
                );
              }
            },
            child: Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              margin: const EdgeInsets.only(right: 12),
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
                  percent: context.select<DownloadVideoBloc, double>(
                      (bloc) => (bloc.percentage) / 100),
                  progressColor: ColorPalette.of(context).primary,
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              if (Provider.of<DownloadVideoBloc>(context, listen: false)
                  .existVideoInCache(video.id ?? -1, slug)) {
                context.goNamed(
                  Routes.videoPlayer,
                  pathParameters: {
                    'slug': slug,
                  },
                  extra: {
                    'slug': slug,
                    'video': Provider.of<TutorialDetaialsBloc>(context,
                            listen: false)
                        .getVideo(),
                    'show_with_path': true,
                    'path':
                        Provider.of<DownloadVideoBloc>(context, listen: false)
                            .getPath((video.id ?? -1), slug),
                  },
                );
                return;
              }
              if (Provider.of<DownloadVideoBloc>(context, listen: false)
                      .downloading &&
                  Provider.of<DownloadVideoBloc>(context, listen: false)
                          .selectedVideoIdForDownload !=
                      video.id) {
                ToastComponent.show(
                  'anuther_video_is_downloading'.tr(),
                  type: ToastType.info,
                );
                return;
              }
              if (Provider.of<TutorialDetaialsBloc>(context, listen: false)
                      .tutorialDetaials
                      ?.videos is int &&
                  Provider.of<TutorialDetaialsBloc>(context, listen: false)
                          .tutorialDetaials
                          ?.videos ==
                      402) {
                showAnimatedDialog(
                  context: context,
                  curve: Curves.easeIn,
                  animationType: DialogTransitionType.fade,
                  duration: const Duration(milliseconds: 300),
                  builder: (context) => NoActiveSubscriptionDialog(
                    slug: slug,
                  ),
                );
              } else if (Provider.of<DownloadVideoBloc>(context, listen: false)
                  .existVideoInCache(video.id ?? -1, slug)) {
                return;
              } else {
                  showAnimatedDialog(
                    context: context,
                    curve: Curves.easeIn,
                    animationType: DialogTransitionType.fade,
                    duration: const Duration(milliseconds: 300),
                    builder: (ctx) => ChangeNotifierProvider.value(
                      value: Provider.of<TutorialDetaialsBloc>(context,
                          listen: false),
                      child: DownloadDialog(
                        video: video,
                        slug: slug,
                        type: 'tutorial',
                        title: Provider.of<TutorialDetaialsBloc>(context,
                                    listen: false)
                                .tutorialDetaials
                                ?.title ??
                            '',
                        updated_at: Provider.of<TutorialDetaialsBloc>(context,
                                    listen: false)
                                .tutorialDetaials
                                ?.updated_at ??
                            '',
                      ),
                    ),
                  );
              }
            },
            child: Container(
              height: 24,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).border,
                borderRadius: BorderRadius.circular(4),
              ),
              child: SvgPicture.asset(
                context.select<DownloadVideoBloc, bool>(
                        (bloc) => bloc.existVideoInCache(video.id ?? -1, slug))
                    ? Assets.downloadedIc
                    : Assets.downloadIc,
              ),
            ),
          );
  }
}
