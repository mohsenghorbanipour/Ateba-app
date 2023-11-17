import 'package:ateba_app/core/components/modal_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/date_helper.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_chapter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoChapterModal extends StatelessWidget {
  const VideoChapterModal({
    required this.imageUrl,
    required this.chapters,
    super.key,
  });

  final String imageUrl;
  final List<VideoChapter> chapters;

  @override
  Widget build(BuildContext context) => Modal(
        backgroundColor: ColorPalette.dark.background,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: 4, //chapters.length,
            separatorBuilder: (_, __) => const SizedBox(
              height: 9,
            ),
            itemBuilder: (context, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 100,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapters[index].title ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorPalette.dark.textPrimary,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          DateHelper.getRealTimeVideo(
                            chapters[index].beginning_second ?? 0,
                          ),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorPalette.dark.textPrimary
                                        .withOpacity(0.7),
                                  ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
