import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/resources/models/cache_video_model.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video_link.dart';
import 'package:ateba_app/modules/tutorial%20details/ui/widgets/download_video_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DownloadDialog extends StatefulWidget {
  const DownloadDialog({
    required this.video,
    required this.slug,
    required this.type,
    required this.title,
    required this.updated_at,
    this.currentIndex,
    super.key,
  });

  final Video video;
  final String slug;
  final String type;
  final String title;
  final String updated_at;
  final int? currentIndex;

  @override
  State<DownloadDialog> createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  @override
  void initState() {
    selectedIndexForDownload = widget.currentIndex;
    super.initState();
  }

  int? selectedIndexForDownload;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (!Provider.of<DownloadVideoBloc>(context, listen: false)
              .downloading) {
            Provider.of<DownloadVideoBloc>(context, listen: false)
                .selectedVideoIdForDownload = null;
          }
          return true;
        },
        child: Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        'download_with'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (!Provider.of<DownloadVideoBloc>(context,
                                listen: false)
                            .downloading) {
                          Provider.of<DownloadVideoBloc>(context, listen: false)
                              .selectedVideoIdForDownload = null;
                        }
                        context.pop();
                      },
                      icon: SvgPicture.asset(
                        Assets.closeIc,
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                  itemCount: widget.video.playlist?.download?.length ?? 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 16,
                  ),
                  itemBuilder: (_, index) => DownloadVideoTile(
                    videoLink:
                        widget.video.playlist?.download?[index] ?? VideoLink(),
                    onTap: () {
                      setState(() {
                        selectedIndexForDownload = index;
                      });
                    },
                    selected: selectedIndexForDownload == index,
                  ),
                ),
                // if (selectedIndexForDownload != null)
                ButtonComponent(
                  onPressed: () {
                    if (selectedIndexForDownload != null) {
                      if (Provider.of<DownloadVideoBloc>(context, listen: false)
                          .downloading) {
                        Provider.of<DownloadVideoBloc>(context, listen: false)
                            .cancelDownload();
                      } else {
                        Provider.of<DownloadVideoBloc>(context, listen: false)
                                .selectedVideoIndexForDownload =
                            selectedIndexForDownload;
                        Provider.of<DownloadVideoBloc>(context, listen: false)
                            .selectedVideoIdForDownload = widget.video.id ?? -1;
                        Provider.of<DownloadVideoBloc>(context, listen: false)
                            .downloadVideoAndSave(
                          CacheVideoModel(
                            url: widget
                                    .video
                                    .playlist
                                    ?.download?[selectedIndexForDownload!]
                                    .url ??
                                '',
                            qality: widget
                                    .video
                                    .playlist
                                    ?.download?[selectedIndexForDownload!]
                                    .quality ??
                                '',
                            size: widget
                                    .video
                                    .playlist
                                    ?.download?[selectedIndexForDownload!]
                                    .size ??
                                '',
                            slug: widget.slug,
                            id: widget.video.id,
                            duration: widget.video.duration ?? '',
                            title: widget.title,
                            updated_at: widget.updated_at,
                            thumbnail_url: widget.video.thumbnail_url,
                          ),
                        );
                      }
                    }
                  },
                  height: 36,
                  margin: const EdgeInsets.all(16),
                  color: Colors.transparent,
                  borderSide: BorderSide(
                      width: 1,
                      color: selectedIndexForDownload == null
                          ? ColorPalette.of(context)
                              .textPrimary
                              .withOpacity(0.4)
                          : context.select<DownloadVideoBloc, bool>(
                                  (bloc) => bloc.downloading)
                              ? ColorPalette.of(context).error
                              : ColorPalette.of(context).primary),
                  child: Text(
                    context.select<DownloadVideoBloc, bool>(
                            (bloc) => bloc.downloading)
                        ? 'cancel_download'.tr()
                        : 'add_to_gallery_offline'.tr(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: selectedIndexForDownload == null
                            ? ColorPalette.of(context)
                                .textPrimary
                                .withOpacity(0.6)
                            : null),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
