// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/input_component.dart';
import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/router/routes.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/form_key_ext.dart';
import 'package:ateba_app/core/utils/form_validators.dart';
import 'package:ateba_app/core/widgets/filed_of_education_modal.dart';
import 'package:ateba_app/core/widgets/select_city_modal.dart';
import 'package:ateba_app/core/widgets/select_gender_input.dart';
import 'package:ateba_app/core/widgets/select_province_modal.dart';
import 'package:ateba_app/core/widgets/universities_modal.dart';
import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
import 'package:ateba_app/modules/edit%20profile/bloc/edit_profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatelessWidget {
  UserInfoWidget({
    required this.user,
    this.isEditProfile = true,
    super.key,
  });

  final User user;
  final bool isEditProfile;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorPalette.of(context).scaffoldBackground,
        body: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: ColorPalette.of(context).textPrimary,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              isEditProfile
                                  ? 'edit_profile'.tr()
                                  : 'complete_your_info'.tr(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (isEditProfile) {
                              Provider.of<EditProfileBloc>(context,
                                      listen: false)
                                  .pickAndCompressImage(context);
                            } else {
                              // Provider.of<CompleteProfileBloc>(context, listen: false)
                              //     .pickAndCompressImage(
                              //   context,
                              // );
                            }
                          },
                          child: Container(
                            width: 84,
                            height: 84,
                            margin: const EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                              color: ColorPalette.of(context).background,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                    color: ColorPalette.of(context).shadow)
                              ],
                            ),
                            child: context.select<EditProfileBloc, bool>(
                                    (bloc) => bloc.pickedImage != null)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(
                                      File(
                                        context.select<EditProfileBloc, String>(
                                            (bloc) =>
                                                bloc.pickedImage?.path ?? ''),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: SvgPicture.asset(
                                      Assets.galleryAddIc,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: TextFieldComponent(
                        name: 'name',
                        textAlign: TextAlign.right,
                        initialValue: user.name,
                        validators: [
                          FormValidators.required(context),
                        ],
                        onChanged: (val) {
                          if (val != user.name) {
                            Provider.of<EditProfileBloc>(context, listen: false)
                                .isEditedProfile = true;
                          } else {
                            Provider.of<EditProfileBloc>(context, listen: false)
                                .isEditedProfile = false;
                          }
                        },
                        keyboardType: TextInputType.name,
                        labelText: 'name'.tr(),
                        hintText: 'name_hint'.tr(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFieldComponent(
                        name: 'email',
                        textAlign: TextAlign.left,
                        initialValue: user.email,
                        validators: [
                          FormValidators.isEmail(context),
                        ],
                        onChanged: (val) {
                          if (val != user.email) {
                            Provider.of<EditProfileBloc>(context, listen: false)
                                .isEditedProfile = true;
                          } else {
                            Provider.of<EditProfileBloc>(context, listen: false)
                                .isEditedProfile = false;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'email'.tr(),
                        hintText: 'emailaddress@gmail.com',
                      ),
                    ),
                    InputComponent(
                      labelText: 'field_of_study'.tr(),
                      margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      hintText: 'select'.tr(),
                      value: context.select<EditProfileBloc, String?>(
                        (bloc) =>
                            bloc.selectedFiled?.title ??
                            AuthBloc().userProfile?.field,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => ChangeNotifierProvider.value(
                            value: Provider.of<EditProfileBloc>(context,
                                listen: false),
                            child: const FieldOfEducationModal(),
                          ),
                        );
                      },
                    ),
                    InputComponent(
                      labelText: 'university_of_study'.tr(),
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      hintText: 'select'.tr(),
                      value: context.select<EditProfileBloc, String?>(
                        (bloc) =>
                            bloc.selectedUniversity?.name ??
                            AuthBloc().userProfile?.university,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => ChangeNotifierProvider.value(
                            value: Provider.of<EditProfileBloc>(context,
                                listen: false),
                            child: const UniversitiesModal(),
                          ),
                        );
                      },
                    ),
                    InputComponent(
                      labelText: 'country'.tr(),
                      margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      hintText: 'select'.tr(),
                      onTap: () {},
                    ),
                    InputComponent(
                      labelText: 'province'.tr(),
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      hintText: 'select'.tr(),
                      value: context.select<EditProfileBloc, String?>(
                        (bloc) =>
                            bloc.selectedProvince?.name ??
                            AuthBloc().userProfile?.province,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => ChangeNotifierProvider.value(
                            value: Provider.of<EditProfileBloc>(context,
                                listen: false),
                            child: const SelectProvinceModal(),
                          ),
                        );
                      },
                    ),
                    InputComponent(
                      labelText: 'city'.tr(),
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      hintText: 'select'.tr(),
                      value: context.select<EditProfileBloc, String?>(
                        (bloc) =>
                            bloc.selectedCity?.name ??
                            AuthBloc().userProfile?.city,
                      ),
                      onTap: () {
                        if (Provider.of<EditProfileBloc>(context, listen: false)
                                .selectedProvince !=
                            null) {
                          Provider.of<EditProfileBloc>(context, listen: false)
                              .loadCities();

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (ctx) => ChangeNotifierProvider.value(
                              value: Provider.of<EditProfileBloc>(context,
                                  listen: false),
                              child: const SelectCityModal(),
                            ),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      child: SelectGenderInput(
                        maleTap: () {
                          Provider.of<EditProfileBloc>(context, listen: false)
                              .gender = Gender.male;
                        },
                        feMaleTap: () {
                          Provider.of<EditProfileBloc>(context, listen: false)
                              .gender = Gender.female;
                        },
                        isMale: context.select<EditProfileBloc, bool>(
                            (bloc) => bloc.gender == Gender.male),
                      ),
                    ),
                  ],
                ),
              ),
              ButtonComponent(
                onPressed: () async {
                  if (isEditProfile && _formKey.isValid()) {
                    if (await Provider.of<EditProfileBloc>(context,
                            listen: false)
                        .editProfile(
                      _formKey.getValue('name'),
                      _formKey.getValue('email'),
                    )) {
                      context.pop();
                    }
                  }
                },
                loading: context.select<EditProfileBloc, bool>(
                    (bloc) => bloc.loadingEditProfile),
                enabled: context.select<EditProfileBloc, bool>(
                    (bloc) => bloc.isEditedProfile),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  'confirm_info'.tr(),
                ),
              )
            ],
          ),
        ),
      );
}
