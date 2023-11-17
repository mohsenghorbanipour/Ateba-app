import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/attachment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGalleryPage extends StatefulWidget {
  const PhotoGalleryPage({
    required this.attachment,
    super.key,
  });

  final Attachment attachment;

  @override
  State<PhotoGalleryPage> createState() => _PhotoGalleryPageState();
}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  PageController pageController = PageController();
  int selectedIndex = 0;
  bool show = true;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          //!test
          if (details.velocity.pixelsPerSecond.dy > 1000) {
            Navigator.of(context).pop();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    scaleStateChangedCallback: (value) {
                      //!test
                      setState(() {
                        if (value == PhotoViewScaleState.zoomedIn) {
                          // bottomPosition = -65.0;
                          show = false;
                        } else {
                          // bottomPosition = 0.0;
                          show = true;
                        }
                      });
                    },
                    onPageChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                        // bottomPosition = 0.0;
                        show = true;
                      });
                    },
                    loadingBuilder: (context, event) => Container(),
                    pageController: pageController,
                    builder: (BuildContext context, int index) =>
                        PhotoViewGalleryPageOptions(
                      onTapUp: (context, details, controllerValue) {
                        if (details.localPosition.dx < screenWidth * 40 / 100) {
                          if (selectedIndex !=
                              (widget.attachment.files?.length ?? 0) - 1) {
                            setState(() {
                              selectedIndex++;
                              pageController.animateToPage(selectedIndex,
                                  curve: Curves.linear,
                                  duration: const Duration(milliseconds: 250));
                            });
                          }
                        } else if (details.localPosition.dx >
                            screenWidth * 60 / 100) {
                          if (selectedIndex != 0) {
                            setState(() {
                              selectedIndex--;
                              pageController.animateToPage(selectedIndex,
                                  curve: Curves.linear,
                                  duration: const Duration(milliseconds: 250));
                            });
                          }
                        }
                        // if(details.)
                      },
                      tightMode: true,
                      minScale: PhotoViewComputedScale.contained * 0.9,
                      maxScale: PhotoViewComputedScale.contained * 2,
                      basePosition: Alignment.center,
                      imageProvider: CachedNetworkImageProvider(
                        widget.attachment.files?[index].url ?? '',
                      ),
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                    ),
                    itemCount: widget.attachment.files?.length,
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.transparent),
                  ),
                  Positioned(
                    bottom: 16,
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: ColorPalette.of(context).background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: (widget.attachment.files?.length ?? 0)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorPalette.of(context).textPrimary,
                                ),
                            children: [
                              const TextSpan(text: ' / '),
                              TextSpan(
                                text: (selectedIndex + 1).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color:
                                            ColorPalette.of(context).primary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(right: 12, left: 12),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    if (selectedIndex != index) {
                      setState(() {
                        pageController.animateToPage(
                          index,
                          curve: Curves.linear,
                          duration: const Duration(milliseconds: 250),
                        );
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 96,
                    height: 96,
                    margin: const EdgeInsets.only(left: 10.0, right: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorPalette.of(context).background,
                      border: selectedIndex == index
                          ? Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        width: 72,
                        height: 72,
                        imageUrl: widget.attachment.files?[index].url ?? '',
                      ),
                    ),
                  ),
                ),
                itemCount: (widget.attachment.files?.length ?? 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
