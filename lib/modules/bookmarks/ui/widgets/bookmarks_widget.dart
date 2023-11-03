import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:ateba_app/modules/bookmarks/data/models/bookmark.dart';
import 'package:ateba_app/modules/bookmarks/ui/widgets/bookmark_card.dart';
import 'package:ateba_app/modules/bookmarks/ui/widgets/bookmark_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarksWidget extends StatelessWidget {
  const BookmarksWidget({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            if (context.select<BookmarksBloc, bool>((bloc) => bloc.loading))
              Expanded(
                child: ListView.separated(
                  itemCount: 5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 12,
                  ),
                  itemBuilder: (context, index) => const BookmarkCardShimmer(),
                ),
              )
            else
              Expanded(
                child: Selector<BookmarksBloc, List<Bookmark>>(
                  selector: (context, bloc) => bloc.dataList,
                  builder: (context, dataList, child) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: dataList.length,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    itemBuilder: (context, index) => BookmarkCard(
                      bookmark: dataList[index],
                    ),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
