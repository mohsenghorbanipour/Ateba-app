import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/debouncer.dart';
import 'package:ateba_app/modules/fast%20search/bloc/fase_search_bloc.dart';
import 'package:ateba_app/modules/fast%20search/ui/widget/fast_search_result_widget.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FastSearchPage extends StatelessWidget {
  FastSearchPage({
    this.query,
    super.key,
  });

  final String? query;

  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => FastSearchBloc()
          ..search(
            query ?? '',
            isSuggested: query?.isNotEmpty ?? false,
          ),
        lazy: false,
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          appBar: PreferredSize(
            preferredSize: const Size(
              double.infinity,
              50,
            ),
            child: Container(
              color: ColorPalette.of(context).background,
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                textAlign: TextAlign.right,
                onChanged: (val) {
                  if ((val).length > 2) {
                    _debouncer.run(
                      () {
                        Provider.of<FastSearchBloc>(context, listen: false)
                            .search(
                          val,
                        );
                      },
                    );
                  }
                },
                autofocus: true,
                initialValue: query,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: SvgPicture.asset(
                          Assets.closeIc,
                        ),
                      ),
                    ],
                  ),
                  hintText: context.select<HomeBloc, String>(
                    (bloc) => bloc.suggestions?.search_placeholder ?? '',
                  ),
                  hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: ColorPalette.of(context)
                            .textPrimary
                            .withOpacity(0.5),
                      ),
                  fillColor: ColorPalette.of(context).background,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          body: Consumer<FastSearchBloc>(
            builder: (context, bloc, child) => bloc.loading
                ? const ShimmerContainer(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(16, 24, 16, 16),
                    height: 300,
                  )
                : bloc.result.isNotEmpty
                    ? FastSearchResultWidget(
                        results: bloc.result,
                      )
                    : SizedBox(
                        width: double.infinity,
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
                      ),
          ),
        ),
      );
}
