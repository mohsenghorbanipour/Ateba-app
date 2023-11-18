import 'package:ateba_app/core/components/loading_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/subscription/bloc/subscription_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class SubscriptionDiscountWidget extends StatefulWidget {
  const SubscriptionDiscountWidget({super.key});

  @override
  State<SubscriptionDiscountWidget> createState() =>
      _SubscriptionDiscountWidgetState();
}

class _SubscriptionDiscountWidgetState
    extends State<SubscriptionDiscountWidget> {
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
                          if (controller.text.trim().isNotEmpty &&
                              Provider.of<SubscriptionBloc>(context,
                                          listen: false)
                                      .selectedPlan !=
                                  null) {
                            Provider.of<SubscriptionBloc>(context,
                                    listen: false)
                                .discountPreview(
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
                            child: context.select<SubscriptionBloc, bool>(
                                    (bloc) => bloc.discountPreviewLoading)
                                ? LoadingComponent(
                                    color: ColorPalette.of(context).white,
                                    size: 18,
                                  )
                                : Text(
                                    'check_code'.tr(),
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
                ),
              if (context.select<SubscriptionBloc, bool>(
                  (bloc) => bloc.ordersResponse != null))
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'price_with_discount_code'.tr() +
                            TextInputFormatters.toPersianNumber(
                              context.select<SubscriptionBloc, String>((bloc) =>
                                  bloc.ordersResponse?.price.toString() ?? '0'),
                            ),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: ColorPalette.of(context).primary),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<SubscriptionBloc>(context, listen: false)
                              .applyCode = !Provider.of<SubscriptionBloc>(
                                  context,
                                  listen: false)
                              .applyCode;
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: ColorPalette.of(context).textPrimary,
                                ),
                              ),
                              child: context.select<SubscriptionBloc, bool>(
                                      (bloc) => bloc.applyCode)
                                  ? Center(
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              ColorPalette.of(context).primary,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                'apply_code'.tr(),
                              ),
                            )
                          ],
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
