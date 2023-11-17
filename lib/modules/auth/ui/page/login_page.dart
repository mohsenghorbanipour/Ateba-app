// ignore_for_file: use_build_context_synchronously

import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/form_key_ext.dart';
import 'package:ateba_app/core/utils/form_validators.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorPalette.of(context).scaffoldBackground,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 95,
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16, top: 12),
                        child: SvgPicture.asset(Assets.atebaLogoLogin),
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: TextFieldComponent(
                            name: 'phone',
                            initialValue: context
                                .select<AuthBloc, String>((bloc) => bloc.phone),
                            showLabel: false,
                            keyboardType: TextInputType.phone,
                            hintText: '9121234567',
                            textDirection: ui.TextDirection.rtl,
                            textAlign: TextAlign.end,
                            hintDirection: ui.TextDirection.rtl,
                            validators: [
                              FormValidators.required(context),
                              FormValidators.phoneNumber,
                            ],
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 1,
                                  height: 24,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  color: ColorPalette.of(context)
                                      .textPrimary
                                      .withOpacity(0.4),
                                ),
                                Text(
                                  TextInputFormatters.toPersianNumber('98+'),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ButtonComponent(
                          onPressed: () async {
                            if (_formKey.isValid()) {
                              if (await Provider.of<AuthBloc>(context,
                                      listen: false)
                                  .sendCode(
                                TextInputFormatters.toEnglishNumber(
                                  _formKey.getValue('phone'),
                                ),
                              )) {
                                context.goNamed(Routes.loginOtp);
                              }
                            }
                          },
                          loading: context
                              .select<AuthBloc, bool>((bloc) => bloc.loading),
                          margin: const EdgeInsets.only(top: 16, bottom: 48),
                          child: Text(
                            'recive_code'.tr(),
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
        ),
      );
}
