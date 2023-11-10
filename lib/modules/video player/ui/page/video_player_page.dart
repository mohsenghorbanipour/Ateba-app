import 'package:ateba_app/core/components/loading_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/video%20player/bloc/video_player_bloc.dart';
import 'package:ateba_app/modules/video%20player/ui/modals/video_player_setting_modal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({
    required this.videoId,
    required this.data,
    // required this.video,
    // this.pathFile,
    // this.playFromOfflineGallery = false,
    super.key,
  });

  final String videoId;
  final Map<String, dynamic> data;
  // final Video video;
  // final String? pathFile;
  // final bool playFromOfflineGallery;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => VideoPlayerBloc(videoId, data['video']),
        builder: (context, index) => RotatedBox(
          quarterTurns: 1,
          child: Scaffold(
            body: Consumer<VideoPlayerBloc>(
              builder: (context, bloc, child) => (bloc.initialized)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const SizedBox(
                        //   height: 100,
                        // ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: bloc.controller!.value.aspectRatio,
                            child: Stack(
                              children: [
                                VideoPlayer(
                                  bloc.controller!,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      if (bloc.isPlaying) {
                                        bloc.controller?.pause();
                                      } else {
                                        bloc.controller?.play();
                                      }
                                    },
                                    child: Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorPalette.of(context)
                                            .textPrimary
                                            .withOpacity(0.6),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          bloc.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow_rounded,
                                          size: 36,
                                          color: ColorPalette.of(context).white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            ColorPalette.of(context)
                                                .black
                                                .withOpacity(0.6),
                                            ColorPalette.of(context)
                                                .black
                                                .withOpacity(0.4),
                                            ColorPalette.of(context)
                                                .black
                                                .withOpacity(0.2),
                                            ColorPalette.of(context)
                                                .black
                                                .withOpacity(0.0)
                                          ],
                                          end: Alignment.topCenter,
                                          begin: Alignment.bottomCenter),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.fullscreen_rounded,
                                              size: 32,
                                              color: ColorPalette.of(context)
                                                  .white,
                                            ),
                                            Row(
                                              children: [
                                                Transform.rotate(
                                                  angle: (math.pi * -1),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 10,
                                                    color:
                                                        ColorPalette.of(context)
                                                            .white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 2),
                                                  child: Text(
                                                    'سر فصل ها',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                            color:
                                                                ColorPalette.of(
                                                                        context)
                                                                    .white),
                                                  ),
                                                ),
                                                Container(
                                                  width: 2,
                                                  height: 2,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorPalette.of(context)
                                                            .white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 4),
                                                  child: Text(
                                                    TextInputFormatters
                                                        .toPersianNumber(
                                                      '1:30:27/2:01:0.8',
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                            color: ColorPalette
                                                                    .of(context)
                                                                .white
                                                                .withOpacity(
                                                                    0.8)),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorPalette.of(context)
                                              .black
                                              .withOpacity(0.6),
                                          ColorPalette.of(context)
                                              .black
                                              .withOpacity(0.4),
                                          ColorPalette.of(context)
                                              .black
                                              .withOpacity(0.2),
                                          ColorPalette.of(context)
                                              .black
                                              .withOpacity(0.0)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) =>
                                                    const VideoPlayerSettingModal(),
                                              );
                                            },
                                            child: SizedBox(
                                              width: 32,
                                              height: 32,
                                              child: Icon(
                                                Icons.settings,
                                                color: ColorPalette.of(context)
                                                    .white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 100,
                        //   width: double.infinity,
                        //   child: Column(
                        //     children: [
                        //       Directionality(
                        //         textDirection: ui.TextDirection.ltr,
                        //         child: Slider(
                        //           value: 0.4,
                        //           onChanged: (val) {},
                        //           thumbColor: ColorPalette.of(context).primary,
                        //           activeColor: ColorPalette.of(context).primary,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    )
                  : Column(
                      children: [
                        LoadingComponent(
                          color: ColorPalette.of(context).primary,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'loading_video'.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      );
}
