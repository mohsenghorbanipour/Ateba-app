import 'dart:ui' as dartui;
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinPutComponent extends StatelessWidget {
  PinPutComponent({
    super.key,
    required this.fieldCount,
    required this.onSubmit,
    this.padding = const EdgeInsets.fromLTRB(20, 20, 20, 16),
    this.withCursor = false,
    this.onChanged,
    this.controller,
  });

  final bool withCursor;
  final int fieldCount;
  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: Directionality(
          textDirection: dartui.TextDirection.ltr,
          child: Pinput(
            autofocus: false,
            // errorBuilder: (val, val2) {
            //   return Container();
            // },

            forceErrorState: false,
            keyboardType: TextInputType.phone,
            onChanged: onChanged,
            focusNode: _pinPutFocusNode,
            controller: controller,
            length: 6,

            defaultPinTheme: PinTheme(
              // margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              width: 100,
              textStyle: TextStyle(
                fontSize: 20,
                color: ColorPalette.of(context).primary,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).background,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            submittedPinTheme: PinTheme(
              // margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              width: 100,
              textStyle: TextStyle(
                fontSize: 20,
                color: ColorPalette.of(context).primary,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).lightPrimary,
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).border,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            focusedPinTheme: PinTheme(
              // margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              width: 100,
              textStyle: TextStyle(
                fontSize: 20,
                color: ColorPalette.of(context).error,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).primary.withOpacity(0.08),
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).primary.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            followingPinTheme: PinTheme(
              // margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              width: 100,
              textStyle: TextStyle(
                fontSize: 20,
                color: ColorPalette.of(context).error,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).white,
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).border,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            disabledPinTheme: PinTheme(
              // margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              width: 100,
              textStyle: TextStyle(
                fontSize: 20,
                color: ColorPalette.of(context).error,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).error.withOpacity(0.08),
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).error.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            errorPinTheme: PinTheme(
              // margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              width: 100,
              textStyle: TextStyle(
                fontSize: 20,
                color: ColorPalette.of(context).error,
                fontWeight: FontWeight.w600,
              ),
              decoration: BoxDecoration(
                color: ColorPalette.of(context).error.withOpacity(0.08),
                border: Border.all(
                  width: 1,
                  color: ColorPalette.of(context).error.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      );
}
