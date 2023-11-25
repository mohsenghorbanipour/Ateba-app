import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/logger_helper.dart';
import 'package:ateba_app/modules/search/bloc/search_bloc.dart';
import 'package:ateba_app/modules/search/data/models/filter.dart';
import 'package:ateba_app/modules/search/ui/widgets/filter_chip_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) => Consumer<SearchBloc>(
        builder: (context, bloc, child) => Column(
          children: [
            SizedBox(
              height: 32,
              width: double.infinity,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: bloc.filters.length,
                separatorBuilder: (_, __) => const SizedBox(
                  width: 10,
                ),
                itemBuilder: (context, index) => FilterChipWidget(
                  filter: bloc.filters[index],
                  selected: bloc.selectedFilter == bloc.filters[index],
                ),
              ),
            ),
            if (bloc.loading)
              const ShimmerContainer(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                height: 300,
              )
            else if (bloc.results.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: LazyLoadScrollView(
                    onEndOfPage: () async {
                      if (Provider.of<SearchBloc>(context, listen: false)
                          .canLoadMore) {
                        await Provider.of<SearchBloc>(context, listen: false)
                            .loadMoreSearch();
                      }
                    },
                    isLoading: context
                        .select<SearchBloc, bool>((bloc) => bloc.loadingMore),
                    child: ListView(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: ColorPalette.of(context).border,
                            ),
                            borderRadius: BorderRadius.circular(6),
                            color: ColorPalette.of(context).background,
                          ),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bloc.results.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                              color: ColorPalette.of(context)
                                  .textPrimary
                                  .withOpacity(0.2),
                            ),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                switch (bloc.results[index].link_to?.type) {
                                  case 'tutorial':
                                    context.goNamed(Routes.tutorialDetails,
                                        pathParameters: {
                                          'slug': bloc.results[index].link_to
                                                  ?.slug ??
                                              '',
                                        });
                                    break;
                                  case 'course':
                                    context.goNamed(
                                      Routes.courseDetails,
                                      pathParameters: {
                                        'slug':
                                            bloc.results[index].link_to?.slug ??
                                                '',
                                      },
                                    );
                                    break;
                                  case 'package':
                                    context.goNamed(
                                      Routes.packageDetails,
                                      pathParameters: {
                                        'slug':
                                            bloc.results[index].link_to?.slug ??
                                                '',
                                      },
                                    );
                                    break;
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                width: double.infinity,
                                height: 38,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      bloc.results[index].type == 'attachment'
                                          ? Assets.attachmentIc
                                          : bloc.results[index].type ==
                                                  'tutorial'
                                              ? Assets.videoIc
                                              : Assets.courseIc,
                                      width: 18,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: Text(
                                        bloc.results[index].title ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorPalette.of(context).border,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        Assets.emptyImg,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'not_fount_items'.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      );
}
