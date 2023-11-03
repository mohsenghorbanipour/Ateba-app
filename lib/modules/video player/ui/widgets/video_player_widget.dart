// // ignore_for_file: library_private_types_in_public_api

// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final VideoPlayerController controller;
//   final String videoTitle;

//   const VideoPlayerWidget({
//     Key? key,
//     required this.controller,
//     required this.videoTitle,
//   }) : super(key: key);

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     _chewieController = ChewieController(
//       videoPlayerController: widget.controller,
//       aspectRatio: 3 / 2,
//       autoInitialize: true,
//       autoPlay: true,
//       deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
//       materialProgressColors: ChewieProgressColors(
//         playedColor: Colors.purple,
//         handleColor: Colors.purple,
//         backgroundColor: Colors.grey,
//         bufferedColor: Colors.purple,
//       ),
//       placeholder: Container(
//         color: Colors.grey,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }

//   @override
//   void dispose() {
//     widget.controller.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
// }
