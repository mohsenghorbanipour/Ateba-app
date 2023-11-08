import 'package:ateba_app/core/components/loading_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/video%20player/bloc/video_player_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

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
        builder: (context, index) => Scaffold(
          body: Consumer<VideoPlayerBloc>(
            builder: (context, bloc, child) => (bloc.initialized)
                ? VideoPlayer(
                    bloc.controller!,
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
      );
}
