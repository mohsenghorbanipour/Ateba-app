import 'package:ateba_app/core/components/modal_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video_link.dart';
import 'package:ateba_app/modules/video%20player/bloc/video_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectQualityModal extends StatelessWidget {
  const SelectQualityModal({
    required this.videoQualities,
    required this.hlsUrl,
    super.key,
  });

  final List<VideoLink> videoQualities;
  final String hlsUrl;

  @override
  Widget build(BuildContext context) => Modal(
        child: Column(
          children: [
            ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(12),
              itemCount: videoQualities.length + 1,
              shrinkWrap: true,
              itemBuilder: (context, index) => index == videoQualities.length
                  ? InkWell(
                      onTap: () {
                        if (Provider.of<VideoPlayerBloc>(context, listen: false)
                                .selectedQuality !=
                            'auto') {
                          Provider.of<VideoPlayerBloc>(context, listen: false)
                              .changeVideoQuality(hlsUrl, 'auto');
                        }
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
                                      .selectedQuality ==
                                  'auto'
                              ? ColorPalette.of(context)
                                  .primary
                                  .withOpacity(0.4)
                              : Colors.transparent,
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'auto',
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        if (Provider.of<VideoPlayerBloc>(context, listen: false)
                                .selectedQuality !=
                            videoQualities[index].quality) {
                          Provider.of<VideoPlayerBloc>(context, listen: false)
                              .changeVideoQuality(
                                  videoQualities[index].url ?? '',
                                  videoQualities[index].quality ?? '');
                        }
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
                                      .selectedQuality ==
                                  videoQualities[index].quality
                              ? ColorPalette.of(context)
                                  .primary
                                  .withOpacity(0.4)
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Text(
                              videoQualities[index].quality ?? '',
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
}
