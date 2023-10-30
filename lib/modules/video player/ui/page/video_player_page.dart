// import 'package:ateba_app/core/theme/style/color_palatte.dart';
// import 'package:ateba_app/core/utils/logger_helper.dart';
// import 'package:ateba_app/modules/video%20player/ui/widgets/video_player_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerPage extends StatefulWidget {
//   const VideoPlayerPage({
//     required this.data,
//     super.key,
//   });

//   final Map<String, dynamic> data;

//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }

// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   bool fullscreen = false;

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         // appBar: (widget.data['is_hls_link'] && fullscreen == false)
//         //     ? AppBar(
//         //         backgroundColor: Colors.blue,
//         //         title: const Image(
//         //           image: AssetImage('image/yoyo_logo.png'),
//         //           fit: BoxFit.fitHeight,
//         //           height: 50,
//         //         ),
//         //         centerTitle: true,
//         //         leading: IconButton(
//         //           icon: const Icon(Icons.arrow_back),
//         //           onPressed: () {
//         //             Navigator.pop(context);
//         //           },
//         //         ),
//         //       )
//         //     : null,
//         body: widget.data['is_hls_link']
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   YoYoPlayer(
//                     url: widget.data['hls_link'],
//                     aspectRatio: 16 / 9,
//                     allowCacheFile: true,
//                     videoStyle: VideoStyle(
//                       qualityStyle: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w600,
//                         color: ColorPalette.of(context).white,
//                       ),
//                       forwardAndBackwardBtSize: 30.0,
//                       playButtonIconSize: 40.0,
//                       playIcon: Icon(
//                         Icons.play_arrow_rounded,
//                         size: 40.0,
//                         color: ColorPalette.of(context).white,
//                       ),
//                       pauseIcon: Icon(
//                         Icons.pause,
//                         size: 40.0,
//                         color: ColorPalette.of(context).white,
//                       ),
//                       videoQualityPadding: const EdgeInsets.all(5.0),
//                       enableSystemOrientationsOverride: false,
//                     ),
//                     videoLoadingStyle: const VideoLoadingStyle(
//                       loading: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Image(
//                               image: AssetImage('image/yoyo_logo.png'),
//                               fit: BoxFit.fitHeight,
//                               height: 50,
//                             ),
//                             SizedBox(height: 16.0),
//                             Text("Loading video..."),
//                           ],
//                         ),
//                       ),
//                     ),
//                     autoPlayVideoAfterInit: true,
                    
//                     // onRewind: (val) {
//                     //   LoggerHelper.logger.i('kirrr');
//                     // },
//                     onFullScreen: (value) {
//                       // setState(() {
//                       //   if (fullscreen != value) {
//                       //     fullscreen = value;
//                       //   }
//                       // });
//                     },
//                   ),
//                 ],
//               )
//             : VideoPlayerWidget(
//                 controller: widget.data['controller'],
//                 videoTitle: widget.data['title'],
//               ),
//       );
// }
