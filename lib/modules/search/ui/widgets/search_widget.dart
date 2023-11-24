import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/search/bloc/search_bloc.dart';
import 'package:ateba_app/modules/search/ui/dialogs/categories_filter_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: TextFieldComponent(
                name: 'query',
                controller: context.select<SearchBloc, TextEditingController>(
                    (bloc) => bloc.controller),
                textAlign: TextAlign.right,
                showLabel: false,
                prefixIcon: context.select<SearchBloc, bool>(
                        (bloc) => bloc.controller.text.isNotEmpty)
                    ? InkWell(
                        onTap: () {
                          Provider.of<SearchBloc>(context, listen: false)
                              .controller
                              .clear();
                          Provider.of<SearchBloc>(context, listen: false)
                              .query = '';
                        },
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.closeIc,
                            ),
                          ),
                        ),
                      )
                    : null,
                onChanged: (val) {
                  Provider.of<SearchBloc>(context, listen: false).query = val;
                },
                hintText: 'search_education_lable'.tr(),
                suffixIcon: context.select<SearchBloc, bool>(
                        (bloc) => bloc.controller.text.isNotEmpty)
                    ? InkWell(
                        onTap: () {
                          Provider.of<SearchBloc>(context, listen: false)
                              .search();
                        },
                        child: SizedBox(
                          width: 32,
                          child: Center(
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.of(context).border,
                              ),
                              child: Icon(
                                Icons.search,
                                size: 18,
                                color: ColorPalette.of(context).textPrimary,
                              ),
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            InkWell(
              onTap: () {
                showAnimatedDialog(
                  context: context,
                  curve: Curves.easeIn,
                  animationType: DialogTransitionType.fade,
                  duration: const Duration(milliseconds: 300),
                  builder: (context) => const CategoriesFilterDialog(),
                );
              },
              child: Container(
                width: 48,
                height: 48,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                    color: ColorPalette.of(context).border,
                  ),
                  color: ColorPalette.of(context).background,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.filterIc,
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
