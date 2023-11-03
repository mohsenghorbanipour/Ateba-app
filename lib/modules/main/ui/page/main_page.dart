// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/main/bloc/main_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorPalette.of(context).scaffoldBackground,
        appBar: AppBar(
          surfaceTintColor: ColorPalette.of(context).background,
          backgroundColor: ColorPalette.of(context).background,
          actions: [
            InkWell(
              onTap: () {
                context.goNamed(
                  Routes.cart,
                );
              },
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.of(context).grey,
                      border: Border.all(
                        width: 1.3,
                        color: ColorPalette.of(context).border,
                      ),
                    ),
                    child: SvgPicture.asset(
                      Assets.basketIc,
                    ),
                  ),
                  if (context.select<CartBloc, bool>(
                      (bloc) => (bloc.ordersResponse?.orders?.length ?? 0) > 0))
                    Positioned(
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorPalette.of(context).error,
                        ),
                        child: Center(
                          child: Text(
                            TextInputFormatters.toPersianNumber(
                                context.select<CartBloc, String>((bloc) => (bloc
                                                .ordersResponse
                                                ?.orders
                                                ?.length ??
                                            0) >=
                                        10
                                    ? '9+'
                                    : (bloc.ordersResponse?.orders?.length ?? 0)
                                        .toString())),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: ColorPalette.of(context).white,
                                ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(
              Assets.atebaLogo,
            ),
          ),
        ),
        body: Column(
          children: [
            Divider(
              height: 1,
              color: ColorPalette.of(context).border,
            ),
            Expanded(
              child: Consumer<MainPageBloc>(
                builder: (context, bloc, child) => bloc.page,
              ),
            )
          ],
        ),
        bottomNavigationBar: Consumer<MainPageBloc>(
          builder: (context, bloc, child) => Container(
            width: double.infinity,
            color: ColorPalette.of(context).background,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 1,
                  color: ColorPalette.of(context).silver,
                ),
                BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: (index) async {
                    bloc.changePage(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              bloc.pageIndex == 0
                                  ? Assets.homeFillIc
                                  : Assets.homeIc,
                            ),
                            if (bloc.pageIndex == 0)
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                    color: ColorPalette.of(context).error,
                                    shape: BoxShape.circle),
                              )
                          ],
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              bloc.pageIndex == 1
                                  ? Assets.searchFillIc
                                  : Assets.searchIc,
                            ),
                            if (bloc.pageIndex == 1)
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                    color: ColorPalette.of(context).error,
                                    shape: BoxShape.circle),
                              )
                          ],
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              bloc.pageIndex == 2
                                  ? Assets.categoryFillIc
                                  : Assets.categoryIc,
                            ),
                            if (bloc.pageIndex == 2)
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                    color: ColorPalette.of(context).primary,
                                    shape: BoxShape.circle),
                              )
                          ],
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              bloc.pageIndex == 3
                                  ? Assets.archiveFillIc
                                  : Assets.archiveIc,
                            ),
                            if (bloc.pageIndex == 3)
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                    color: ColorPalette.of(context).error,
                                    shape: BoxShape.circle),
                              )
                          ],
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              bloc.pageIndex == 4
                                  ? Assets.personeFillIc
                                  : Assets.personeIc,
                            ),
                            if (bloc.pageIndex == 4)
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(top: 2),
                                decoration: BoxDecoration(
                                    color: ColorPalette.of(context).error,
                                    shape: BoxShape.circle),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
