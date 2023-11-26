import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:ateba_app/modules/bookmarks/bloc/bookmarks_bloc.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:ateba_app/modules/categories/bloc/categories_bloc.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/main/bloc/main_page_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: ColorPalette.of(context).background,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: SvgPicture.asset(
                      Assets.closeIc,
                    ),
                  ),
                ),
                Text(
                  'logout_from_account'.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonComponent(
                      onPressed: () {
                        Provider.of<AuthBloc>(context, listen: false).logout();
                        Provider.of<MainPageBloc>(context, listen: false).clearData();
                        Provider.of<HomeBloc>(context, listen: false)
                            .clearData();
                        Provider.of<CategoriesBloc>(context, listen: false)
                            .clearData();
                        Provider.of<BookmarksBloc>(context, listen: false)
                            .clearData();
                        Provider.of<CartBloc>(context, listen: false)
                            .clearData();
                        context.goNamed(
                          Routes.login,
                        );
                      },
                      height: 40,
                      color: Colors.transparent,
                      borderSide: BorderSide(
                        width: 1.2,
                        color: ColorPalette.of(context).error,
                      ),
                      child: Text(
                        'yes'.tr(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: ColorPalette.of(context).error,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ButtonComponent(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      height: 40,
                      color: Colors.transparent,
                      child: Text('back'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: ColorPalette.of(context).primary)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
