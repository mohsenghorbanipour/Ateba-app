import 'package:ateba_app/modules/video%20player/ui/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({
    required this.controller,
    super.key,
  });

  final VideoPlayerController controller;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: VideoPlayerWidget(
          controller: widget.controller,
          videoTitle: '',
        ),
      );
}
