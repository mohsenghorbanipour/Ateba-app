import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:ateba_app/modules/bookmarks/data/models/bookmark.dart';
import 'package:ateba_app/modules/bookmarks/ui/widgets/bookmark_card.dart';
import 'package:ateba_app/modules/bookmarks/ui/widgets/bookmark_card_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductsWidget extends StatelessWidget {
  const MyProductsWidget({super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                color: ColorPalette.of(context).darkSilver,
                child: Theme(
                  data: ThemeData(useMaterial3: false),
                  child: TabBar(
                    onTap: (index) {
                      if (index == 0) {
                        Provider.of<BookmarksBloc>(context, listen: false)
                            .loadMyProduct(
                          type: 'course',
                        );
                      } else {
                        Provider.of<BookmarksBloc>(context, listen: false)
                            .loadMyProduct(
                          type: 'package',
                        );
                      }
                    },
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: ColorPalette.of(context).primary,
                    tabs: [
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'courses'.tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(
                              height: 4,
                            )
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'packages'.tr(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(
                              height: 4,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (context.select<BookmarksBloc, bool>((bloc) => bloc.loading))
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 12,
                    ),
                    itemBuilder: (context, index) =>
                        const BookmarkCardShimmer(),
                  ),
                )
              else
                Expanded(
                  child: Selector<BookmarksBloc, List<Bookmark>>(
                    selector: (context, bloc) => bloc.dataList,
                    builder: (context, dataList, child) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                      itemCount: dataList.length,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 12,
                      ),
                      itemBuilder: (_, index) => BookmarkCard(
                        bookmark: dataList[index],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}
