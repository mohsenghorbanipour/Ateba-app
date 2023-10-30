import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/components/toast_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/widgets/no_active_subscription_dialog.dart';
import 'package:ateba_app/modules/tutorial%20details/bloc/tutorial_details_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/dialogs/download_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class TutorialDownloadWidget extends StatelessWidget {
  const TutorialDownloadWidget({
    required this.slug,
    super.key,
  });

  final String slug;

  @override
  Widget build(BuildContext context) =>
      context.select<DownloadVideoBloc, String>(
                  (bloc) => bloc.selectedVideoHlsLinkForDownload ?? 'null') ==
              context.select<TutorialDetaialsBloc, String>((bloc) =>
                  bloc.tutorialDetaials?.videos is List<Video>
                      ? bloc.tutorialDetaials?.videos?.first.hls_url ?? ''
                      : '')
          ? Container(
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
                  percent: 0.5,
                  progressColor: ColorPalette.of(context).primary,
                ),
              ),
            )
          : InkWell(
              onTap: () {
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
                          (bloc) => bloc.existVideoInCache(slug, 'tutorial'))
                      ? Assets.downloadedIc
                      : Assets.downloadIc,
                ),
              ),
            );
}
