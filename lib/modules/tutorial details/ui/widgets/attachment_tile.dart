import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/launcher_helper.dart';
import 'package:ateba_app/modules/tutorial%20details/bloc/tutorial_details_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/attachment.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class AttachmentTile extends StatefulWidget {
  const AttachmentTile({
    required this.attachment,
    super.key,
  });

  final Attachment attachment;

  @override
  State<AttachmentTile> createState() => _AttachmentTileState();
}

class _AttachmentTileState extends State<AttachmentTile> {
  bool showDetails = false;

  bool isPlayAudio = false;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          InkWell(
            onTap: () {
              if (!(widget.attachment.is_singular ?? false)) {
                setState(() {
                  showDetails = !showDetails;
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    widget.attachment.title ?? '',
                  ),
                ),
                if (widget.attachment.is_singular ?? false)
                  InkWell(
                    onTap: () {
                      LauncherHelper.launch(widget.attachment.files?.first.url);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SvgPicture.asset(
                        Assets.visibilityIc,
                        width: 20,
                        color: ColorPalette.of(context).primary,
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: AnimatedRotation(
                      turns: showDetails ? 2 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        showDetails
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 24,
                      ),
                    ),
                  )
              ],
            ),
          ),
          if (showDetails)
            Column(
              children: [
                if (widget.attachment.type == AttachmentType.gallery.name)
                  SizedBox(
                    height: 62,
                    width: double.infinity,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.attachment.files?.length ?? 0,
                      separatorBuilder: (_, __) => const SizedBox(
                        width: 10,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          onTap: () {
                            context.goNamed(
                              Routes.photoGalleryPage,
                              pathParameters: {
                                'slug': Provider.of<TutorialDetaialsBloc>(
                                            context,
                                            listen: false)
                                        .tutorialDetaials
                                        ?.slug ??
                                    ''
                              },
                              extra: widget.attachment,
                            );
                          },
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.attachment.files?[index].url ?? '',
                            width: 94,
                            height: 62,
                            placeholder: (_, __) => const ShimmerContainer(
                              width: 94,
                              height: 62,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (widget.attachment.type == AttachmentType.voice.name)
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.attachment.files?.length ?? 0,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 8,
                    ),
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        if (isPlayAudio) {
                          Provider.of<TutorialDetaialsBloc>(context,
                                  listen: false)
                              .audioPlayer
                              .pause();
                        } else {
                          Provider.of<TutorialDetaialsBloc>(context,
                                  listen: false)
                              .audioPlayer
                              .play(
                                UrlSource(
                                  widget.attachment.files?[index].url ?? '',
                                ),
                              );
                        }
                        setState(() {
                          isPlayAudio = !isPlayAudio;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.attachment.files?[index].title ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Icon(
                            isPlayAudio
                                ? Icons.pause
                                : Icons.play_arrow_rounded,
                            size: 18,
                            color: ColorPalette.of(context)
                                .textPrimary
                                .withOpacity(0.6),
                          )
                        ],
                      ),
                    ),
                  ),
                if (widget.attachment.type == AttachmentType.pdf.name)
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.attachment.files?.length ?? 0,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 8,
                    ),
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        context.goNamed(
                          Routes.pdfViewPage,
                          pathParameters: {
                            'slug': Provider.of<TutorialDetaialsBloc>(context,
                                        listen: false)
                                    .tutorialDetaials
                                    ?.slug ??
                                '',
                          },
                          extra: widget.attachment.files?[index],
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.attachment.files?[index].title ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Icon(
                            Icons.picture_as_pdf_outlined,
                            size: 18,
                            color: ColorPalette.of(context)
                                .textPrimary
                                .withOpacity(0.6),
                          )
                        ],
                      ),
                    ),
                  ),
                if (widget.attachment.type == AttachmentType.video.name)
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.attachment.files?.length ?? 0,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 8,
                    ),
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        context.goNamed(
                          Routes.videoPlayer,
                          pathParameters: {
                            'id': Provider.of<TutorialDetaialsBloc>(context,
                                        listen: false)
                                    .getVideo()
                                    ?.id
                                    .toString() ??
                                '',
                            'slug': Provider.of<TutorialDetaialsBloc>(context,
                                        listen: false)
                                    .tutorialDetaials
                                    ?.slug ??
                                '',
                          },
                          extra: {
                            'playFromOfflineGallery': false,
                            'slug': Provider.of<TutorialDetaialsBloc>(context,
                                        listen: false)
                                    .tutorialDetaials
                                    ?.slug ??
                                '',
                            'video': Provider.of<TutorialDetaialsBloc>(context,
                                    listen: false)
                                .getVideo(),
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.attachment.files?[index].title ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SvgPicture.asset(
                            Assets.videoCircleIc,
                          )
                        ],
                      ),
                    ),
                  ),
                if (widget.attachment.type == AttachmentType.link.name)
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.attachment.files?.length ?? 0,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 8,
                    ),
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        LauncherHelper.launch(
                          widget.attachment.files?[index].url ?? '',
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.attachment.files?[index].title ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SvgPicture.asset(
                            Assets.downloadIc,
                            width: 16,
                            color: ColorPalette.of(context)
                                .textPrimary
                                .withOpacity(0.6),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            )
        ],
      );
}
