import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/widgets/no_active_subscription_dialog.dart';
import 'package:ateba_app/modules/tutorial%20details/bloc/tutorial_details_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TutorialVideoWidget extends StatelessWidget {
  const TutorialVideoWidget({
    required this.videos,
    required this.coverUrl,
    required this.slug,
    super.key,
  });

  final dynamic videos;
  final String coverUrl;
  final String slug;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CarouselSlider.builder(
            itemCount: videos is int ? 1 : (videos as List).length,
            options: CarouselOptions(
              autoPlay: false,
              height: (MediaQuery.of(context).size.width * 0.9) / 1080 * 500,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                Provider.of<TutorialDetaialsBloc>(context, listen: false)
                    .selectedVideoIndex = index;
              },
            ),
            itemBuilder: (context, index, i) => InkWell(
              onTap: () async {
                if ((videos is int) && (videos == 402)) {
                  showAnimatedDialog(
                    context: context,
                    curve: Curves.easeIn,
                    animationType: DialogTransitionType.fade,
                    duration: const Duration(milliseconds: 300),
                    builder: (context) => NoActiveSubscriptionDialog(
                      slug: slug,
                    ),
                  );
                } else {
                  context.goNamed(
                    Routes.videoPlayer,
                    pathParameters: {
                      'id': Provider.of<TutorialDetaialsBloc>(context,
                                  listen: false)
                              .getVideo()
                              ?.id
                              .toString() ??
                          '',
                      'slug': slug,
                    },
                    extra: {
                      'playFromOfflineGallery': false,
                      'slug': slug,
                      'video': Provider.of<TutorialDetaialsBloc>(context,
                              listen: false)
                          .getVideo(),
                    },
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      videos is int
                          ? coverUrl
                          : Provider.of<TutorialDetaialsBloc>(context,
                                      listen: false)
                                  .getVideo()
                                  ?.thumbnail_url ??
                              '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.of(context).error,
                    ),
                    child: Center(
                      child: Icon(
                        videos is int && videos == 402
                            ? Icons.lock
                            : Icons.play_arrow_rounded,
                        color: ColorPalette.light.background,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (videos is List<dynamic> && (videos as List<dynamic>).length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  videos is int
                      ? 0
                      : (videos as List<dynamic>).length, //videos.length,
                  (index) => Container(
                    width: index ==
                            context.select<TutorialDetaialsBloc, int>(
                                (bloc) => bloc.selectedVideoIndex ?? -1)
                        ? 30
                        : 18,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.select<TutorialDetaialsBloc, int>(
                                  (bloc) => bloc.selectedVideoIndex ?? -1) ==
                              index
                          ? ColorPalette.of(context).error
                          : ColorPalette.of(context)
                              .textPrimary
                              .withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            )
        ],
      );
}
