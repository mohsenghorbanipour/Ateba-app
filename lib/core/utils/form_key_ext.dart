import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension FormKeyExt on GlobalKey<FormBuilderState> {
  bool isValid() => currentState?.saveAndValidate() ?? false;
  String getValue(String name) => currentState?.value[name] as String? ?? '';

  // void error(ServerError error) {
  //   for (ServerErrorField field in error.fields ?? []) {
  //     StringBuffer errorText = StringBuffer();
  //     if ((field.property ?? '').isNotEmpty) {
  //       field.errors?.forEach(errorText.writeln);
  //     }
  //     currentState?.invalidateField(name: field.property ?? '', errorText: errorText.toString());
  //     errorText.clear();
  //   }
  // }
}
