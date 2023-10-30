import 'package:ateba_app/core/components/loading_component.dart';
import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/cart/bloc/cart_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class CartDiscountWidget extends StatefulWidget {
  const CartDiscountWidget({super.key});

  @override
  State<CartDiscountWidget> createState() => _CartDiscountWidgetState();
}

class _CartDiscountWidgetState extends State<CartDiscountWidget> {
  final TextEditingController controller = TextEditingController();

  bool enterCode = false;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: ColorPalette.of(context).extraLightSilver,
          border: Border.all(
            width: 1,
            color: ColorPalette.of(context).border,
          ),
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    enterCode = !enterCode;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'have_discount_code'.tr(),
                    ),
                    AnimatedRotation(
                      turns: enterCode ? 2 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        enterCode
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                      ),
                    )
                  ],
                ),
              ),
              if (enterCode)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: TextField(
                            controller: controller,
                            textDirection: intl.Bidi.detectRtlDirectionality(
                                    controller.text)
                                ? ui.TextDirection.rtl
                                : ui.TextDirection.ltr,
                            style: Theme.of(context).textTheme.labelMedium,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              hintStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    color: ColorPalette.of(context).border,
                                    width: 1),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    color: ColorPalette.of(context).border,
                                    width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.of(context).error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.of(context).error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.of(context).primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.text.trim().isNotEmpty) {
                            Provider.of<CartBloc>(context, listen: false)
                                .applyDiscount(
                              controller.text,
                            );
                          }
                        },
                        child: Container(
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ColorPalette.of(context).error,
                          ),
                          child: Center(
                            child: context.select<CartBloc, bool>(
                                    (bloc) => bloc.applyDiscountLoading)
                                ? LoadingComponent(
                                    color: ColorPalette.of(context).white,
                                    size: 18,
                                  )
                                : Text(
                                    'apply_code'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: ColorPalette.of(context).white,
                                        ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      );
}
