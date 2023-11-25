import 'dart:math';

import 'package:ateba_app/core/components/loading_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/video%20player/bloc/video_player_bloc.dart';
import 'package:ateba_app/modules/video%20player/ui/modals/video_chapter_modal.dart';
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
    super.key,
  });

  final String videoId;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => VideoPlayerBloc(videoId, data['video'])
          ..initialVideoPlayer(
            data['playFromOfflineGallery'] as bool
                ? data['path'] as String
                : (data['video'] as Video).playlist?.hls ?? '',
            playFromOfflineGallery: data['playFromOfflineGallery'] as bool,
            cacheQuality: data['playFromOfflineGallery'] as bool
                ? (data['video'] as Video).playlist?.download?.first.quality ??
                    ''
                : '',
          )
          ..setShowOption(),
        builder: (context, index) => GestureDetector(
          onTap: () {
            Provider.of<VideoPlayerBloc>(context, listen: false)
                .setShowOption();
          },
          child: Scaffold(
            backgroundColor: ColorPalette.light.textPrimary,
            body: Consumer<VideoPlayerBloc>(
              builder: (context, bloc, child) => (bloc.initialized)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!bloc.fullScreen)
                          const SizedBox(
                            height: 100,
                          ),
                        videoWidget(
                            RotatedBox(
                              quarterTurns: bloc.fullScreen ? 1 : 0,
                              child: AspectRatio(
                                aspectRatio: bloc.controller!.value.aspectRatio,
                                child: Stack(
                                  children: [
                                    VideoPlayer(
                                      bloc.controller!,
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                bloc.setShowOption();
                                              },
                                              onDoubleTap: () {
                                                bloc.controller?.seekTo(
                                                  Duration(
                                                    seconds: ((bloc.duration ??
                                                                0) -
                                                            (bloc.remained ??
                                                                0)) +
                                                        10,
                                                  ),
                                                );
                                                bloc.setShowArrowRight();
                                              },
                                              child: bloc.showArrowRight
                                                  ? Center(
                                                      child: Icon(
                                                        Icons
                                                            .double_arrow_rounded,
                                                        size: 28,
                                                        color: ColorPalette.of(
                                                                context)
                                                            .white,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                bloc.setShowOption();
                                              },
                                              onDoubleTap: () {
                                                bloc.controller?.seekTo(
                                                  Duration(
                                                      seconds: ((bloc.duration ??
                                                                  0) -
                                                              (bloc.remained ??
                                                                  0)) -
                                                          10),
                                                );
                                                bloc.setShowArrowLeft();
                                              },
                                              child: bloc.showArrowLeft
                                                  ? Center(
                                                      child: Transform.rotate(
                                                        angle: math.pi * -1,
                                                        child: Icon(
                                                          Icons
                                                              .double_arrow_rounded,
                                                          size: 28,
                                                          color:
                                                              ColorPalette.of(
                                                                      context)
                                                                  .white,
                                                        ),
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (bloc.showOptions || !bloc.isPlaying)
                                      Align(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: () {
                                            bloc.playOrPauseVideo();
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
                                                color: ColorPalette.of(context)
                                                    .white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (bloc.showOptions || !bloc.isPlaying)
                                      Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: double.infinity,
                                          height: 80,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        bloc.fullScreen =
                                                            !bloc.fullScreen;
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .fullscreen_rounded,
                                                        size: 32,
                                                        color: ColorPalette.of(
                                                                context)
                                                            .white,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        if (bloc.chapters
                                                            .isNotEmpty)
                                                          InkWell(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                builder: (ctx) =>
                                                                    ChangeNotifierProvider
                                                                        .value(
                                                                  value: Provider.of<
                                                                          VideoPlayerBloc>(
                                                                      context,
                                                                      listen:
                                                                          false),
                                                                  child:
                                                                      VideoChapterModal(
                                                                    imageUrl:
                                                                        (data['video'] as Video).thumbnail_url ??
                                                                            '',
                                                                    chapters: bloc
                                                                        .chapters,
                                                                    isRotate: bloc.fullScreen,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Transform
                                                                    .rotate(
                                                                  angle:
                                                                      (math.pi *
                                                                          -1),
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_forward_ios_rounded,
                                                                    size: 10,
                                                                    color: ColorPalette.of(
                                                                            context)
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right: 2),
                                                                  child: Text(
                                                                    'chapters'
                                                                        .tr(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelMedium
                                                                        ?.copyWith(
                                                                            color:
                                                                                ColorPalette.of(context).white),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 2,
                                                                  height: 2,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: ColorPalette.of(
                                                                            context)
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        if ((bloc.sec
                                                                    ?.isNotEmpty ??
                                                                false) &&
                                                            (bloc.mins
                                                                    ?.isNotEmpty ??
                                                                false) &&
                                                            (bloc.hour
                                                                    ?.isNotEmpty ??
                                                                false))
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 6),
                                                            child: Text(
                                                              TextInputFormatters
                                                                  .toPersianNumber(
                                                                      '${bloc.hour == '00' ? '' : '${bloc.hour ?? ''}:'}${bloc.mins ?? ''}:${bloc.sec ?? ''}'),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelMedium
                                                                  ?.copyWith(
                                                                      color: ColorPalette.of(
                                                                              context)
                                                                          .white),
                                                            ),
                                                          ),
                                                        Text(
                                                          '/${TextInputFormatters.getDuration(
                                                            (data['video']
                                                                        as Video)
                                                                    .duration ??
                                                                '',
                                                          )}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelMedium
                                                              ?.copyWith(
                                                                  color: ColorPalette.of(
                                                                          context)
                                                                      .white
                                                                      .withOpacity(
                                                                          0.7)),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Directionality(
                                                textDirection:
                                                    ui.TextDirection.ltr,
                                                child: SliderTheme(
                                                  data: const SliderThemeData(
                                                    trackHeight: 2,
                                                  ),
                                                  child: Slider(
                                                    value: max(
                                                        0,
                                                        min(bloc.progress * 100,
                                                            100)),
                                                    min: 0,
                                                    max: 100,
                                                    divisions: 100,
                                                    onChanged: (val) {
                                                      bloc.setProgress(val);
                                                    },
                                                    label: bloc.controller
                                                        ?.value.position
                                                        .toString()
                                                        .split('.')[0],
                                                    onChangeStart: (val) {
                                                      bloc.controller?.pause();
                                                    },
                                                    onChangeEnd: (val) {
                                                      final duration = bloc
                                                          .controller
                                                          ?.value
                                                          .duration;
                                                      if (duration != null) {
                                                        var newValue = max(
                                                            0,
                                                            min(val, 99) *
                                                                0.01);
                                                        var milis = (duration
                                                                    .inMilliseconds *
                                                                newValue)
                                                            .toInt();
                                                        bloc.controller?.seekTo(
                                                          Duration(
                                                              milliseconds:
                                                                  milis),
                                                        );
                                                        bloc.controller?.play();
                                                      }
                                                    },
                                                    thumbColor:
                                                        ColorPalette.of(context)
                                                            .primary,
                                                    activeColor:
                                                        ColorPalette.of(context)
                                                            .primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (bloc.showOptions || !bloc.isPlaying)
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
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder: (ctx) =>
                                                          ChangeNotifierProvider
                                                              .value(
                                                        value: Provider.of<
                                                                VideoPlayerBloc>(
                                                            context,
                                                            listen: false),
                                                        builder: (ctx, child) =>
                                                            VideoPlayerSettingModal(
                                                          videoQualities: (data[
                                                                          'video']
                                                                      as Video)
                                                                  .playlist
                                                                  ?.download ??
                                                              [],
                                                          hlsUrl: (data['video']
                                                                      as Video)
                                                                  .hls_url ??
                                                              '',
                                                          cacheVideo: data[
                                                                  'playFromOfflineGallery']
                                                              as bool,
                                                          isRotate:
                                                              bloc.fullScreen,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    width: 32,
                                                    height: 32,
                                                    child: Icon(
                                                      Icons.settings,
                                                      color: ColorPalette.of(
                                                              context)
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
                            bloc.fullScreen),
                        if (!bloc.fullScreen)
                          const SizedBox(
                            height: 100,
                            width: double.infinity,
                          )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingComponent(
                          color: ColorPalette.of(context).primary,
                          size: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'loading_video'.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      );

  Widget videoWidget(Widget child, bool isExpand) =>
      isExpand ? Expanded(child: child) : child;
}
