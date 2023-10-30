import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/core/utils/text_input_formatters.dart';
import 'package:ateba_app/modules/subscription/bloc/subscription_bloc.dart';
import 'package:ateba_app/modules/subscription/data/models/subscription_plan.dart';
import 'package:ateba_app/modules/subscription/ui/widgets/subscription_discount_widget.dart';
import 'package:ateba_app/modules/subscription/ui/widgets/subscription_plan_shimmer_tile.dart';
import 'package:ateba_app/modules/subscription/ui/widgets/subscription_plan_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => SubscriptionBloc()..loadSubscriptionPlans(),
        lazy: false,
        builder: (context, child) => Scaffold(
          backgroundColor: ColorPalette.of(context).scaffoldBackground,
          body: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(bottom: 200),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
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
                              color: ColorPalette.of(context).background,
                              border: Border.all(
                                width: 1,
                                color: ColorPalette.of(context).border,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 16,
                              color: ColorPalette.of(context).primary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            'buy_video_subscriptions'.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Image.asset(
                      Assets.subscriptionVideoImg,
                    ),
                  ),
                  if (context
                      .select<SubscriptionBloc, bool>((bloc) => bloc.loading))
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: 5,
                      itemBuilder: (_, __) =>
                          const SubscriptionPlatShimmerTile(),
                    )
                  else
                    Selector<SubscriptionBloc, List<SubscriptionPlan>>(
                      selector: (context, bloc) => bloc.plans,
                      builder: (context, plans, child) => ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: plans.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 12,
                        ),
                        itemBuilder: (context, index) => SubscriptionPlanTile(
                          subscriptionPlan: plans[index],
                        ),
                      ),
                    ),
                ],
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 28,
                child: Column(
                  children: [
                    const SubscriptionDiscountWidget(),
                    const SizedBox(
                      height: 24,
                    ),
                    ButtonComponent(
                      onPressed: () {
                        if (Provider.of<SubscriptionBloc>(context,
                                    listen: false)
                                .selectedPlan !=
                            null) {
                          Provider.of<SubscriptionBloc>(context, listen: false)
                              .payment();
                        }
                      },
                      height: 40,
                      child: Text(
                        'payment'.tr() +
                            context.select<SubscriptionBloc,
                                String>((bloc) => bloc.selectedPlan !=
                                    null
                                ? ' - ${TextInputFormatters.toPersianNumber((bloc.selectedPlan?.price ?? 0).toString())}'
                                : ''),
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
