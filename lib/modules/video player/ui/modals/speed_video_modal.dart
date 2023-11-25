import 'package:ateba_app/core/components/modal_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/video%20player/bloc/video_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpeedVideoModal extends StatelessWidget {
  SpeedVideoModal({
    this.isRotate = false,
    super.key,
  });

  final bool isRotate;

  final List<double> speeds = [
    1.0,
    1.5,
    2.0,
    3.0,
  ];

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: isRotate ? 1 : 0,
        child: Modal(
          margin: const EdgeInsets.all(8),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Column(
            children: [
              ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(12),
                itemCount: speeds.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Provider.of<VideoPlayerBloc>(context, listen: false)
                        .controller
                        ?.setPlaybackSpeed(
                          speeds[index],
                        );
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Provider.of<VideoPlayerBloc>(context,
                                      listen: false)
                                  .controller
                                  ?.value
                                  .playbackSpeed ==
                              speeds[index]
                          ? ColorPalette.of(context).primary.withOpacity(0.4)
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Text(
                          speeds[index].toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
