import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/categories/ui/widgets/tab_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            Expanded(
              child: TabItemWidget(
                title: 'ateba_needs'.tr(),
                selected: context.select<CategoriesBloc, bool>(
                    (bloc) => bloc.tabState == TabState.educationalVideos),
                onTap: () {
                  Provider.of<CategoriesBloc>(context, listen: false).tabState =
                      TabState.educationalVideos;
                },
              ),
            ),
            Expanded(
              child: PopupMenuButton(
                padding: EdgeInsets.zero,
                onOpened: () {
                  Provider.of<CategoriesBloc>(context, listen: false)
                      .showDataTypeMenu = true;
                },
                onCanceled: () {
                  Provider.of<CategoriesBloc>(context, listen: false)
                      .showDataTypeMenu = false;
                },
                color: ColorPalette.of(context).background,
                elevation: 0,
                offset: const Offset(10, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    width: 1,
                    color: ColorPalette.of(context).border,
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: null,
                    enabled: false,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Provider.of<CategoriesBloc>(context, listen: false)
                                    .categoriesDataType =
                                CategoriesDataType.medicalCourses;
                            context.pop();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 35,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: ColorPalette.of(context)
                                            .textPrimary,
                                      ),
                                    ),
                                    child: Container(
                                      width: 5,
                                      height: 5,
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Provider.of<CategoriesBloc>(
                                                          context,
                                                          listen: false)
                                                      .categoriesDataType ==
                                                  CategoriesDataType
                                                      .medicalCourses
                                              ? ColorPalette.of(context).primary
                                              : Colors.transparent),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    'medical_courses'.tr(),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Provider.of<CategoriesBloc>(context, listen: false)
                                    .categoriesDataType =
                                CategoriesDataType.educationalPackages;
                            context.pop();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 35,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color:
                                          ColorPalette.of(context).textPrimary,
                                    ),
                                  ),
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Provider.of<CategoriesBloc>(
                                                        context,
                                                        listen: false)
                                                    .categoriesDataType ==
                                                CategoriesDataType
                                                    .educationalPackages
                                            ? ColorPalette.of(context).primary
                                            : Colors.transparent),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    'educational_packages'.tr(),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                child: TabItemWidget(
                  title: context.select<CategoriesBloc, String>((bloc) =>
                      bloc.categoriesDataType ==
                              CategoriesDataType.medicalCourses
                          ? 'medical_courses'.tr()
                          : 'educational_packages'.tr()),
                  selected: context.select<CategoriesBloc, bool>(
                      (bloc) => bloc.tabState == TabState.clinicalPackages),
                  onTap: () {
                    Provider.of<CategoriesBloc>(context, listen: false)
                        .tabState = TabState.clinicalPackages;
                    Provider.of<CategoriesBloc>(context, listen: false)
                        .loadCategoryData();
                  },
                  showMenu: context.select<CategoriesBloc, bool>(
                      (bloc) => bloc.showDataTypeMenu),
                  disableOnTap: context.select<CategoriesBloc, bool>(
                      (bloc) => bloc.tabState == TabState.clinicalPackages),
                  showArrowIcon: true,
                ),
              ),
            )
          ],
        ),
      );
}
