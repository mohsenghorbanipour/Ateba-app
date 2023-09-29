import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/categories/ui/widgets/tab_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesTabWidget extends StatelessWidget {
  const CategoriesTabWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 40,
        margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorPalette.of(context).background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
        ),
        child: Row(
          children: [
            TabItemWidget(
              title: 'educational_videos'.tr(),
              selected: context.select<CategoriesBloc, bool>(
                  (bloc) => bloc.tabState == TabState.educationalVideos),
              onTap: () {
                Provider.of<CategoriesBloc>(context, listen: false).tabState =
                    TabState.educationalVideos;
              },
            ),
            TabItemWidget(
              title: 'clinical_packages'.tr(),
              selected: context.select<CategoriesBloc, bool>(
                  (bloc) => bloc.tabState == TabState.clinicalPackages),
              onTap: () {
                Provider.of<CategoriesBloc>(context, listen: false).tabState =
                    TabState.clinicalPackages;
              },
            ),
          ],
        ),
      );
}
