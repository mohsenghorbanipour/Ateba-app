import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NoActiveSubscriptionDialog extends StatelessWidget {
  const NoActiveSubscriptionDialog({
    required this.slug,
    super.key,
  });

  final String slug;

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
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: SvgPicture.asset(
                  Assets.closeIc,
                ),
              ),
            ),
            SvgPicture.asset(
              Assets.noActiveSubscription,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                'no_active_subscription'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              'for_see_videos_just_have_subscription'.tr(),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            ButtonComponent(
              onPressed: () {
                context.pop();
                context.goNamed(
                  Routes.subscriptions,
                  pathParameters: {
                    'slug': slug,
                  },
                );
              },
              height: 40,
              color: Colors.transparent,
              borderSide: BorderSide(
                width: 1,
                color: ColorPalette.of(context).primary,
              ),
              margin: const EdgeInsets.all(16),
              child: Text(
                'recive_subscription'.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorPalette.of(context).textPrimary,
                    ),
              ),
            ),
          ],
        ),
      );
}
