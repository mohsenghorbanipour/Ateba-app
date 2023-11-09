import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/pinput_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginOtpPage extends StatelessWidget {
  const LoginOtpPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorPalette.of(context).scaffoldBackground,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16, top: 12),
                          child: SvgPicture.asset(Assets.atebaLogoLogin),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: SvgPicture.asset(
                          Assets.loginPattern,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'login_to_account'.tr(),
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: PinPutComponent(
                          fieldCount: 6,
                          onSubmit: (code) {},
                        ),
                      ),
                      ButtonComponent(
                        onPressed: () {
                          context.goNamed(
                            Routes.editProfile,
                            extra: false,
                          );
                        },
                        margin: const EdgeInsets.only(top: 16, bottom: 48),
                        child: Text(
                          'login_to_account'.tr(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.musicIc),
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Text(
                                'support'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color:
                                            ColorPalette.of(context).primary),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
