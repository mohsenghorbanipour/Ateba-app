// ignore_for_file: non_constant_identifier_names

import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

typedef Validator = String? Function(dynamic param);

class FormValidators {
  static Validator required(BuildContext context) =>
      FormBuilderValidators.required(
        errorText: "required_text_error".tr(),
      );

  static String? phoneNumber(String? text) => RegExp('^9\\d{9}\$')
          .hasMatch(TextInputFormatters.toEnglishNumber(text ?? ''))
      ? null
      : 'wrong_phone'.tr();

  static FormFieldValidator<String> isEmail(BuildContext context) =>
      FormBuilderValidators.email(
        errorText: "wrong_email".tr(),
      );
}
