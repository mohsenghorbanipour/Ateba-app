import 'package:ateba_app/core/base/bloc/download_video_bloc.dart';
import 'package:ateba_app/core/resources/models/cache_video_model.dart';
import 'package:ateba_app/modules/bookmarks/data/models/bookmark.dart';
import 'package:ateba_app/modules/bookmarks/ui/widgets/bookmark_card.dart';
import 'package:ateba_app/modules/cart/data/models/link_to.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfflineGalleryWidget extends StatelessWidget {
  const OfflineGalleryWidget({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Consumer<DownloadVideoBloc>(
          builder: (context, bloc, child) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: bloc.videos.length,
            separatorBuilder: (_, __) => const SizedBox(
              height: 12,
            ),
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) => BookmarkCard(
              index: index,
              isGalleryOffline: true,
              bookmark: Bookmark(
                link_to: LinkTo(
                  type: 'tutorial',
                  slug: bloc.videos[index].slug,
                ),
                videoId: bloc.videos[index].id,
                thumbnail_url: bloc.videos[index].thumbnail_url,
                title: bloc.videos[index].title,
                video: bloc.videos[index].url,
                duration: bloc.videos[index].duration,
                updated_at: bloc.videos[index].updated_at,
                path: bloc.videos[index].path,
                quality: bloc.videos[index].qality,
              ),
            ),
          ),
        ),
      );
}
