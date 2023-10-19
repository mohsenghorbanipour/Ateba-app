import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:ateba_app/modules/bookmarks/ui/widgets/bookmarks_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<BookmarksBloc>(context, listen: false)
                      .showBookmarksState =
                  !Provider.of<BookmarksBloc>(context, listen: false)
                      .showBookmarksState;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).border,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        context
                            .select<BookmarksBloc, String>(
                              (bloc) => bloc.bookmarksStates.name,
                            )
                            .tr(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Text(
                          context.select<BookmarksBloc, bool>((bloc) =>
                                  bloc.bookmarksStates ==
                                  BookmarksStates.my_products)
                              ? 'course_and_packages'.tr()
                              : context.select<BookmarksBloc, bool>((bloc) =>
                                      bloc.bookmarksStates ==
                                      BookmarksStates.bookmarks)
                                  ? 'toturials'.tr()
                                  : '',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: ColorPalette.of(context)
                                        .textPrimary
                                        .withOpacity(0.85),
                                  ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedRotation(
                    turns: context.select<BookmarksBloc, bool>(
                            (bloc) => bloc.showBookmarksState)
                        ? 2
                        : 1,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      context.select<BookmarksBloc, bool>(
                              (bloc) => bloc.showBookmarksState)
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                    ),
                  )
                ],
              ),
            ),
          ),
          if (context
              .select<BookmarksBloc, bool>((bloc) => bloc.showBookmarksState))
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).border,
                ),
              ),
              child: Column(
                children: [
                  BookmarksTile(
                    title: 'my_products'.tr(),
                    subTitle: 'course_and_packages'.tr(),
                    onTap: () {
                      Provider.of<BookmarksBloc>(context, listen: false)
                          .bookmarksStates = BookmarksStates.my_products;
                    },
                    selected: context.select<BookmarksBloc, bool>((bloc) =>
                        bloc.bookmarksStates == BookmarksStates.my_products),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: BookmarksTile(
                      title: 'bookmarks'.tr(),
                      subTitle: 'toturials'.tr(),
                      onTap: () {
                        Provider.of<BookmarksBloc>(context, listen: false)
                            .bookmarksStates = BookmarksStates.bookmarks;
                      },
                      selected: context.select<BookmarksBloc, bool>((bloc) =>
                          bloc.bookmarksStates == BookmarksStates.bookmarks),
                    ),
                  ),
                  BookmarksTile(
                    title: 'ofline_gallery'.tr(),
                    onTap: () {
                      Provider.of<BookmarksBloc>(context, listen: false)
                          .bookmarksStates = BookmarksStates.ofline_gallery;
                    },
                    selected: context.select<BookmarksBloc, bool>((bloc) =>
                        bloc.bookmarksStates == BookmarksStates.ofline_gallery),
                  ),
                ],
              ),
            )
        ],
      );
}
