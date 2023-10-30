import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/subscription/bloc/subscription_bloc.dart';
import 'package:ateba_app/modules/subscription/data/models/subscription_plan.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionPlanTile extends StatelessWidget {
  const SubscriptionPlanTile({
    required this.subscriptionPlan,
    super.key,
  });

  final SubscriptionPlan subscriptionPlan;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Provider.of<SubscriptionBloc>(context, listen: false).selectedPlan =
              subscriptionPlan;
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorPalette.of(context).background,
            border: Border.all(
              width: 1,
              color: ColorPalette.of(context).border,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                            (bloc) => bloc.selectedPlan == subscriptionPlan)
                        ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.of(context).primary,
                              ),
                            ),
                          )
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      subscriptionPlan.title ?? '',
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorPalette.of(context).lightGrey,
                ),
                child: Center(
                  child: Text(
                    '${TextInputFormatters.toPersianNumber(
                      subscriptionPlan.price.toString(),
                    )} ${'toman'.tr()}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 8,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
