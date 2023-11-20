// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/components/modal_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video_link.dart';
import 'package:ateba_app/modules/video%20player/bloc/video_player_bloc.dart';
import 'package:ateba_app/modules/video%20player/ui/modals/select_quality_modal.dart';
import 'package:ateba_app/modules/video%20player/ui/modals/speed_video_modal.dart';
import 'package:ateba_app/modules/video%20player/ui/widgets/video_player_setting_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoPlayerSettingModal extends StatelessWidget {
  const VideoPlayerSettingModal({
    required this.videoQualities,
    required this.hlsUrl,
    this.cacheVideo = false,
    super.key,
  });

  final List<VideoLink> videoQualities;
  final String hlsUrl;
  final bool cacheVideo;

  @override
  Widget build(BuildContext context) => Modal(
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 65,
                height: 6,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                    color:
                        ColorPalette.of(context).textPrimary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6)),
              ),
              VideoPlayerSettingTile(
                icon: Icons.tune_rounded,
                title: 'quality'.tr(),
                onTap: () async {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => ChangeNotifierProvider.value(
                      value:
                          Provider.of<VideoPlayerBloc>(context, listen: false),
                      builder: (ctx, child) => SelectQualityModal(
                        videoQualities: videoQualities,
                        hlsUrl: hlsUrl,
                        cacheVideo: cacheVideo,
                      ),
                    ),
                  );
                },
                optionWidget: Row(
                  children: [
                    Text(
                      context.select<VideoPlayerBloc, String>(
                          (bloc) => bloc.selectedQuality),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorPalette.of(context)
                              .textPrimary
                              .withOpacity(0.8)),
                    ),
                    Icon(Icons.arrow_back_ios_new_rounded,
                        size: 12,
                        color: ColorPalette.of(context)
                            .textPrimary
                            .withOpacity(0.8))
                  ],
                ),
              ),
              VideoPlayerSettingTile(
                icon: Icons.speed,
                title: 'speed'.tr(),
                onTap: () async {
                  Navigator.of(context).pop();
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => ChangeNotifierProvider.value(
                      value:
                          Provider.of<VideoPlayerBloc>(context, listen: false),
                      builder: (ctx, child) => SpeedVideoModal(),
                    ),
                  );
                },
                optionWidget: Row(
                  children: [
                    Text(
                      context.select<VideoPlayerBloc, String>(
                        (bloc) =>
                            bloc.controller?.value.playbackSpeed.toString() ??
                            '',
                      ),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorPalette.of(context)
                              .textPrimary
                              .withOpacity(0.8)),
                    ),
                    Icon(Icons.arrow_back_ios_new_rounded,
                        size: 12,
                        color: ColorPalette.of(context)
                            .textPrimary
                            .withOpacity(0.8))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
