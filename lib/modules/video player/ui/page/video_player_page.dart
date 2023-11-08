// ignore_for_file: use_build_context_synchronously, division_optimization

import 'dart:io';

import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/video%20player/bloc/video_player_bloc.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_chapter.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui;

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({
    required this.data,
    super.key,
  });

  final Map<String, dynamic> data;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool fullscreen = false;
  VideoPlayerController? controller;
  ChewieController? chewieController;

  String selectedQuality = 'auto';

  @override
  void initState() {
    initializePlayer();

    super.initState();
  }

  Future<void> initializePlayer() async {
    controller = (widget.data['show_with_path'] as bool)
        ? VideoPlayerController.file(
            File(
              widget.data['path'] as String,
            ),
          )
        : VideoPlayerController.networkUrl(
            Uri.parse(
              (widget.data['video'] as Video).hls_url ?? '',
            ),
          );
    await controller?.initialize();
    chewieController = ChewieController(
      videoPlayerController: controller!,
      aspectRatio: 3 / 2,
      autoInitialize: true,
      autoPlay: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
      placeholder: Container(
        color: Colors.grey,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) =>
            VideoPlayerBloc((widget.data['video'] as Video).id ?? -1),
        lazy: false,
        builder: (context, child) => Scaffold(
          body: Stack(
            children: [
              if (chewieController != null)
                Chewie(
                  controller: chewieController!,
                ),
              if (chewieController == null)
                Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: ColorPalette.of(context).primary,
                  ),
                ),
              if (!widget.data['show_with_path'])
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                              margin: const EdgeInsets.all(12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorPalette.of(context).background,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  (((widget.data['video'] as Video)
                                              .download_links
                                              ?.length ??
                                          0) +
                                      1),
                                  (index) => InkWell(
                                    onTap: () {
                                      controller?.pause();
                                      if ((((widget.data['video'] as Video)
                                                  .download_links
                                                  ?.length ??
                                              0)) ==
                                          index) {
                                        controller = null;
                                        chewieController = null;
                                        setState(() {});
                                        controller =
                                            VideoPlayerController.networkUrl(
                                                Uri.parse((widget.data['video']
                                                            as Video)
                                                        .hls_url ??
                                                    ''));
                                        chewieController = ChewieController(
                                          videoPlayerController: controller!,
                                          aspectRatio: 3 / 2,
                                          autoInitialize: true,
                                          autoPlay: true,
                                          deviceOrientationsAfterFullScreen: [
                                            DeviceOrientation.portraitUp
                                          ],
                                          materialProgressColors:
                                              ChewieProgressColors(
                                            playedColor: Colors.purple,
                                            handleColor: Colors.purple,
                                            backgroundColor: Colors.grey,
                                            bufferedColor: Colors.purple,
                                          ),
                                          placeholder: Container(
                                            color: Colors.grey,
                                          ),
                                        );
                                        controller?.initialize();
                                        setState(() {
                                          selectedQuality = 'auto';
                                        });
                                      } else {
                                        controller = null;
                                        chewieController = null;
                                        setState(() {});
                                        controller =
                                            VideoPlayerController.networkUrl(
                                          Uri.parse(
                                              (widget.data['video'] as Video)
                                                      .download_links?[index]
                                                      .url ??
                                                  ''),
                                        );
                                        chewieController = ChewieController(
                                          videoPlayerController: controller!,
                                          aspectRatio: 3 / 2,
                                          autoInitialize: true,
                                          autoPlay: true,
                                          deviceOrientationsAfterFullScreen: [
                                            DeviceOrientation.portraitUp
                                          ],
                                          materialProgressColors:
                                              ChewieProgressColors(
                                            playedColor: Colors.purple,
                                            handleColor: Colors.purple,
                                            backgroundColor: Colors.grey,
                                            bufferedColor: Colors.purple,
                                          ),
                                          placeholder: Container(
                                            color: Colors.grey,
                                          ),
                                        );
                                        selectedQuality =
                                            (widget.data['video'] as Video)
                                                    .download_links?[index]
                                                    .quality ??
                                                '';
                                        setState(() {});
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index ==
                                                  (((widget.data['video']
                                                              as Video)
                                                          .download_links
                                                          ?.length ??
                                                      0))
                                              ? selectedQuality == 'auto'
                                                  ? ColorPalette.of(context)
                                                      .primary
                                                      .withOpacity(0.5)
                                                  : Colors.transparent
                                              : selectedQuality ==
                                                      (widget.data['video']
                                                              as Video)
                                                          .download_links?[
                                                              index]
                                                          .quality
                                                  ? ColorPalette.of(context)
                                                      .primary
                                                      .withOpacity(0.5)
                                                  : Colors.transparent,
                                          borderRadius: index == 0
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12))
                                              : index ==
                                                      (((widget.data['video']
                                                                  as Video)
                                                              .download_links
                                                              ?.length ??
                                                          0))
                                                  ? const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    )
                                                  : null),
                                      width: double.infinity,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          index ==
                                                  (((widget.data['video']
                                                              as Video)
                                                          .download_links
                                                          ?.length ??
                                                      0))
                                              ? 'auto'
                                              : (widget.data['video'] as Video)
                                                      .download_links?[index]
                                                      .quality ??
                                                  '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 30,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorPalette.of(context)
                                .textPrimary
                                .withOpacity(0.6),
                          ),
                          child: Center(
                            child: Text(
                              selectedQuality,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: ColorPalette.of(context).white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (context.select<VideoPlayerBloc, bool>(
                  (bloc) => !bloc.loading && bloc.chapters.isNotEmpty))
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    margin:
                        const EdgeInsets.only(bottom: 64, left: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color:
                          ColorPalette.of(context).textPrimary.withOpacity(0.6),
                    ),
                    child: Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Selector<VideoPlayerBloc, List<VideoChapter>>(
                        selector: (context, bloc) => bloc.chapters,
                        builder: (context, chapters, child) =>
                            ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: chapters.length + 1,
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  chapters[index].title ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: ColorPalette.of(context).white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (_, index) => index == 0
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    Expanded(
                                      child: VerticalDivider(
                                        width: 1,
                                        color: ColorPalette.of(context).white,
                                      ),
                                    ),
                                    Text(
                                      ((chapters[index - 1].beginning_second ??
                                                  0) /
                                              60)
                                          .toInt()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                              color: ColorPalette.of(context)
                                                  .white),
                                    ),
                                    Expanded(
                                      child: VerticalDivider(
                                        width: 1,
                                        color: ColorPalette.of(context).white,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      );

  @override
  void dispose() {
    controller?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
